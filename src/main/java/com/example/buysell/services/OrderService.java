package com.example.buysell.services;

import com.example.buysell.models.*;
import com.example.buysell.repositories.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class OrderService {
    private final CartRepository cartRepository;
    private final OrderRepository orderRepository;
    private final AddressRepository addressRepository;
    private final OrderProductRepository orderProductRepository;

    public void addOrder(Cart cart, String payment, String orderComment, String offlineShop,
                         String  city, String street, int houseNumber, int apartmentNumber, int floor, int entrance) {

        // Создание нового заказа
        Order order = new Order();

        // Установка свойств заказа
        order.setCart(cart);
        order.setOrderDate(LocalDateTime.now());
        order.setDeliveryMethod(offlineShop);
        order.setStatus("Ваш заказ на обработке!"); // Статус заказа по умолчанию
        order.setPaymentMethod(payment);
        order.setOrderComment(orderComment);
        order.setUser(cart.getUser());
        orderRepository.save(order);

        // Создание и установка адреса
        Address address = new Address();
        if(offlineShop.equals("Пр.Победителей, 9, ТРЦ \"Галерея\"")){
            address.setCity("Минск");
            address.setStreet("Пр.Победителей, 9, ТРЦ \"Галерея\"");
            address.setHouseNumber(0);
            address.setApartmentNumber(0);
            address.setFloor(0);
            address.setEntrance(0);
            address.setOrder(order);
            addressRepository.save(address);
        }
        else if(offlineShop.equals("Пр.Победителей, 65, ТЦ \"Замок\"")){
            address.setCity("Минск");
            address.setStreet("Пр.Победителей, 65, ТЦ \"Замок\"");
            address.setHouseNumber(0);
            address.setApartmentNumber(0);
            address.setFloor(0);
            address.setEntrance(0);
            address.setOrder(order);
            addressRepository.save(address);
        }
        else{
            address.setCity(city);
            address.setStreet(street);
            address.setHouseNumber(houseNumber);
            address.setApartmentNumber(apartmentNumber);
            address.setFloor(floor);
            address.setEntrance(entrance);
            address.setOrder(order);
            addressRepository.save(address);
        }

        order.setAddress(address);

        // Создание списка OrderProduct
        List<OrderProduct> orderProducts = new ArrayList<>();

        // Проход по продуктам в корзине и создание объектов OrderProduct
        for (CartProduct cartProduct : cart.getCartProducts()) {
            OrderProduct orderProduct = new OrderProduct();
            orderProduct.setOrder(order);
            orderProduct.setProduct(cartProduct.getProduct());
            orderProduct.setQuantity(cartProduct.getQuantity());
            orderProductRepository.save(orderProduct);
            orderProducts.add(orderProduct);
        }

        // Установка списка OrderProduct в заказ
        order.setOrderProducts(orderProducts);

        // Сохранение заказа в репозитории
        orderRepository.save(order);

        // Очистка корзины
        cart.getCartProducts().clear();
        cartRepository.save(cart);
    }

    public void  calculateTotalPrice(List<Order> orders) {
        for (Order order : orders) {
            double totalPrice = 0.0;

            for (OrderProduct orderProduct : order.getOrderProducts()) {
                int quantity = orderProduct.getQuantity(); // Получаем количество единиц товара из OrderProduct
                Product product = orderProduct.getProduct(); // Получаем связанный с OrderProduct товар
                totalPrice += product.getPrice() * quantity; // Умножаем стоимость продукта на количество
            }

            order.setTotalPrice(totalPrice); // Устанавливаем вычисленную итоговую стоимость в Order

            // Сохраняем изменения в репозитории
            orderRepository.save(order);
        }
    }

    public double  calculateRansomAmount(List<Order> orders) {
        double ransomAmount = 0.0;
        for (Order order : orders) {
            ransomAmount+=order.getTotalPrice();
        }
        return ransomAmount;
    }

    public List<Order> getOrdersByUser(User user) {
        return orderRepository.findByUser(user);
    }

    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }
}

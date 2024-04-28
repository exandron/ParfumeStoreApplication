package com.example.buysell.controllers;

import com.example.buysell.models.*;
import com.example.buysell.services.CartService;
import com.example.buysell.services.OrderService;
import com.example.buysell.services.ProductService;
import com.example.buysell.services.UserService;
import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class OrderController {
    private final ProductService productService;
    private final UserService userService;
    private final CartService cartService;
    private final OrderService orderService;

    @GetMapping("/order")
    public String showOrderPage(Principal principal, Model model) {
        User user = userService.getUserByPrincipal(principal);

        // Получение корзины пользователя
        Cart cart = user.getCart();

        double totalPrice = cartService.calculateTotalPrice(cart);
        // Получение списка CartProduct в корзине
        List<CartProduct> cartProducts = cart.getCartProducts();

        model.addAttribute("user", productService.getUserByPrincipal(principal));
        // Добавление списка продуктов в модель
        model.addAttribute("cartProducts", cartProducts);

        // Создание списка продуктов
        List<Product> products = new ArrayList<>();
        for (CartProduct cartProduct : cartProducts) {
            products.add(cartProduct.getProduct());
        }
        model.addAttribute("products", products);
        model.addAttribute("cart", cart);
        model.addAttribute("totalPrice", totalPrice);
        return "order";
    }

    @PostMapping("/order/{id}")
    public String addOrder(@PathVariable Long id,
                            Principal principal,
                            @RequestParam("payment") String payment,
                           @RequestParam(value = "orderComment", defaultValue = "None") String orderComment,
                           @RequestParam(value = "offlineShop", defaultValue = "None") String offlineShop,
                           @RequestParam(value = "city", defaultValue = "Minsk") String city,
                            @RequestParam(value = "street", defaultValue = "None") String street,
                           @RequestParam(value = "houseNumber", defaultValue = "0") int houseNumber,
                            @RequestParam(value = "apartmentNumber", defaultValue = "0") int apartmentNumber,
                           @RequestParam(value = "floor", defaultValue = "0") int floor,
                           @RequestParam(value = "entrance", defaultValue = "0") int entrance) {
        User user = userService.getUserByPrincipal(principal);
        Cart cart = cartService.getCartByUser(user);
        orderService.addOrder(cart, payment, orderComment, offlineShop, city, street, houseNumber, apartmentNumber, floor, entrance);
        return "redirect:/order/my-orders"; // или верните имя шаблона
    }

    @GetMapping("/order/my-orders")
    public String showOrders(Principal principal, Model model) {
        // Получение текущего пользователя по email из Principal
        User user = userService.getUserByPrincipal(principal);

        // Получение списка заказов пользователя
        List<Order> orders = orderService.getOrdersByUser(user);
        orderService.calculateTotalPrice(orders);
        double ransomAmount =  orderService.calculateRansomAmount(orders);
        model.addAttribute("user", productService.getUserByPrincipal(principal));
        model.addAttribute("orders", orders);
        model.addAttribute("ransomAmount", ransomAmount);
        return "my-orders";
    }

    @GetMapping("/order/statistics")
    public String showOrdersStatistics(Principal principal, Model model) {
        // Получение текущего пользователя по email из Principal
        User user = userService.getUserByPrincipal(principal);

        // Получение списка заказов пользователя
        List<Order> orders = orderService.getAllOrders();
        model.addAttribute("user", productService.getUserByPrincipal(principal));
        model.addAttribute("orders", orders);

        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.registerModule(new JavaTimeModule());
        String ordersJson;
        try {
            ordersJson = objectMapper.writeValueAsString(orders);
        } catch (JsonProcessingException e) {
            // Обработка ошибки преобразования в JSON, если необходимо
            e.printStackTrace();
            ordersJson = "[]"; // Назначьте значение по умолчанию в случае ошибки
        }
        model.addAttribute("ordersJson", ordersJson);
        System.out.println(ordersJson);
        return "order-statistics";
    }

    @GetMapping("/order/printOrders")
    public String printOrders(Principal principal, Model model){
        // Получение текущего пользователя по email из Principal
        User user = userService.getUserByPrincipal(principal);

        // Получение списка заказов пользователя
        List<Order> orders = orderService.getOrdersByUser(user);
        orderService.calculateTotalPrice(orders);
        model.addAttribute("user", productService.getUserByPrincipal(principal));
        model.addAttribute("orders", orders);

        // Путь к файлу, в который будут записаны заказы
        String filePath = "D:\\6 семестр\\КП СТОЭИ\\buysell\\orders.txt";

        try (PrintWriter writer = new PrintWriter(new FileWriter(filePath))) {
            for (Order order : orders) {
                // Запись информации о каждом заказе в файл
                writer.println("Заказ #" + order.getId());
                writer.println("Содержимое заказа: ");
                for (OrderProduct product : order.getOrderProducts()) {
                    writer.println(product.getProduct().getTitle() + " - " + product.getProduct().getPrice() + "РУБ. - " + product.getQuantity() + "ед.");
                }
                writer.println("Способ оплаты: " + order.getPaymentMethod());
                writer.println("Дата оформления: " + order.getOrderDate());
                writer.println("Суммарная стоимость заказа: " + order.getTotalPrice());
                writer.println("------------------------");
            }
        } catch (IOException e) {
            // Обработка ошибки, если возникнет проблема с записью в файл
            e.printStackTrace();
        }
        return "redirect:/order/my-orders";
    }
}

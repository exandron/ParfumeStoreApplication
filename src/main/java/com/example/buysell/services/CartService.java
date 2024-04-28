package com.example.buysell.services;

import com.example.buysell.models.Cart;
import com.example.buysell.models.CartProduct;
import com.example.buysell.models.Product;
import com.example.buysell.models.User;
import com.example.buysell.repositories.CartProductRepository;
import com.example.buysell.repositories.ProductRepository;
import com.example.buysell.repositories.UserRepository;
import com.example.buysell.repositories.CartRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.security.Principal;

@Service
@Slf4j
@RequiredArgsConstructor
public class CartService {
    private final ProductRepository productRepository;
    private final UserRepository userRepository;
    private final CartRepository cartRepository;
    private final CartProductRepository cartProductRepository;

    public void addToCart(User user, Product product, int quantity) {
        Cart cart = getCartByUser(user);

        if (cart == null) {
            cart = new Cart();
            cart.setUser(user);
        }
        cartRepository.save(cart);

        CartProduct cartProduct = cartProductRepository.findCartProductByProductAndCart(product, cart);
        if (cartProduct != null) {
            int currentQuantity = cartProduct.getQuantity();
            cartProduct.setQuantity(currentQuantity + quantity);
        } else {
            cartProduct = new CartProduct();
            cartProduct.setCart(cart);
            cartProduct.setProduct(product);
            cartProduct.setQuantity(quantity);
        }

        cartProductRepository.save(cartProduct); // Сохранение сущности CartProduct
        cart.getCartProducts().add(cartProduct);

        cartRepository.save(cart);
    }

    public Cart getCartByUser(User user) {
        return cartRepository.findByUser(user);
    }


    public void deleteProduct(User user, Long id) {
        // Получение корзины пользователя
        Cart cart = user.getCart();

        // Поиск CartProduct в корзине по ID товара
        CartProduct cartProduct = cart.getCartProducts().stream()
                .filter(cp -> cp.getProduct().getId().equals(id))
                .findFirst()
                .orElse(null);

        // Если CartProduct найден, удаляем его из корзины
        if (cartProduct != null) {
            cart.getCartProducts().remove(cartProduct);
            // Можете выполнить другие операции, связанные с удалением товара, если необходимо
        }

        // Сохранение обновленной корзины
        cartRepository.save(cart);
    }

    public double calculateTotalPrice(Cart cart) {
        double totalPrice = 0.0;

        for (CartProduct cartProduct : cart.getCartProducts()) {
            int quantity = cartProduct.getQuantity(); // Получаем количество единиц товара из CartProduct
            Product product = cartProduct.getProduct(); // Получаем связанный с CartProduct товар

            totalPrice += product.getPrice() * quantity; // Умножаем стоимость продукта на количество
        }

        return totalPrice;
    }
}

package com.example.buysell.controllers;

import com.example.buysell.models.Cart;
import com.example.buysell.models.CartProduct;
import com.example.buysell.models.Product;
import com.example.buysell.models.User;
import com.example.buysell.services.CartService;
import com.example.buysell.services.ProductService;
import com.example.buysell.services.UserService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class CartController {
    private final ProductService productService;
    private final UserService userService;
    private final CartService cartService;

    @PostMapping("/cart/{id}")
    public String addToCart(@PathVariable Long id,
                            Principal principal,
                            @RequestParam("quantity") int quantity) {
        User user = userService.getUserByPrincipal(principal);
        Product product = productService.getProductById(id);
        cartService.addToCart(user, product, quantity);
        return "redirect:/cart"; // или верните имя шаблона
    }

    @GetMapping("/cart")
    public String cart(Principal principal, Model model) {
        // Получение текущего пользователя по email из Principal
        User user = userService.getUserByPrincipal(principal);

        // Получение корзины пользователя
        Cart cart = cartService.getCartByUser(user);

        if (cart == null) {
            cartService.initCart(user);
        }

        double totalPrice = cartService.calculateTotalPrice(cart);

        // Получение списка CartProduct в корзине
        List<CartProduct> cartProducts = cart.getCartProducts();

        model.addAttribute("user", productService.getUserByPrincipal(principal));
        // Добавление списка CartProduct в модель
        model.addAttribute("cartProducts", cartProducts);

        // Создание списка продуктов
        List<Product> products = new ArrayList<>();
        for (CartProduct cartProduct : cartProducts) {
            products.add(cartProduct.getProduct());
        }
        model.addAttribute("products", products);

        model.addAttribute("cart", cart);
        model.addAttribute("totalPrice", totalPrice);
        return "cart";
    }

    @PostMapping("/cart/delete/{id}")
    public String deleteProduct(@PathVariable Long id, Principal principal) {
        cartService.deleteProduct(userService.getUserByPrincipal(principal), id);
        return "redirect:/cart";
    }
}

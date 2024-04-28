package com.example.buysell.controllers;

import com.example.buysell.models.User;
import com.example.buysell.services.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.security.Principal;

@Controller
@RequiredArgsConstructor
public class ContactPageController {
    private final ProductService productService;

    @GetMapping("/contact-page")
    public String aboutUs(Principal principal, Model model) {
        User user = productService.getUserByPrincipal(principal);
        model.addAttribute("user", user);
        model.addAttribute("products", user.getProducts());
        return "contact-page";
    }
}

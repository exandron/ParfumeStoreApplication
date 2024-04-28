package com.example.buysell.controllers;

import com.example.buysell.models.Order;
import com.example.buysell.models.User;
import com.example.buysell.models.enums.Role;
import com.example.buysell.services.UserService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@PreAuthorize("hasAuthority('ROLE_ADMIN')")
public class AdminController {
    private final UserService userService;

    @GetMapping("/admin")
    public String admin(Model model, Principal principal) {
        model.addAttribute( "users", userService.list());
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        return "admin";
    }

    @PostMapping("/admin/user/ban/{id}")
    public String userBan(@PathVariable("id") Long id) {
        userService.banUser(id);
        return "redirect:/admin";
    }

    @PostMapping("/admin/user/delete/{id}")
    public String userDelete(@PathVariable("id") Long id) {
        userService.deleteUser(id);
        return "redirect:/admin";
    }

    @GetMapping("/admin/user/edit/{user}")
    public String userEdit(@PathVariable("user") User user, Model model, Principal principal) {
        model.addAttribute("user", user);
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        model.addAttribute("roles", Role.values());
        return "user-edit";
    }

    @PostMapping("/admin/user/edit")
    public String userEdit(@RequestParam("userId") User user, @RequestParam Map<String, String> form) {
        userService.changeUserRoles(user, form);
        return "redirect:/admin";
    }

    @GetMapping("/admin/statistics")
    public String showUserStatistics(Principal principal, Model model) {
        model.addAttribute( "users", userService.list());
        model.addAttribute("user", userService.getUserByPrincipal(principal));

        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.registerModule(new JavaTimeModule());
        String usersJson;
        try {
            usersJson = objectMapper.writeValueAsString(userService.list());
        } catch (JsonProcessingException e) {
            // Обработка ошибки преобразования в JSON, если необходимо
            e.printStackTrace();
            usersJson = "[]"; // Назначьте значение по умолчанию в случае ошибки
        }
        model.addAttribute("usersJson", usersJson);
        System.out.println(usersJson);
        return "users-statistics";
    }
}

package com.example.buysell.repositories;

import com.example.buysell.models.Cart;
import com.example.buysell.models.Image;
import com.example.buysell.models.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CartRepository extends JpaRepository<Cart, Long> {
    Cart findByUser(User user);
}

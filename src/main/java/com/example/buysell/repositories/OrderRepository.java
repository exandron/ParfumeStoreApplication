package com.example.buysell.repositories;


import com.example.buysell.models.Cart;
import com.example.buysell.models.Order;
import com.example.buysell.models.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findByUser(User user);
}

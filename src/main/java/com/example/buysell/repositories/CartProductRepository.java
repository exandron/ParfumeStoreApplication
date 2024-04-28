package com.example.buysell.repositories;

import com.example.buysell.models.Cart;
import com.example.buysell.models.CartProduct;
import com.example.buysell.models.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface CartProductRepository extends JpaRepository<CartProduct, Long> {
    CartProduct findCartProductByProductAndCart(Product product, Cart cart);
}


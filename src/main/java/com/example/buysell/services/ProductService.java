package com.example.buysell.services;

import com.example.buysell.models.Image;
import com.example.buysell.models.Product;
import com.example.buysell.models.User;
import com.example.buysell.repositories.ProductRepository;
import com.example.buysell.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;
import java.util.List;
import java.util.Objects;

@Service
@Slf4j
@RequiredArgsConstructor
public class ProductService {

    private final ProductRepository productRepository;
    private final UserRepository userRepository;

    public List<Product> listProducts(String title, String gender) {
        if (title != null && !title.isEmpty() && gender != null && !gender.isEmpty()) {
            return productRepository.findByTitleAndGender(title, gender);
        } else if (title != null && !title.isEmpty() ) {
            return productRepository.findByTitle(title);
        } else if (gender != null && !gender.isEmpty()) {
            return productRepository.findByGender(gender);
        } else {
            return productRepository.findAll();
        }
    }

    public List<Product> listAllProducts() {
            return productRepository.findAll();
    }

    public void saveProduct(Principal principal, Product product, MultipartFile file1, MultipartFile file2, MultipartFile file3) throws IOException {
        product.setUser(getUserByPrincipal(principal));
        Image image1;
        Image image2;
        Image image3;
        if (file1.getSize() != 0) {
            image1 = toImageEntity(file1);
            image1.setPreviewImage(true);
            product.addImageToProduct(image1);
        }
        if (file2.getSize() != 0) {
            image2 = toImageEntity(file2);
            product.addImageToProduct(image2);
        }
        if (file3.getSize() != 0) {
            image3 = toImageEntity(file3);
            product.addImageToProduct(image3);
        }
//        log.info("Saving new Product. Title: {}; Author email: {}", product.getTitle(), product.getUser().getEmail());
//        Product productFromDb = productRepository.save(product);
//        productFromDb.setPreviewImageId(productFromDb.getImages().get(0).getId());
//        productRepository.save(product);

        log.info("Saving new Product. Title: {}; Author email: {}", product.getTitle(), product.getUser().getEmail());
        Product productFromDb = productRepository.save(product);
        productFromDb.setPreviewImageId(productFromDb.getImages().get(0).getId());
        productRepository.save(productFromDb);
    }

    public User getUserByPrincipal(Principal principal) {
        if (principal == null) return new User();
        return userRepository.findByEmail(principal.getName());
    }

    private Image toImageEntity(MultipartFile file) throws IOException {
        Image image = new Image();
        image.setName(file.getName());
        image.setOriginalFileName(file.getOriginalFilename());
        image.setContentType(file.getContentType());
        image.setSize(file.getSize());
        image.setBytes(file.getBytes());
        return image;
    }

    public void deleteProduct(User user, Long id) {
        Product product = productRepository.findById(id)
                .orElse(null);
        if (product != null) {
            if (product.getUser().getId().equals(user.getId())) {
                productRepository.delete(product);
                log.info("Product with id = {} was deleted", id);
            } else {
                log.error("User: {} haven't this product with id = {}", user.getEmail(), id);
            }
        } else {
            log.error("Product with id = {} is not found", id);
        }    }


    public void editProductName(User user, Long id, String productName) {
        Product product = productRepository.findById(id).orElse(null);
        if (product != null) {
            if (product.getUser().getId().equals(user.getId())) {
                product.setTitle(productName);
                productRepository.save(product);
                log.info("Product with id = {} was edited. New name: {}", id, productName);
            } else {
                log.error("User: {} doesn't have this product with id = {}", user.getEmail(), id);
            }
        } else {
            log.error("Product with id = {} was not found", id);
        }
    }

    public void editDescription(User user, Long id, String description) {
        Product product = productRepository.findById(id).orElse(null);
        if (product != null) {
            if (product.getUser().getId().equals(user.getId())) {
                product.setDescription(description);
                productRepository.save(product);
                log.info("Product with id = {} was edited. New name: {}", id, description);
            } else {
                log.error("User: {} doesn't have this product with id = {}", user.getEmail(), id);
            }
        } else {
            log.error("Product with id = {} was not found", id);
        }
    }

    public void editPrice(User user, Long id, Double price) {
        Product product = productRepository.findById(id).orElse(null);
        if (product != null) {
            if (product.getUser().getId().equals(user.getId())) {
                product.setPrice(price);
                productRepository.save(product);
                log.info("Product with id = {} was edited. New name: {}", id, price);
            } else {
                log.error("User: {} doesn't have this product with id = {}", user.getEmail(), id);
            }
        } else {
            log.error("Product with id = {} was not found", id);
        }
    }

    public void editGender(User user, Long id, String gender) {
        Product product = productRepository.findById(id).orElse(null);
        if (product != null) {
            if (product.getUser().getId().equals(user.getId())) {
                product.setGender(gender);
                productRepository.save(product);
                log.info("Product with id = {} was edited. New name: {}", id, gender);
            } else {
                log.error("User: {} doesn't have this product with id = {}", user.getEmail(), id);
            }
        } else {
            log.error("Product with id = {} was not found", id);
        }
    }

    public Product getProductById(Long id) {
        return productRepository.findById(id).orElse(null);
    }
}

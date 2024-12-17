package com.example.demo.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, String> {
    @Query("select u from User u where u.id=:id")
    Optional<User> findByUserId(@Param("id") String id); //JPQL

    @Query("select u from User u where u.email=:email")
    Optional<User> findByUserEmail(@Param("email") String email); //JPQL
}
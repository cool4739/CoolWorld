package com.example.demo.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, String> {
    @Query("SELECT u FROM User u WHERE u.userid = :#{#userId.userid}")
    Optional<User> findByUserId(@Param("userId") UserKey userKey);

    @Query("select u from User u where u.email = :#{#userId.email}")
    Optional<User> findByUserEmail1(@Param("userId") UserKey userKey); //JPQL

    @Query("select u from User u where u.email=:email")
    Optional<User> findByUserEmail2(@Param("email") String email); //JPQL
}
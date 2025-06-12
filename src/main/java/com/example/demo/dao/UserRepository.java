package com.example.demo.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, UserKey> {
    @Query("SELECT u FROM User u WHERE u.userid = :#{#userKey.userid}")
    Optional<User> findByUserId(@Param("userKey") UserKey userKey);

    @Query("select u from User u where u.email = :#{#userKey.email}")
    Optional<User> findByUserEmail1(@Param("userKey") UserKey userKey); //JPQL
}
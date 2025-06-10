package com.example.demo.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface PostRepository extends JpaRepository<Post, PostKey> {
    // 현재 가장 큰 postid 찾기
    @Query("SELECT COALESCE(MAX(p.postid), 0) FROM Post p")
    Long findMaxPostId();

    @Query("SELECT p FROM Post p WHERE p.postid = :postid")
    Optional<Post> findByPostId(@Param("postid") Long postid);
}
package com.example.demo.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface PostRepository extends JpaRepository<Post, String> {
    // 현재 가장 큰 postid 찾기
    @Query("SELECT COALESCE(MAX(CAST(p.postid AS int)), 0) FROM Post p")
    int findMaxPostId();
}
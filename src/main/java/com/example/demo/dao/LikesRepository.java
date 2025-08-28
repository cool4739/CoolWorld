package com.example.demo.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface LikesRepository extends JpaRepository<Likes, LikesKey> {
    @Query("SELECT l FROM Likes l WHERE l.postid = :#{#likesKey.postid} AND l.userid = :#{#likesKey.userid}")
    Optional<Likes> findByPostIdAndUserId(@Param("likesKey") LikesKey likesKey);

    // 게시글 id로 좋아요 개수 카운트
    @Query("SELECT COUNT(l) FROM Likes l WHERE l.postid = :postid AND l.liked = true")
    Long countByPostId(@Param("postid") Long postid);
}
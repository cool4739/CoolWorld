package com.example.demo.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface CommentRepository extends JpaRepository<Comment, Long> {
    // postid로 댓글 목록 조회 (최신순 정렬)
    List<Comment> findByPostidOrderByUptimeDesc(Long postid);

    // 최대 commentid 조회 (null인 경우 0 반환)
    @Query("SELECT COALESCE(MAX(c.commentid), 0) FROM Comment c")
    Long findMaxCommentId();

    // 게시글 id로 좋아요 개수 카운트
    @Query("SELECT COUNT(c) FROM Comment c WHERE c.postid = :postid")
    Long countByPostId(@Param("postid") Long postid);
}
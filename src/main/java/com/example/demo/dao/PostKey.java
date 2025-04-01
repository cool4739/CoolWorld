package com.example.demo.dao;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@EqualsAndHashCode
@Getter
@Setter
public class PostKey implements Serializable {

    private String postid;
    private String userid;

    // 기본 생성자와 getter는 Lombok @Getter로 자동 생성

    // equals()와 hashCode()는 @EqualsAndHashCode 어노테이션으로 자동 생성
}
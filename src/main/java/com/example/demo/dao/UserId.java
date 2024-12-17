package com.example.demo.dao;

import lombok.*;

import java.io.Serializable;

@EqualsAndHashCode
public class UserId implements Serializable {

    private String id;
    private String email;

    // 기본 생성자와 getter는 Lombok @Getter로 자동 생성

    // equals()와 hashCode()는 @EqualsAndHashCode 어노테이션으로 자동 생성
}
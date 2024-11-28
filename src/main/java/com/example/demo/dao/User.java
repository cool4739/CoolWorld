package com.example.demo.dao;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import jakarta.persistence.*;

@Entity //DB의 테이블을 뜻함
@Getter //Lombok의 Getter를 이용해 Getter 메소드를 생성하고 @Builder 를 이용해서 객체를 생성할 수 있게 처리한다
@NoArgsConstructor //@Builder를 이용하기 위해 @AllArgsConstructor 와 @NoArgsConstructor 를 같이 처리해야 컴파일 에러가 발생하지 않음
@AllArgsConstructor
@Builder

public class User {

    @Id
    @Column(nullable = false) //DB Column을 명시
    private String id;

    @Column(nullable = false)
    private String pw;

    @Column(nullable = false)
    private String nickname;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private String email;

}

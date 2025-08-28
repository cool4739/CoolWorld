package com.example.demo.dao;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import lombok.*;

@Entity //DB의 테이블을 뜻함
@Setter
@Getter //Lombok의 Getter를 이용해 Getter 메소드를 생성하고 @Builder 를 이용해서 객체를 생성할 수 있게 처리한다
@NoArgsConstructor //@Builder를 이용하기 위해 @AllArgsConstructor 와 @NoArgsConstructor 를 같이 처리해야 컴파일 에러가 발생하지 않음
@AllArgsConstructor
@Builder
@IdClass(LikesKey.class)//복합키 사용을 위함. 키의 재사용을위해 @EmbeddedId를 하지않고 @IdClass를 선택했다
public class Likes {

    @Id
    @Column
    private Long postid;

    @Id
    @Column
    private String userid;

    @Column
    private boolean liked;
}

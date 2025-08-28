package com.example.demo.dao;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity //DB의 테이블을 뜻함
@Setter
@Getter //Lombok의 Getter를 이용해 Getter 메소드를 생성하고 @Builder 를 이용해서 객체를 생성할 수 있게 처리한다
@NoArgsConstructor //@Builder를 이용하기 위해 @AllArgsConstructor 와 @NoArgsConstructor 를 같이 처리해야 컴파일 에러가 발생하지 않음
@AllArgsConstructor
@Builder
public class Comment {

    @Id
    @Column
    private Long commentid;

    @Column
    private Long postid;

    @Column
    private String userid;

    @Column
    private Long commentnum; //1=댓글, 2=대댓글

    @Column
    private String comment;

    @Column(nullable = false)
    private LocalDateTime uptime; //YYYY-MM-DD HH:mm:ss

}

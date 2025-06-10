package com.example.demo.service;

import com.example.demo.dao.UserKey;
import com.example.demo.dto.UserLoginRequestDto;
//import com.dto.UserRegisterRequestDto;
//import com.dto.UserUpdateDto;
import com.example.demo.dao.User;
import com.example.demo.dao.UserRepository;
import com.example.demo.dto.UserRegisterRequestDto;
import com.example.demo.etc.SessionManager;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@RequiredArgsConstructor
@Service
@Transactional
public class UserService {

    private final UserRepository userRepository;
    private final SessionManager sessionManager;
    private final HttpSession httpSession;

    public User findById(String userid) {
        System.out.println(userid);
        UserKey userKey = new UserKey();
        userKey.setUserid(userid);
        System.out.println(userKey);
        return userRepository.findByUserId(userKey).orElseThrow(() -> new IllegalArgumentException("존재하지 않는 유저입니다."));
    }

    public User findByEmail(String s) {
        UserKey userKey = new UserKey();
        userKey.setEmail(s);
        System.out.println(userRepository.findByUserEmail1(userKey).orElseThrow(() -> new IllegalArgumentException("존재하지 않는 유저입니다.")));
        return userRepository.findByUserEmail1(userKey).orElseThrow(() -> new IllegalArgumentException("존재하지 않는 유저입니다."));
    }

/*    @Transactional
    public Long save(User user) { //저장
        return userRepository.save(user).getNum();
    }*/

/*    @Transactional
    public Long update(Long num, UserUpdateDto updateDto) { //수정
        User user = userRepository.findById(num)
                .orElseThrow(() -> new IllegalCallerException("없음"));
        user.update(updateDto);
        return num;
    }*/

    /*@Transactional
    public Long read(Long user_num, UserReadRequestDto userReadRequestDto) { //읽기
        User user = userRepository.findById(user_num)
                                  .orElseThrow(() -> new IllegalCallerException("없음"));
        return user_num;
    }*/

    @Transactional
    public void delete(String s) { //삭제
        User user = findById(s);
        userRepository.delete(user);
    }

    public User login(UserLoginRequestDto requestDto, HttpServletResponse response, HttpServletRequest request) {
        User user = userRepository.findByUserId(requestDto.getUserKey())
                .orElseThrow(() -> new IllegalCallerException("테이블에 유저가 없습니다"));
        if (user.getUserpw().equals(requestDto.getUserpw())) { //서버데이터 equals 입력한것
            sessionManager.createSession(user, response); //session manager 통해 세션을 생성하고, 회원 데이터 보관
            //세션이 있으면 있는 세션 반환, 없으면 신규 세션을 생성
            // request.getSession(false)로 하면 세션이 없다면 null을 반환한다.
            HttpSession session = request.getSession();
            //session.setAttribute("user", user); //세션에 로그인 회원 정보 보관
            System.out.println("login service ok");
            return user;
        } else {
            System.out.println(requestDto.getUserKey());
            System.out.println(requestDto.getUserpw());
            throw new IllegalCallerException("패스워드불일치");
        }
    }

    public Long register(UserRegisterRequestDto requestDto) {
        System.out.println("service");
        if(userRepository.findByUserId(requestDto.getUserKey()).isPresent()) { //isPresent = Optional의 boolean함수
            System.out.println("service2");
            return 0L; //중복id
        } else if (userRepository.findByUserEmail1(requestDto.getUserKey()).isPresent()) {
            System.out.println("service3");
            return 1L; //중복email
        } else {
            System.out.println("service4");
            User user = requestDto.toEntity();
            userRepository.save(user);
            return 2L; //성공
        }
    }

    public void logout(HttpServletRequest request, HttpServletResponse response) {
        sessionManager.expire(request, response);
    }
}
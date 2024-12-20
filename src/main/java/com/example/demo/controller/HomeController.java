package com.example.demo.controller;

import com.example.demo.dao.User;
import com.example.demo.etc.SessionManager;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

@Controller
public class HomeController {

    private final SessionManager sessionManager;

    public HomeController(SessionManager sessionManager) {
        this.sessionManager = sessionManager;
    }

    @RequestMapping("/test")
    public String test() {
        System.out.println("test");
        return "index";
    }

    @RequestMapping("/")
    public String login(HttpServletRequest request) {
        Object user = sessionManager.getSession(request); //세션에 저장된 'user'객체를 반환(세션쿠키사용)
        if (user == null) { // 세션 데이터없음
            System.out.println("no session");
            return "login";
        } else { // 세션있음. 로그인상태 유지
            SessionManager.SessionData sessionData = (SessionManager.SessionData) user; // SessionData 객체로 캐스팅
            User loginuser = (User) sessionData.getValue(); //세션에 담긴 User정보를 캐스팅해서 받기
            System.out.println("User ID: " + loginuser.getId());
        }
        return "main";
    }

/*    @RequestMapping("/")
    public String login(@SessionAttribute(name = "user", required = false) User user, Model model) {
        if (user == null) { // [세션ID 쿠키]에 해당되는 세션 데이터없음
            System.out.println("no session");
            return "login";
        } else { // 세션있음. 로그인상태 유지
            System.out.println("User ID: " + user.getId());
        }
        return "main";
    }*/

    @RequestMapping("/register")
    public String register() {
        return "register";
    }

    @RequestMapping("/findId")
    public String findId() {
        return "findId";
    }

    @RequestMapping("/findPw")
    public String findPw() {
        return "findPw";
    }

    @RequestMapping("/main")
    public String main() {
        return "main";
    }

}

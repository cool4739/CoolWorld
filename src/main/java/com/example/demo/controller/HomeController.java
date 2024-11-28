package com.example.demo.controller;

import com.example.demo.dao.User;
import com.example.demo.etc.SessionManager;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
    public String login(HttpSession httpSession, Model model) {
        //세션 관리자에 저장된 user 정보 조회

        User user = (User)httpSession.getAttribute("user");
        // [세션ID 쿠키]에 해당되는 세션 데이터없음
        if (user == null) {
            return "login";
        }

        // 세션있음. 로그인상태 유지
        model.addAttribute("user", user);
        return "main";
    }
}

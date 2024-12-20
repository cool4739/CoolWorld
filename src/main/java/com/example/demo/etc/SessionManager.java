package com.example.demo.etc;

import lombok.Getter;
import org.springframework.stereotype.Component;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

@Component
public class SessionManager {

    public static final String SESSION_COOKIE_NAME = "mySessionId";
    private Map<String, Object> sessionStore = new ConcurrentHashMap<>();
    private static final int SESSION_TIMEOUT = 1 * 1000; //밀리초

    // 세션 데이터 구조
    @Getter
    public static class SessionData {
        private Object value;
        private long expirationTime;

        public SessionData(Object value, long expirationTime) {
            this.value = value;
            this.expirationTime = expirationTime;
        }

    }

    //## 세션 생성 ##//
    public void createSession(Object value, HttpServletResponse response) {
        //세션 id(UUID)를 생성하고, 값을 세션에 저장
        String sessionId = UUID.randomUUID().toString();
        long expirationTime = System.currentTimeMillis() + SESSION_TIMEOUT;
        sessionStore.put(sessionId, new SessionData(value, expirationTime));

        //쿠키 생성
        Cookie mySessionCookie = new Cookie(SESSION_COOKIE_NAME, sessionId);
        mySessionCookie.setHttpOnly(true); //js에서 못고치게
        mySessionCookie.setMaxAge(50); //쿠키유지시간
        mySessionCookie.setPath("/"); //쿠키유효범위 /하위 모두 허용
        System.out.println(sessionId);
        response.addCookie(mySessionCookie);
    }

    //## 쿠키 조회 ##//
    public Object getSession(HttpServletRequest request) {
        Cookie sessionCookie = findCookie(request, SESSION_COOKIE_NAME);
        if (sessionCookie == null) { //쿠키찾기
            System.out.println("sessionCookie null");
            return null;
        }
        Object sessionData = sessionStore.get(sessionCookie.getValue());
        if (sessionData == null) { //데이터찾기
            System.out.println("Value null");
            return null;
        }
        System.out.println(sessionCookie.getValue());
        System.out.println(sessionData.getClass());
        return sessionData;
    }

    //## 세션 만료 ##//
    public void expire(HttpServletRequest request, HttpServletResponse response) {
        Cookie sessionCookie = findCookie(request, SESSION_COOKIE_NAME);
        if (sessionCookie != null) {
            sessionStore.remove(sessionCookie.getValue()); //세션데이터삭제
            sessionCookie.setMaxAge(0); //쿠키 만료시키기
            sessionCookie.setPath("/");
            response.addCookie(sessionCookie); //만료된 쿠키를 클라이언트에 보냄으로 삭제
        }
    }

    // 서블릿에서 세션 객체(Session)를 제공해주긴 하지만, 이해를 돕기위해 직접 구현해보았다.
    public Cookie findCookie(HttpServletRequest request, String cookieName) {
        if (request.getCookies() == null) { // 쿠키값은 array 또는 null 로 반환된다.
            return null;
        }
        return Arrays.stream(request.getCookies()) // 해당 쿠키이름을 찾아 반환하는 로직
                .filter(cookie -> cookie.getName().equals(cookieName))
                .findAny() // 처음으로 발견된 값 아무거나
                .orElse(null); // 없다면 null 반환
    }

}
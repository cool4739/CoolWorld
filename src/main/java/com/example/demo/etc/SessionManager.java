package com.example.demo.etc;

import lombok.Getter;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.http.ResponseCookie;
import org.springframework.stereotype.Component;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import java.util.concurrent.*;

@Component
public class SessionManager {

    public static final String SESSION_COOKIE_NAME = "mySessionId";
    private Map<String, Object> sessionStore = new ConcurrentHashMap<>();
    private static final int SESSION_TIMEOUT = 60*60 * 1000; //밀리초

    @EventListener(ApplicationReadyEvent.class)
    public void onApplicationReady() {
        System.out.println("Starting session cleanup.");
        startSessionCleanup();  // 애플리케이션이 준비되면 세션 정리 작업을 시작
    }

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
        String sessionId = UUID.randomUUID().toString();
        long expirationTime = System.currentTimeMillis() + SESSION_TIMEOUT;
        sessionStore.put(sessionId, new SessionData(value, expirationTime));

        // Set-Cookie using Spring's ResponseCookie only
        ResponseCookie cookie = ResponseCookie.from(SESSION_COOKIE_NAME, sessionId)
                .path("/")
                .httpOnly(true)
                .sameSite("Lax")
                .maxAge(3600)
                .build();

        response.setHeader("Set-Cookie", cookie.toString()); // 덮어쓰기 방식 (중복 방지)
    }

    //## 쿠키 조회 ##//
    public Object getSession(HttpServletRequest request, HttpServletResponse response) {
        Cookie sessionCookie = findCookie(request, SESSION_COOKIE_NAME);
         Set<String> keySet = sessionStore.keySet();
        for (String key : keySet) {
            System.out.println(key + " : " + sessionStore.get(key));
        }  //sessionStore 체크용
            if (sessionCookie == null) { //쿠키찾기
            System.out.println("sessionCookie null");
            return null;
        }
        SessionData sessionData = (SessionData) sessionStore.get(sessionCookie.getValue());
        if (sessionData == null) { //데이터찾기
            System.out.println("Value null");
            return null;
        }

        long newExpirationTime = System.currentTimeMillis() + SESSION_TIMEOUT;
        sessionData = new SessionData(sessionData.getValue(), newExpirationTime);
        sessionStore.put(sessionCookie.getValue(), sessionData);

        sessionCookie.setMaxAge(3600);
        response.addCookie(sessionCookie); // 갱신된 쿠키를 클라이언트에 다시 전송

        return sessionData;
    }

    //## 쿠키 만료 ##//
    public void expire(HttpServletRequest request, HttpServletResponse response) {
        // 1. 서버 세션 데이터 삭제
        Cookie sessionCookie = findCookie(request, SESSION_COOKIE_NAME);
        if (sessionCookie != null) {
            sessionStore.remove(sessionCookie.getValue());
        }

        String[] pathsToDelete = {"/", "/post", "/post/create", "/postinfo", "/postupdate"}; // 실제 사용하는 expire 안되는 이슈가 있는 경로 기재

        for (String path : pathsToDelete) {
            Cookie deleteCookie = new Cookie(SESSION_COOKIE_NAME, "");
            deleteCookie.setPath(path);
            deleteCookie.setMaxAge(0); // 즉시 만료
            deleteCookie.setHttpOnly(true);
            if (request.isSecure()) deleteCookie.setSecure(true);
            response.addCookie(deleteCookie);
        }
    }

    public void startSessionCleanup() {
        ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
        scheduler.scheduleAtFixedRate(() -> {
            try {
                long currentTime = System.currentTimeMillis();
                sessionStore.entrySet().removeIf(entry -> {
                    SessionData sessionData = (SessionData) entry.getValue();
                    return sessionData.expirationTime < currentTime;  // 만료된 세션 찾기
                });
            } catch (Exception e) {
                System.err.println("Error during session cleanup: " + e.getMessage());
                e.printStackTrace();
            }
        }, 0, 1, TimeUnit.HOURS);  // 1시간마다 정리
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
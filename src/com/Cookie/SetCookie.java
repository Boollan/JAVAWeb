package com.Cookie;

import org.json.simple.JSONObject;

import javax.servlet.http.Cookie;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class SetCookie {

    public Cookie SetUserCookie(String CookieName,String CookieValue, boolean Keep ){
        Cookie cookie = new Cookie(CookieName,CookieValue);
        if (Keep==true){
            cookie.setMaxAge(60*60*24*7);
        }
        cookie.setPath("/");
        return cookie;
    }

    public JSONObject GetUserCookie(HttpServletRequest request, HttpServletResponse response){

        response.setContentType("text/html;charset=utf-8");
        //1 通过Request对象获取上次服务器端发送的Cookie信息
        Cookie[] cookies = request.getCookies();

        JSONObject json = new JSONObject();
        //2 判断Request对象中的Cookie是否存在
        if(cookies != null){
            //3 遍历Request对象中的所有Cookie
            for (Cookie cookie : cookies) {
                //4 获取每一个Cookie的名称
                json.put(cookie.getName(),cookie.getValue());
            }
            return json;
        }
        return null;
    }

    public Cookie DeleUserCookie(String DelCookieName){
        Cookie cookie = new Cookie(DelCookieName,null);
        cookie.setMaxAge(0);
        cookie.setPath("/");
        return cookie;
    }


}

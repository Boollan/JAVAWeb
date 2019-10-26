package com.Servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.Cookie.SetCookie;

@WebServlet(name = "com.Servlet.ExitServlet",urlPatterns = "/exit")
public class ExitServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.getSession().removeAttribute("JSESSIONID");
        request.getSession().removeAttribute("UserName");

        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=utf-8");
        response.setHeader("content-type","text/html;charset=UTF-8");
        response.getWriter().print("退出账号成功！正在跳转到首页...");
        response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
        response.setHeader("refresh","3;url='/index.jsp'");
    }
}

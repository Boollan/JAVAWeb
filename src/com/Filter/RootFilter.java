package com.Filter;

import com.Filter.RootClass.Land;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(filterName = "RootFilter",urlPatterns = "/accout/*")
public class RootFilter implements Filter {
    public void destroy() {

    }
    //判断是否登录
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {


        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        String requestURI = request.getRequestURI(); //获取用户请求的URL
        Land land = new Land();



        String username = land.GetUserName(request); //判断用户是否登录
        if (username != null && username != ""){
            chain.doFilter(req, resp);
        }else {
            if (land.Urlexclude(requestURI)==true){ //排除登录和注册页面
                chain.doFilter(req, resp);
            }else {
                response.sendRedirect("/");
            }
        }




    }

    public void init(FilterConfig config) throws ServletException {

    }






}

package com.Filter;

import com.Filter.RootClass.Land;
import com.user.sql.SQLConfig;
import com.user.sql.data.SQLdatabase;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

@WebFilter(filterName = "AdminFilter", urlPatterns = "/accout/admin/*")
public class AdminFilter implements Filter {
    public void destroy() {
    }

    //管理员权限的过滤器
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        String requestURI = request.getRequestURI(); //获取用户请求的URL
        Land land = new Land();
        SQLdatabase sqLdatabase = new SQLdatabase();
        Connection connection = sqLdatabase.Mysql_SQL(SQLConfig.MYSQL_JDBCSQL, SQLConfig.MYSQL_USER, SQLConfig.MYSQL_PASSWORD);


        String username = land.GetUserName(request); //判断用户是否登录
        if (username != null && username != "") {
            if (land.GetRootUser(username, connection) > 2) {
                chain.doFilter(req, resp);
            } else {
                response.sendRedirect("/");
            }
        } else {
            response.sendRedirect("/");
        }

    }

    public void init(FilterConfig config) throws ServletException {

    }

}

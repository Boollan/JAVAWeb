package com.Servlet;



import com.user.sql.SQLConfig;
import com.user.sql.data.SQLdatabase;
import org.json.simple.JSONObject;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Connection;


@WebServlet(name = "UpdataPassowrdServlet",urlPatterns = "/Accout/AccoutUpdataPassowrd")
public class UpdataPassowrdServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = URLEncoder.encode(request.getParameter("username"),"utf-8");
        String passowrd_old = URLEncoder.encode(request.getParameter("passowrd_old"),"utf-8");
        String passowrd_new = URLEncoder.encode(request.getParameter("passowrd_new"),"utf-8");

        SQLdatabase sqLdatabase = new SQLdatabase();

        Connection connection = sqLdatabase.Mysql_SQL(SQLConfig.MYSQL_JDBCSQL, SQLConfig.MYSQL_USER, SQLConfig.MYSQL_PASSWORD);
        boolean b = sqLdatabase.User_UpdataPwd_mysql(username, passowrd_old, passowrd_new, connection);
        JSONObject json = new JSONObject();
        json.put("response",b);
        response.getWriter().println(json);
    }
}

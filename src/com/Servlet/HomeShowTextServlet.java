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
import java.sql.Connection;

//写入方法在Admain文件夹中Servlet 对外公布的任何人都可以读取
@WebServlet(name = "HomeShowTextServlet",urlPatterns = "/HomeShowText")
public class HomeShowTextServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=utf-8");
        response.setHeader("content-type","text/html;charset=UTF-8");
        response.getWriter().println(GetInfo());
    }

    private JSONObject GetInfo(){

        SQLdatabase sqLdatabase = new SQLdatabase();
        Connection connection = sqLdatabase.Mysql_SQL(SQLConfig.MYSQL_JDBCSQL, SQLConfig.MYSQL_USER, SQLConfig.MYSQL_PASSWORD);

        return sqLdatabase.Get_Home_Show_Text(connection);
    }
}

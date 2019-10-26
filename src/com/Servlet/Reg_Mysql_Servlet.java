package com.Servlet;

import com.Imodule.Ilogin_validation;
import com.module.login_validation;
import com.user.sql.SQLConfig;
import com.user.sql.data.SQLdatabase;
import com.user.sql.datainteface.interfaceSqldata;
import org.json.simple.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

@WebServlet(name = "com.Servlet.Reg_Mysql_Servlet",urlPatterns = "/reg_mysql")
public class Reg_Mysql_Servlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String requestUsername = request.getParameter("username");

        String requestPassword = request.getParameter("password");

        String requestEmail = request.getParameter("email");

        Ilogin_validation ilogin_validation = new login_validation();

        boolean reten = ilogin_validation.login_validation(requestUsername, requestPassword);//校验用户名和密码格式

        if (reten==true){

            interfaceSqldata SQLDatabase = new SQLdatabase();

            Connection connection = SQLDatabase.Mysql_SQL(SQLConfig.MYSQL_JDBCSQL, SQLConfig.MYSQL_USER, SQLConfig.MYSQL_PASSWORD);

            boolean ret_reg_mysql = SQLDatabase.User_reg_mysql(requestUsername, requestPassword,requestEmail, connection);

            if (ret_reg_mysql==true){
                response.setCharacterEncoding("UTF-8");
                response.setContentType("text/html;charset=utf-8");
                response.setHeader("content-type","text/html;charset=UTF-8");
                response.getWriter().print("恭喜注册成功。正在跳转到登录页面...");
                response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
                response.setHeader("refresh","3;url='/accout/login.jsp'");
            }else {
                response.setCharacterEncoding("UTF-8");
                response.setContentType("text/html;charset=utf-8");
                response.setHeader("content-type","text/html;charset=UTF-8");
                response.getWriter().print("用户名已存在,正在跳转回注册页面...");
                response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
                response.setHeader("refresh","3;url='/accout/reg.jsp'");
            }

        }else {
            response.setCharacterEncoding("UTF-8");
            response.setContentType("text/html;charset=utf-8");
            response.setHeader("content-type","text/html;charset=UTF-8");
            response.getWriter().print("账号或密码格式不正确");

        }
    }

}

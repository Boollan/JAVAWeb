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
import javax.sound.midi.Soundbank;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

@WebServlet(name = "com.Servlet.Reg_Mysql_Servlet",urlPatterns = "/reg_mysql")
public class Reg_Mysql_Servlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String requestUsername = request.getParameter("username").trim();

        String requestPassword = request.getParameter("password").trim();

        String requestEmail = request.getParameter("email").trim();

        /**
         * 无感验证接收
         */
        String token = request.getParameter("token");

//        System.out.println("账号:"+requestUsername+"\n密码:"+requestPassword+"\n邮箱:"+requestEmail+"\ntoken："+token);

        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=utf-8");
        response.setHeader("content-type","text/html;charset=UTF-8");

        Ilogin_validation ilogin_validation = new login_validation();

        boolean reten = ilogin_validation.login_validation(requestUsername, requestPassword);//校验用户名和密码格式
        JSONObject json  = new JSONObject();
        if (reten==true){

            boolean CoderRtunr = false;
            try {
                CoderRtunr = ilogin_validation.ImgeVerification(token);
                if (CoderRtunr==true){

                    interfaceSqldata SQLDatabase = new SQLdatabase();

                    Connection connection = SQLDatabase.Mysql_SQL(SQLConfig.MYSQL_JDBCSQL, SQLConfig.MYSQL_USER, SQLConfig.MYSQL_PASSWORD);

                    boolean ret_reg_mysql = SQLDatabase.User_reg_mysql(requestUsername, requestPassword,requestEmail, connection);

                    if (ret_reg_mysql==true){
                        json.put("key",true);
                        json.put("message","恭喜注册成功.");
                        response.getWriter().println(json);
                    }else {
                        json.put("key",false);
                        json.put("message","用户名已存在.");
                        response.getWriter().println(json);
                    }
                }else {
                    json.put("key",false);
                    json.put("message","验证码错误！");
                    response.getWriter().println(json);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

        }else {
            json.put("key",false);
            json.put("message","账号或密码格式不正确.");
            response.getWriter().println(json);
        }
    }

}

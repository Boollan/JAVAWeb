package com.Servlet;

import com.Cookie.SetCookie;
import com.Imodule.Ilogin_validation;
import com.module.login_validation;
import com.user.sql.SQLConfig;
import com.user.sql.data.SQLdatabase;
import com.user.sql.datainteface.interfaceSqldata;
import com.user.sql.encryption;
import org.json.simple.JSONObject;

import javax.mail.Session;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.Date;
import org.json.simple.JSONObject;


@WebServlet(name = "com.Servlet.Login_Mysql_Servlet",urlPatterns = "/login_mysql")
public class Login_Mysql_Servlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse Response) throws ServletException, IOException {
        /*
         * 接收三个参数:
         */
        String requestUsername = request.getParameter("username");
        String requestPassword = request.getParameter("password");
        String inputKeep = request.getParameter("inputKeep");

       /*
            实例化接口并使用，实现子类
        */
        Ilogin_validation ilogin_validation = new login_validation();
        boolean isaccout = ilogin_validation.login_validation(requestUsername, requestPassword);//校验用户名和密码格式
        if (isaccout){
            interfaceSqldata SQLDatabase = new SQLdatabase();
            Connection connection = SQLDatabase.Mysql_SQL(SQLConfig.MYSQL_JDBCSQL, SQLConfig.MYSQL_USER, SQLConfig.MYSQL_PASSWORD);
            boolean ret_login_mysql = SQLDatabase.User_Login_mysql(requestUsername, requestPassword, connection);
            if (ret_login_mysql){
                if (inputKeep!=null){
                    if (inputKeep.equals("1")){
                        JSONObject JSON  = SQLDatabase.GetinfoUser(requestUsername, connection);//获取用户数据
                        HttpSession session = request.getSession(); //生成Session
                        String id = session.getId();//获取Session ID
                        //存储Session
                        session.setAttribute("UserName",requestUsername);
                        session.setAttribute("permissions",JSON.get("permissions"));
                        //end
                        session.setMaxInactiveInterval(60*60*24*7);//设置Session 过期时间
                        Cookie cookie = new Cookie("JSESSIONID",id);//存储Cookie
                        cookie.setPath("/");//设置作用范围
                        cookie.setMaxAge(60*60*24*7);//设置Cookie过期时间
                        Response.addCookie(cookie);//发送Cookie
                        String remoteAddr = encryption.getIpAddress(request);//获取用户的IP
                        Date date = new Date(new Date().getTime());//获取用户的登录时间
                        SQLDatabase.User_login_record_mysql(requestUsername,remoteAddr,"Web",date,connection);//设置用户登录的平台

                        Response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
                        Response.sendRedirect("/");
                    }
                }else {
                    HttpSession session = request.getSession(); //生成Session
                    JSONObject JSON  = SQLDatabase.GetinfoUser(requestUsername, connection);
                    if (JSON!=null){
                        session.getId();//获取Session ID
                        session.setAttribute("UserName",requestUsername);
                        session.setAttribute("permissions",JSON.get("permissions"));
                        String remoteAddr = encryption.getIpAddress(request);
                        Date date = new Date(new Date().getTime());
                        SQLDatabase.User_login_record_mysql(requestUsername,remoteAddr,"Web",date,connection);

                        Response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
                        Response.sendRedirect("/");

                    }else {
                        request.setAttribute("errorMessage","密码错误!");
                        request.getRequestDispatcher("/error.jsp").forward(request,Response);
                        Response.setHeader("refresh","0;url='/error.jsp'");
                    }



                }
            }else {
                request.setAttribute("errorMessage","密码错误!");
                request.getRequestDispatcher("/error.jsp").forward(request,Response);
                Response.setHeader("refresh","0;url='/error.jsp'");
            }
        }else {

            request.setAttribute("errorMessage","账号或密码格式不正确!");
            request.getRequestDispatcher("/error.jsp").forward(request,Response);
            Response.setHeader("refresh","0;url='/error.jsp'");
        }
    }

}

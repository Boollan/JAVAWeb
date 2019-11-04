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
import java.net.URLEncoder;
import java.sql.Connection;
import java.util.Date;
import org.json.simple.JSONObject;


@WebServlet(name = "com.Servlet.Login_Mysql_Servlet",urlPatterns = "/login_mysql")
public class Login_Mysql_Servlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse Response) throws ServletException, IOException {

        /*
         * 接收三个参数:
         */
        String requestUsername = URLEncoder.encode(request.getParameter("username"),"utf-8");
        String requestPassword = URLEncoder.encode(request.getParameter("password"),"utf-8");
        String inputKeep = URLEncoder.encode(request.getParameter("inputKeep"),"utf-8");
        /**
         * 无感验证接收
         */
        String token = request.getParameter("token");
//        System.out.println("账号:"+requestUsername+"\n密码:"+requestPassword+"\n记住密码:"+inputKeep+"\ntoken:"+token);

       /*
            实例化接口并使用，实现子类
        */
        Ilogin_validation ilogin_validation = new login_validation();
        JSONObject json = new JSONObject();
        boolean isaccout = ilogin_validation.login_validation(requestUsername, requestPassword);//校验用户名和密码格式
        Response.setCharacterEncoding("UTF-8");
        Response.setContentType("text/html;charset=utf-8");
        Response.setHeader("content-type","text/html;charset=UTF-8");
        if (isaccout){
            try {
                boolean bert = ilogin_validation.ImgeVerification(token);//验证码验证
                if (bert==true){
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
                                String remoteAddr = encryption.getIpAddress(request);//获取用户的IP
                                Date date = new Date(new Date().getTime());//获取用户的登录时间
                                SQLDatabase.User_login_record_mysql(requestUsername,remoteAddr,"Web",date,connection);//设置用户登录的平台
                                /**
                                 * 返回值 登录成功！
                                 */
                                json.put("key",true);
                                json.put("message",null);
                                Response.getWriter().println(json);
                                Response.addCookie(cookie);//发送Cookie

                            }else {
                                HttpSession session = request.getSession(); //生成Session
                                JSONObject JSON = SQLDatabase.GetinfoUser(requestUsername, connection);
                                if (JSON != null) {
                                    session.getId();//获取Session ID
                                    session.setAttribute("UserName", requestUsername);
                                    session.setAttribute("permissions", JSON.get("permissions"));
                                    String remoteAddr = encryption.getIpAddress(request);
                                    Date date = new Date(new Date().getTime());
                                    SQLDatabase.User_login_record_mysql(requestUsername, remoteAddr, "Web", date, connection);

                                    /**
                                     * 返回值 登录成功！
                                     */
                                    json.put("key", true);
                                    json.put("message", null);
                                    Response.getWriter().println(json);
                                }
                            }

                        }else {
                                json.put("key",false);
                                json.put("message","密码错误.");
                                Response.getWriter().println(json);
                            }
                    }else {
                        json.put("key",false);
                        json.put("message","密码错误.");
                        Response.getWriter().println(json);
                    }
                }else {
                    json.put("key",false);
                    json.put("message","验证码错误.");
                    Response.getWriter().println(json);
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }else {

            json.put("key",false);
            json.put("message","账号或密码格式不正确.");
            Response.getWriter().println(json);
        }
    }

}

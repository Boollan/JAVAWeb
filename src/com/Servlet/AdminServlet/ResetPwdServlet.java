package com.Servlet.AdminServlet;

import com.Imodule.Ilogin_validation;
import com.module.login_validation;
import com.user.sql.SQLConfig;
import com.user.sql.SendEmailRecord;
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
import java.sql.SQLData;

@WebServlet(name = "ResetPwdServlet",urlPatterns = "/ResePwd")
public class ResetPwdServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //密码重置
        String mail = request.getParameter("mail").trim();//邮箱
        String verify = request.getParameter("verify").trim();//验证码
        String newpwd = URLEncoder.encode(request.getParameter("newpwd").trim(),"utf-8");//新密码
        String token = request.getParameter("token").trim();//Torke 验证


        response.setHeader("content-type","text/json;charset=UTF-8");
        Ilogin_validation ilogin_validation = new login_validation();
        SQLdatabase sqLdatabase = new SQLdatabase();
        Connection connection = sqLdatabase.Mysql_SQL(SQLConfig.MYSQL_JDBCSQL, SQLConfig.MYSQL_USER, SQLConfig.MYSQL_PASSWORD);
        JSONObject json = new JSONObject();
        try {
            if (ilogin_validation.ImgeVerification(token)){
                //验证人机
                JSONObject JsonUserInfo = sqLdatabase.GetinfoEmail(mail, connection);
                if (JsonUserInfo!=null){//判断是否有该用户
                    SendEmailRecord sendEmailRecord = new SendEmailRecord();
                    boolean isemailcode = sendEmailRecord.EmailCode(mail, verify);
                    if (isemailcode){//验证邮箱验证码
                        boolean ispwd = sqLdatabase.verify_Passwrod(JsonUserInfo.get("username").toString(), newpwd, connection);
                        if (ispwd){
                            json.put("key",true);
                            json.put("message","密码重置成功！请使用新密码登录！");
                            response.getWriter().println(json);
                        }else {
                            json.put("key",false);
                            json.put("message","未知错误更改密码失败！");
                            response.getWriter().println(json);
                        }
                    }
                    else {
                        json.put("key",false);
                        json.put("message","邮箱验证码错误！");
                        response.getWriter().println(json);
                    }
                }else {
                    json.put("key",false);
                    json.put("message","查无此用户！");
                    response.getWriter().println(json);
                }
            }else {
                json.put("key",false);
                json.put("message","人机验证未通过");
                response.getWriter().println(json);
            }



        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}

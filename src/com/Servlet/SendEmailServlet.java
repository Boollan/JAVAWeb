package com.Servlet;

import com.module.RandomNumber;
import com.user.sql.SendEmailRecord;
import org.json.simple.JSONObject;

import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.crypto.Data;
import java.io.IOException;
import java.time.DateTimeException;
import java.util.Date;


@WebServlet(name = "SendEmailServlet",urlPatterns = "/SendEmail")
public class SendEmailServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email");
        SendEmailRecord sendEmailRecord = new SendEmailRecord();
        String randomCode = RandomNumber.getRandomCode(6);//生成6位随机数
        Date date = new Date(new Date().getTime()+1800000);

        boolean b = sendEmailRecord.SendRecord(email, randomCode, date); //记录到数据库
        JSONObject json = new JSONObject();
        if (b==true){
            json.put("return",true);
            try {
                sendEmailRecord.SendEmailRecord(email,randomCode,date);//发送邮件给用户
                response.getWriter().println(json);
            } catch (Exception e) {
                e.printStackTrace();
                json.put("return",false);
                response.getWriter().println(json);
            }
        }else {
            json.put("return",false);
        }



    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        SendEmailRecord sendEmailRecord = new SendEmailRecord();
        String randomCode = RandomNumber.getRandomCode(6);//生成6位随机数
        Date date = new Date(new Date().getTime()+1800000);

        boolean b = sendEmailRecord.SendRecord(email, randomCode, date);
        if (b==true){
            try {
                sendEmailRecord.SendEmailRecord(email,randomCode,date);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}

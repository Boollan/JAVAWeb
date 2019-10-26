package com.Servlet;

import com.user.sql.SendEmailRecord;
import org.json.simple.JSONObject;

import javax.print.Doc;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "EmailCodeServlet",urlPatterns = "/EmailCode")
public class EmailCodeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String maillod = request.getParameter("maillod");
        String mailnew = request.getParameter("mailnew");
        String code = request.getParameter("code");

        SendEmailRecord sendEmailRecord = new SendEmailRecord();
        boolean b = sendEmailRecord.EmailCode(username, maillod, mailnew, code);
        JSONObject json = new JSONObject();
        if (b==true){
            json.put("return",true);
            response.getWriter().println(json);
        }else {
            json.put("return",false);
            response.getWriter().println(json.toString());
        }
    }

}

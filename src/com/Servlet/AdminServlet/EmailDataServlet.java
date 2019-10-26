package com.Servlet.AdminServlet;

import com.user.sql.SQLConfig;
import com.user.sql.data.SQLdatabase;
import org.json.simple.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.interfaces.RSAKey;
import java.sql.Connection;
//邮箱信息查询
@WebServlet(name = "EmailDataServlet",urlPatterns = "/Accout/Admin/EmailData")
public class EmailDataServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String parameter = request.getParameter("mail").trim();

        SQLdatabase sqLdatabase = new SQLdatabase();
        Connection connection = sqLdatabase.Mysql_SQL(SQLConfig.MYSQL_JDBCSQL, SQLConfig.MYSQL_USER, SQLConfig.MYSQL_PASSWORD);
        JSONObject jsonObject = sqLdatabase.GetinfoEmail(parameter, connection);

        if (jsonObject!=null){
            response.getWriter().println(jsonObject);
        }else {
            response.getWriter().println("");
        }

    }

}

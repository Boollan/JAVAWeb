package com.Servlet;

import com.sun.org.apache.bcel.internal.generic.RETURN;
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

@WebServlet(name = "Accout_CDK_Servlet",urlPatterns = "/Accout/CdkSend")
public class Accout_CDK_Servlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");//用户
        String key = request.getParameter("key");//KEY

        boolean b = Cdk_Send(username, key);
        JSONObject json = new JSONObject();
        json.put("return",b);
        response.getWriter().println(json);

    }

    public boolean Cdk_Send(String UserName,String Key){

        SQLdatabase sqldata = new SQLdatabase();
        Connection connection = sqldata.Mysql_SQL(SQLConfig.MYSQL_JDBCSQL, SQLConfig.MYSQL_USER, SQLConfig.MYSQL_PASSWORD);
        boolean b = sqldata.Acoout_send_Cdk(UserName.trim(), Key.trim(), connection);
        if (b==true){
            return true;
        }else {
            return false;
        }

    }

}

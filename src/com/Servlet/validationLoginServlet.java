package com.Servlet;

import com.user.sql.SQLConfig;
import com.user.sql.data.SQLdatabase;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

@WebServlet(name = "validationLoginServlet",urlPatterns = "/Accout/Validation")
public class validationLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String inputUsernameValue = request.getParameter("inputUsernameValue");


        if (isUser(inputUsernameValue)!=true){

            response.getWriter().println(0);
        }else {
            response.getWriter().println(1);
        }
    }

    public boolean  isUser(String username){
        SQLdatabase sqLdatabase = new SQLdatabase();

        Connection connection = sqLdatabase.Mysql_SQL(SQLConfig.MYSQL_JDBCSQL, SQLConfig.MYSQL_USER, SQLConfig.MYSQL_PASSWORD);

        try {

            Statement stm = connection.createStatement();

            ResultSet resultSet = stm.executeQuery("select * from accout_user where username='" + username + "'");
            if (resultSet.next()==true){
                return true; //存在用户
            }else {
                return false; //不存在用户
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}

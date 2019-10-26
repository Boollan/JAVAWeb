package com.Servlet;

import com.user.sql.SQLConfig;
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
import java.util.Date;

import com.user.sql.encryption;

import com.user.sql.datainteface.interfaceSqldata;

@WebServlet(name = "GameServlet",urlPatterns = "/GameKey")
public class GameServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String gameusernam = request.getParameter("gameusernam");
        String gamepassowrd = request.getParameter("gamepassowrd");
        gameusernam = URLEncoder.encode(gameusernam,"UTF-8");
        gamepassowrd = URLEncoder.encode(gamepassowrd,"UTF-8");

        SQLdatabase sqldata = new SQLdatabase();
        Connection connection = sqldata.Mysql_SQL(SQLConfig.MYSQL_JDBCSQL, SQLConfig.MYSQL_USER, SQLConfig.MYSQL_PASSWORD);
        boolean b = sqldata.User_Login_mysql(gameusernam.trim(), gamepassowrd.trim(), connection);

        JSONObject json= new JSONObject();
        if (b){
            JSONObject jsonObject = sqldata.GetinfoUser(gameusernam, connection);
            int grde = Integer.parseInt((String)jsonObject.get("permissions"));
            System.out.println("用户等级:"+grde);
            if (grde>0){
                json.put("key",true);
                response.getWriter().println(json);

                String remoteAddr = encryption.getIpAddress(request);
                Date date = new Date(new Date().getTime());

                sqldata.User_login_record_mysql(gameusernam.trim(),remoteAddr,"Game_Fly",date,connection);
            }else {
                json.put("key",false);
                response.getWriter().println(json);
            }
        }else {
            json.put("key",false);
            response.getWriter().println(json);
        }

    }


}

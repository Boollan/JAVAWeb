package com.Servlet.AdminServlet;

import com.user.sql.SQLConfig;
import com.user.sql.data.SQLdatabase;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.crypto.Data;
import java.io.IOException;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import com.module.traverse;
//用于登录记录查询
@WebServlet(name = "RecordServlet", urlPatterns = "/Accout/Admin/Record")
public class RecordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String Record_UserName = request.getParameter("Record_UserName");//用户名
        String Record_StartTime = request.getParameter("Record_StartTime");//开始时间
        String Record_EndTime = request.getParameter("Record_EndTime");//结束时间
        String Record_platform = request.getParameter("Record_platform");//平台

        Date Date_StartTime = null;
        Date Date_EndTime =null;
        if (Record_StartTime!=null&&Record_StartTime!=""){
            Date_StartTime = DateParse(Record_StartTime);
        }else {
            Date_StartTime=null;
        }

        if (Record_EndTime!=null&&Record_EndTime!=""){
            Date_EndTime = DateParse(Record_EndTime);

        }else {
            Date_EndTime = null;
        }


        SQLdatabase sqLdatabase = new SQLdatabase();
        Connection connection = sqLdatabase.Mysql_SQL(SQLConfig.MYSQL_JDBCSQL, SQLConfig.MYSQL_USER, SQLConfig.MYSQL_PASSWORD);

        ResultSet resultSet = sqLdatabase.Admin_Select_Record_Resultset(Record_UserName, Date_StartTime, Date_EndTime, Record_platform, connection);
        traverse traverse = new traverse();
        JSONArray jsonObject = traverse.resultSetToJson(resultSet);

        response.getWriter().println(jsonObject.toString());

    }






    private Date DateParse(String Date) {
        try {
            if (Date != null) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                return sdf.parse(Date);
            }
            return null;

        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

    private String DateParse(Date date) {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(date);
    }
}

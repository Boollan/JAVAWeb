package com.Servlet.AdminServlet;

import com.module.RandomNumber;
import com.sun.org.apache.bcel.internal.generic.RET;
import com.user.sql.SQLConfig;
import com.user.sql.data.SQLdatabase;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.ref.ReferenceQueue;
import java.lang.reflect.Array;
import java.sql.Connection;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
//CDK生成Servlet
@WebServlet(name = "CDKServlet", urlPatterns = "/Accout/Admin/CDKServlet")
public class CDKServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String num = request.getParameter("num");
        String money = request.getParameter("moey");
        String datetime = request.getParameter("datetime");
        System.out.println(datetime);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            java.util.Date parse = sdf.parse(datetime); //字符串时间转换为date

            SQLdatabase sqldata = new SQLdatabase();

            Connection connection = sqldata.Mysql_SQL(SQLConfig.MYSQL_JDBCSQL, SQLConfig.MYSQL_USER, SQLConfig.MYSQL_PASSWORD);
            int number = Integer.parseInt(num);
            JSONArray jsonArray = RanDomCdk(number, money, parse, connection);//


            response.getWriter().println(jsonArray);

        } catch (ParseException e) {
            e.printStackTrace();
        }
    }



    private JSONArray RanDomCdk(int num, String money, java.util.Date overduetime, Connection connection) {

        String[] array = new String[num];

        for (int i = 0; i < num; i++) {
            array[i] = RandomNumber.getRandomCode(16);//16位卡密
        }

        SQLdatabase sqLdatabase = new SQLdatabase();
        for (int i = 0; i < array.length; i++) {
            sqLdatabase.Admin_inset_cdk(array[i], money, overduetime, connection);
        }

        JSONArray jsonArray  = new JSONArray();
        for (int i = 0; i<array.length;i++){
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("cdk",array[i]);//添加对象
            jsonArray.add(jsonObject);//添加对象到数组
        }

        return jsonArray;
    }

}

package com.Servlet.AdminServlet;

import com.sun.media.jfxmedia.track.Track;
import com.user.sql.SQLConfig;
import com.user.sql.data.SQLdatabase;
import org.json.simple.JSONObject;
import org.omg.IOP.Encoding;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sound.midi.Soundbank;
import javax.sound.sampled.AudioFormat;
import java.io.IOException;
import java.lang.ref.ReferenceQueue;
import java.net.URLEncoder;
import java.security.AlgorithmConstraints;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet(name = "HomeShowSetServlet",urlPatterns = "/Accout/Admin/SetHomeShow")
public class HomeShowSetServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=utf-8");
        response.setHeader("content-type","text/html;charset=UTF-8");


        String titleText = request.getParameter("titletext");//标题
        String homeText = request.getParameter("hometxt");//文本


        /**
         * 更改时间已经内置
         */
        //        String updata_time = request.getParameter("updatatime");//时间

        /**
         * 后期如果需要可以开发自定义图片上传
         */
        //        String img_1 = request.getParameter("");//img路径
        //        String img_2 = request.getParameter("");//img..
        //        String img_3 = request.getParameter("");//img..

        /**
         * 临时使用固定图片
         */
        String img_1 = "/bootstrap-3.3.7-dist/imges/logimg_1.png";
        String img_2 = "/bootstrap-3.3.7-dist/imges/logimg_1.png";
        String img_3 = "/bootstrap-3.3.7-dist/imges/logimg_1.png";

        try {
            SetInfo(titleText,homeText,img_1,img_2,img_3);
            JSONObject json  =new JSONObject();
            json.put("key",true);
            response.getWriter().print(json);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void SetInfo(String title, String text,String img_1,String img_2,String img_3) throws SQLException {
        SQLdatabase sqLdatabase = new SQLdatabase();
        Connection connection = sqLdatabase.Mysql_SQL(SQLConfig.MYSQL_JDBCSQL, SQLConfig.MYSQL_USER, SQLConfig.MYSQL_PASSWORD);
        sqLdatabase.Set_Home_Show_Text(title,text,img_1,img_2,img_3,connection);
        connection.close();
    }


}

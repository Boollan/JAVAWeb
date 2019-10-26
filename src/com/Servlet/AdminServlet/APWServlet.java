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
import java.sql.Connection;

@WebServlet(name = "APWServlet",urlPatterns = "/Accout/Admin/APWServlet")
public class APWServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取参数
        String admin_username = request.getParameter("admin_username");
        String permissions = request.getParameter("permissions");
        String username = request.getParameter("username");
        String userpwd = request.getParameter("userpwd");

        SQLdatabase sqLdatabase = new SQLdatabase();
        //调用数据库连接
        Connection connection = sqLdatabase.Mysql_SQL(SQLConfig.MYSQL_JDBCSQL, SQLConfig.MYSQL_USER, SQLConfig.MYSQL_PASSWORD);
        //获取管理员身份
        JSONObject jsonObject = sqLdatabase.GetinfoUser(admin_username,connection);
        JSONObject retjson = new JSONObject();
        //验证管理员身份
        if (jsonObject.get("permissions").equals(permissions)){
            //管理员身份二次验证

            boolean retpwd = sqLdatabase.Admin_Updata_Passwrod(admin_username, username, userpwd, connection);

            //判断是否成功 true成功

            if (retpwd){
                retjson.put("return",true);
                response.getWriter().println(retjson);
            }else {
                retjson.put("return",false);
                response.getWriter().println(retjson);
            }

        }else {
            retjson.put("return",false);
            response.getWriter().println(retjson);
        }


    }
}

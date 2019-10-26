package com.Servlet;


import com.user.sql.SQLConfig;
import com.user.sql.data.SQLdatabase;
import org.json.simple.JSONObject;


import javax.lang.model.element.NestingKind;
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


@WebServlet(name = "AccoutMessageServlet",urlPatterns = "/Accout/AccoutMessage")
public class AccoutMessageServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String username = request.getParameter("username");
        response.setHeader("content-type","text/json;charset=UTF-8");
        JSONObject jsonObject = UserInfo(username);
        if (jsonObject!=null){
            response.getWriter().println(jsonObject);
        }else {
            response.getWriter().println("");
        }


    }

    public JSONObject UserInfo(String username){
        SQLdatabase sqLdatabase = new SQLdatabase();

        Connection connection = sqLdatabase.Mysql_SQL(SQLConfig.MYSQL_JDBCSQL, SQLConfig.MYSQL_USER, SQLConfig.MYSQL_PASSWORD);

        try {

            Statement stm = connection.createStatement();

            ResultSet resultSet = stm.executeQuery("select * from accout_user where username='" + username + "'");
            if (resultSet.next()==true){
                JSONObject jsonObject = new JSONObject();
                String email = resultSet.getString("email");
                String permissions = resultSet.getString("permissions");
                int donations = resultSet.getInt("donations");

                jsonObject.put("json_username",username);
                jsonObject.put("json_email",email);
                jsonObject.put("json_donations",donations);
                jsonObject.put("json_permissions",permissions);
                return jsonObject;

            }else {
                return null;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

}

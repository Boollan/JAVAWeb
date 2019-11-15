package com.module;

import com.user.sql.SQLConfig;
import com.user.sql.data.SQLdatabase;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

public class traverse {

    //遍历json

    //使用数据结果据变成JSON数据
    public JSONArray resultSetToJson(ResultSet rs)
    {
        try {

            // json数组
            JSONArray array = new JSONArray();

            // 获取列数
            ResultSetMetaData metaData = rs.getMetaData();
            int columnCount = metaData.getColumnCount();

            // 遍历ResultSet中的每条数据
            while (rs.next()) {
                JSONObject jsonObj = new JSONObject();

                // 遍历每一列
                for (int i = 1; i <= columnCount; i++) {
                    String columnName =metaData.getColumnLabel(i);
                    String value = rs.getString(columnName);
                    jsonObj.put(columnName, value);
                }
                array.add(jsonObj);
            }
            return array;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    //获取首页信息数据的方法
    public JSONObject GetHomeShowInfo(){

        SQLdatabase sqLdatabase = new SQLdatabase();
        Connection connection = sqLdatabase.Mysql_SQL(SQLConfig.MYSQL_JDBCSQL, SQLConfig.MYSQL_USER, SQLConfig.MYSQL_PASSWORD);

        return sqLdatabase.Get_Home_Show_Text(connection);
    }
}

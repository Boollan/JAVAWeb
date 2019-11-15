package com.user.sql.datainteface;


import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import javax.xml.crypto.Data;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.Date;

public interface interfaceSqldata {
    /**
     *
     * @param SQL "jdbc连接字符串"
     * @param SQL_User "jdbc连接的用户名"
     * @param Passowrd "密码"
     * @return "返回连接Mysql字符串"
     */
    Connection Mysql_SQL(String SQL,String SQL_User,String Passowrd);//连接MYSQL

    /**
     *
     * @param User
     * @param Password
     * @param mysqlcon
     * @return
     */
    boolean User_Login_mysql(String User, String Password,Connection mysqlcon);//验证登录

    /**
     *
     * @param User
     * @param Password
     * @param Email
     * @param mysqlcon
     * @return
     */
    boolean User_reg_mysql(String User,String Password ,String Email,Connection mysqlcon);//mysql注册

    /**
     * @param User
     * @param IP
     * @param client
     * @param datetime
     * @param mysqlcon
     * @return
     */
    boolean User_login_record_mysql(String User, String IP,String client, java.util.Date datetime,Connection mysqlcon);

    /**
     * @param UserName
     * @param mysqlcon
     * @return
     */
    JSONObject GetinfoUser(String UserName, Connection mysqlcon);

    /**
     * @param Email
     * @param mysqlcon
     * @return
     */
    JSONObject GetinfoEmail(String Email,Connection mysqlcon);

    /**
     * @param Admin
     * @param mysqlcon
     * @return
     */
    boolean Admin_is(String Admin,Connection mysqlcon);

    /**
     * @param Admin
     * @param UserName
     * @param UserPassowrd
     * @param mysqlcon
     * @return
     */
    boolean Admin_Updata_Passwrod(String Admin,String UserName,String UserPassowrd,Connection mysqlcon);

    /**
     * @param Admin
     * @param UserName
     * @param UserNweEmail
     * @param mysqlcon
     * @return
     */
    boolean Admin_Updata_Email(String Admin,String UserName,String UserNweEmail,Connection mysqlcon);


    /**
     * @param UserName
     * @param StartTiem
     * @param EndTime
     * @param platform
     * @param mysqlcon
     * @return
     */
    ResultSet Admin_Select_Record_Resultset(String UserName, java.util.Date StartTiem, java.util.Date EndTime, String platform, Connection mysqlcon);

    /**
     * @param cdk
     * @param money
     * @param overduetime
     * @param mysqlcon
     * @return
     */
    boolean Admin_inset_cdk(String cdk, String money, java.util.Date overduetime, Connection mysqlcon);


    JSONObject Get_Home_Show_Text(Connection mysqlcon);

    boolean Set_Home_Show_Text(String Title , String Text, String imge_1,String imge_2,String imge_3,Connection mysqlcon);

    boolean verify_Passwrod(String UserName, String UserPassowrd, Connection mysqlcon);

    JSONArray Get_Sele_cdk(String cdk_name,Connection mysqlcon);
}

package com.Filter.RootClass;

import com.Filter.FilterConfig.FilterExclude;
import com.user.sql.data.SQLdatabase;
import org.json.simple.JSONObject;

import javax.servlet.http.HttpServletRequest;
import javax.swing.text.rtf.RTFEditorKit;
import java.sql.Connection;

public class Land {

    //获取当前用户名
    public String GetUserName(HttpServletRequest request){
        return (String) request.getSession().getAttribute("UserName");
    }

    //判断权限等级
    public int GetRootUser(String UserName, Connection sqlcon){
        SQLdatabase sqldate = new SQLdatabase();
        JSONObject json = sqldate.GetinfoUser(UserName, sqlcon);
        return Integer.parseInt((String)json.get("permissions"));
    }

    //过滤器排除登录页面
    public boolean Urlexclude(String Url){

        if (FilterExclude.str1.equals(Url)==true||FilterExclude.str2.equals(Url)==true){
            return true;
        }
        return false;
    }







}

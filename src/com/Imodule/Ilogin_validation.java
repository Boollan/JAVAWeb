package com.Imodule;

public interface Ilogin_validation {

    //用户名密码验证
    boolean login_validation(String UserName_Validation,String Password_Validation);
    //用户名注册
    boolean reg_validation(String Email,String UserName,String Password);

    boolean ImgeVerification(String token)throws Exception;
}

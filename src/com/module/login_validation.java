package com.module;

import com.Imodule.Ilogin_validation;

public class login_validation implements Ilogin_validation {

    //继承接口 Ilogin_validation

    //登录格式验证
    @Override
    public boolean login_validation(String UserName_Validation, String Password_Validation) {
        if (UserName_Validation.trim() != null && Password_Validation.trim()!=null){

            if (UserName_Validation.trim().length()<16&&UserName_Validation.trim().length()>1){

                if (Password_Validation.trim().length()<24&&Password_Validation.trim().length()>7){
                    return true;
                }

            }

        }
        return false;
    }
    //用户注册格式验证
    @Override
    public boolean reg_validation(String Email, String UserName, String Password) {
        return false;
    }
}

package com.user.sql.datainteface;


import java.util.Date;

public interface ISendEmailRecord {

    //发送给给数据库记录

    /**
     * @param Email 用户的邮箱
     * @param Code 验证码
     * @param tiem 过期时间
     */
    boolean SendRecord(String Email, String Code, Date tiem);

    /**
     * @param Email
     * @param code
     * @param teim
     * @throws Exception
     */
    //发送给用户
    void SendEmailRecord(String Email, String code, Date teim) throws Exception;

    /**
     * @param EmailoLD
     * @param EmailNew
     * @param Code
     */
    //验证验证码
    boolean EmailCode(String UserName,String EmailoLD,String EmailNew,String Code);


}

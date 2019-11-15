package com.user.sql;

import com.module.RandomNumber;
import com.module.SendEmail;
import com.user.sql.data.SQLdatabase;
import com.user.sql.datainteface.ISendEmailRecord;


import javax.xml.crypto.Data;
import java.security.PublicKey;
import java.sql.*;
import java.util.Date;


public class SendEmailRecord implements ISendEmailRecord {

    //将生成的伪随机数发送到Mysql数据库保存进行用户的验证
    @Override
    public boolean SendRecord(String Email, String Code, Date tiem) {

        try {
            SQLdatabase sqLdatabase = new SQLdatabase();
            Connection connection = sqLdatabase.Mysql_SQL(SQLConfig.MYSQL_JDBCSQL, SQLConfig.MYSQL_USER, SQLConfig.MYSQL_PASSWORD);
            //创建SQL 连接
            Statement stm = connection.createStatement();
            java.sql.Timestamp timestamp = new java.sql.Timestamp(tiem.getTime());
            int is = stm.executeUpdate("INSERT INTO EmailCode(email,code,effective)VALUES('"+Email+"','"+Code+"','"+timestamp+"')");
            if(is==1){
                return true;
            }else {
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    //用于发送Htlm模板验证码
    @Override
    public void SendEmailRecord(String Email, String code, Date tiem) throws Exception {

        java.sql.Timestamp timestamp = new java.sql.Timestamp(tiem.getTime());
//        SendEmail.CreateEmail(Email,"Boollan","依梦汉化组","验证码为:["+code+"] 过期时间:"+timestamp.toString().substring(0,timestamp.toString().length()-4));
        String body = "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\"\n" +
                "        \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n" +
                "<html xmlns=\"http://www.w3.org/1999/xhtml\"\n" +
                "      style=\"font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;\">\n" +
                "<head>\n" +
                "    <meta name=\"viewport\" content=\"width=device-width\"/>\n" +
                "    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"/>\n" +
                "    <title>Billing e.g. invoices and receipts</title>\n" +
                "\n" +
                "\n" +
                "    <style type=\"text/css\">\n" +
                "        img {\n" +
                "            max-width: 100%;\n" +
                "        }\n" +
                "\n" +
                "        body {\n" +
                "            -webkit-font-smoothing: antialiased;\n" +
                "            -webkit-text-size-adjust: none;\n" +
                "            width: 100% !important;\n" +
                "            height: 100%;\n" +
                "            line-height: 1.6em;\n" +
                "        }\n" +
                "\n" +
                "        body {\n" +
                "            background-color: #f6f6f6;\n" +
                "        }\n" +
                "\n" +
                "        @media only screen and (max-width: 640px) {\n" +
                "            body {\n" +
                "                padding: 0 !important;\n" +
                "            }\n" +
                "\n" +
                "            h1 {\n" +
                "                font-weight: 800 !important;\n" +
                "                margin: 20px 0 5px !important;\n" +
                "            }\n" +
                "\n" +
                "            h2 {\n" +
                "                font-weight: 800 !important;\n" +
                "                margin: 20px 0 5px !important;\n" +
                "            }\n" +
                "\n" +
                "            h3 {\n" +
                "                font-weight: 800 !important;\n" +
                "                margin: 20px 0 5px !important;\n" +
                "            }\n" +
                "\n" +
                "            h4 {\n" +
                "                font-weight: 800 !important;\n" +
                "                margin: 20px 0 5px !important;\n" +
                "            }\n" +
                "\n" +
                "            h1 {\n" +
                "                font-size: 22px !important;\n" +
                "            }\n" +
                "\n" +
                "            h2 {\n" +
                "                font-size: 18px !important;\n" +
                "            }\n" +
                "\n" +
                "            h3 {\n" +
                "                font-size: 16px !important;\n" +
                "            }\n" +
                "\n" +
                "            .container {\n" +
                "                padding: 0 !important;\n" +
                "                width: 100% !important;\n" +
                "            }\n" +
                "\n" +
                "            .content {\n" +
                "                padding: 0 !important;\n" +
                "            }\n" +
                "\n" +
                "            .content-wrap {\n" +
                "                padding: 10px !important;\n" +
                "            }\n" +
                "\n" +
                "            .invoice {\n" +
                "                width: 100% !important;\n" +
                "            }\n" +
                "        }\n" +
                "    </style>\n" +
                "</head>\n" +
                "\n" +
                "<body itemscope itemtype=\"http://schema.org/EmailMessage\"\n" +
                "      style=\"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; -webkit-font-smoothing: antialiased; -webkit-text-size-adjust: none; width: 100% !important; height: 100%; line-height: 1.6em; background-color: #f6f6f6; margin: 0;\"\n" +
                "      bgcolor=\"#f6f6f6\">\n" +
                "\n" +
                "<table class=\"body-wrap\"\n" +
                "       style=\"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; width: 100%; background-color: #f6f6f6; margin: 0;\"\n" +
                "       bgcolor=\"#f6f6f6\">\n" +
                "    <tr style=\"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;\">\n" +
                "        <td style=\"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0;\"\n" +
                "            valign=\"top\"></td>\n" +
                "        <td class=\"container\" width=\"600\"\n" +
                "            style=\"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; display: block !important; max-width: 600px !important; clear: both !important; margin: 0 auto;\"\n" +
                "            valign=\"top\">\n" +
                "            <div class=\"content\"\n" +
                "                 style=\"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; max-width: 600px; display: block; margin: 0 auto; padding: 20px;\">\n" +
                "                <table class=\"main\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\"\n" +
                "                       style=\"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; border-radius: 3px; background-color: #fff; margin: 0; border: 1px solid #e9e9e9;\"\n" +
                "                       bgcolor=\"#fff\">\n" +
                "                    <tr style=\"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;\">\n" +
                "                        <td class=\"content-wrap aligncenter\"\n" +
                "                            style=\"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; text-align: center; margin: 0; padding: 20px; background-color:#333333\"\n" +
                "                            align=\"center\" valign=\"top\">\n" +
                "                            <table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\"\n" +
                "                                   style=\"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;\">\n" +
                "                                <tr style=\"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;\">\n" +
                "                                    <td class=\"content-block\"\n" +
                "                                        style=\"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0; padding: 0 0 20px;\"\n" +
                "                                        valign=\"top\">\n" +
                "<!--                                        <h1 class=\"aligncenter\"-->\n" +
                "<!--                                            style=\"font-family: 'Helvetica Neue',Helvetica,Arial,'Lucida Grande',sans-serif; box-sizing: border-box; font-size: 32px; color: #000; line-height: 1.2em; font-weight: 500; text-align: center; margin: 40px 0 0;\"-->\n" +
                "<!--                                            align=\"center\">依梦汉化组</h1>-->\n" +
                "                                    </td>\n" +
                "                                </tr>\n" +
                "                                <tr style=\"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;\">\n" +
                "                                    <td class=\"content-block\"\n" +
                "                                        style=\"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0; padding: 0 0 20px;\"\n" +
                "                                        valign=\"top\">\n" +
                "\n" +
                "                                        <img src=\"http://fly.boollan.pro/bootstrap-3.3.7-dist/imges/logimg_1.png\" alt=\"...\" class=\"img-rounded\">\n" +
                "                                        <h2 class=\"aligncenter\"\n" +
                "                                            style=\"font-family: 'Helvetica Neue',Helvetica,Arial,'Lucida Grande',sans-serif; box-sizing: border-box; font-size: 24px; color: white; line-height: 1.2em; font-weight: 400; text-align: center; margin: 40px 0 0;\"\n" +
                "                                            align=\"center\">依梦汉化组</h2>\n" +
                "                                    </td>\n" +
                "                                </tr>\n" +
                "                                <tr style=\"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;\">\n" +
                "                                    <td class=\"content-block aligncenter\"\n" +
                "                                        style=\"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; text-align: center; margin: 0; padding: 0 0 20px;\"\n" +
                "                                        align=\"center\" valign=\"top\">\n" +
                "                                        <table class=\"invoice\"\n" +
                "                                               style=\"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; text-align: left; width: 80%; margin: 40px auto;\">\n" +
                "                                            <tr style=\"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;\">\n" +
                "                                                <td style=\"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0; padding: 5px 0;color: white;\"\n" +
                "                                                    valign=\"top\">尊敬的游戏热爱者:<br\n" +
                "                                                        style=\"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;\"/>\n" +
                "                                                </td>\n" +
                "                                            </tr>\n" +
                "\n" +
                "                                            <tr style=\"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;\">\n" +
                "                                                <td style=\"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0; padding: 5px 0;\"\n" +
                "                                                    valign=\"top\">\n" +
                "                                                    <p style=\"color: white;\">您的邮箱验证为: <b>"+code+"</b>，请即使填写，完成验证。<br>(此验证码在 "+timestamp.toString().substring(0,timestamp.toString().length()-4)+" 之前有效)</p><br>\n" +
                "                                                </td>\n" +
                "                                            </tr>\n" +
                "\n" +
                "                                        </table>\n" +
                "                                    </td>\n" +
                "                                </tr>\n" +
                "                                <tr style=\"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;\">\n" +
                "                                    <td class=\"content-block aligncenter\"\n" +
                "                                        style=\"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; text-align: center; margin: 0; padding: 0 0 20px;\"\n" +
                "                                        align=\"center\" valign=\"top\">\n" +
                "                                        <a href=\"https://blogs.boollan.pro/\" style=\"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; color: white; text-decoration: underline; margin: 0;\">依梦汉化组</a>\n" +
                "                                        <br><br><a href=\"https://fly.boollan.pro\" style=\"color: white;\">泛滥原Ⅱ</a>\n" +
                "                                    </td>\n" +
                "                                </tr>\n" +
                "                                <tr style=\"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;\">\n" +
                "                                    <td class=\"content-block aligncenter\"\n" +
                "                                        style=\"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; text-align: center; margin: 0; padding: 0 0 20px;\"\n" +
                "                                        align=\"center\" valign=\"top\">\n" +
                "                                    </td>\n" +
                "                                </tr>\n" +
                "                            </table>\n" +
                "                        </td>\n" +
                "                    </tr>\n" +
                "                </table>\n" +
                "                <div class=\"footer\"\n" +
                "                     style=\"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; width: 100%; clear: both; color: #999; margin: 0; padding: 20px;\">\n" +
                "                    <table width=\"100%\"\n" +
                "                           style=\"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;\">\n" +
                "                        <tr style=\"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;\">\n" +
                "                        </tr>\n" +
                "                    </table>\n" +
                "                </div>\n" +
                "            </div>\n" +
                "        </td>\n" +
                "        <td style=\"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0;\"\n" +
                "            valign=\"top\"></td>\n" +
                "    </tr>\n" +
                "</table>\n" +
                "</body>\n" +
                "</html>";

        SendEmail.CreateEmail(Email,"Boollan","依梦汉化组",body);

    }

    //用于用户验证
    public boolean EmailCode(String UserName, String EmailoLD,String EmailNew,String Code){
        try {
            SQLdatabase sqLdatabase = new SQLdatabase();
            Connection connection = sqLdatabase.Mysql_SQL(SQLConfig.MYSQL_JDBCSQL, SQLConfig.MYSQL_USER, SQLConfig.MYSQL_PASSWORD);
            //创建SQL 连接
            Statement stm = connection.createStatement();
            java.util.Date date = new java.util.Date();
            java.sql.Timestamp timestamp = new java.sql.Timestamp(date.getTime());

            ResultSet resultSet = stm.executeQuery("select * from EmailCode where email='"+EmailoLD+"' and code='"+Code+"' and effective>'"+timestamp+"'");
            if(resultSet.next()){
                String code = resultSet.getString("code");
                if (Code.equals(code)==true){
                    ResultSet isemail = stm.executeQuery("select * from accout_user where email='"+EmailNew+"'");
                    if (isemail.next()==false){
                        int resultSet_email = stm.executeUpdate("update accout_user set email='"+EmailNew+"' where username='"+UserName+"'");
                        if (resultSet_email==1){
                            return true;
                        }else {
                            return false;
                        }
                    }else {
                        return false;
                    }
                }else {
                    return false;
                }
            }else {
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    public boolean EmailCode(String Email,String Code){
        try {
            SQLdatabase sqLdatabase = new SQLdatabase();
            Connection connection = sqLdatabase.Mysql_SQL(SQLConfig.MYSQL_JDBCSQL, SQLConfig.MYSQL_USER, SQLConfig.MYSQL_PASSWORD);
            //创建SQL 连接
            Statement stm = connection.createStatement();
            java.util.Date date = new java.util.Date();
            java.sql.Timestamp timestamp = new java.sql.Timestamp(date.getTime());

            ResultSet resultSet = stm.executeQuery("select * from EmailCode where email='"+Email+"' and code='"+Code+"' and effective>'"+timestamp+"'");
            if(resultSet.next()){
                return true;
//                String code = resultSet.getString("code");
            }else {
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }



}

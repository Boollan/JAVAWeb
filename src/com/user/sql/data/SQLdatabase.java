package com.user.sql.data;


import com.user.sql.datainteface.interfaceSqldata;
import com.user.sql.encryption;
import org.json.simple.JSONObject;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;

public class SQLdatabase implements interfaceSqldata {

    //MySQL连接
    @Override
    public Connection Mysql_SQL(String SQL, String SQL_User, String Passowrd) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(SQL, SQL_User, Passowrd);

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }

    }
    //用户的登录验证
    @Override
    public boolean User_Login_mysql(String User, String Password, Connection mysqlcon) {
        try {
            String Password_encryption = encryption.StringInMd5(Password);
            Statement stm = mysqlcon.createStatement();
            ResultSet resultSet = stm.executeQuery("select * from accout_user where username='" + User + "'");
            if (resultSet.next()) {
                String username = resultSet.getString("username");
                String password = resultSet.getString("password");
                if (username != null) {
                    if (Password_encryption.equals(password) == true) {

                        return true;

                    } else {
                        return false;
                    }
                } else {
                    return false;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    //用户注册
    @Override
    public boolean User_reg_mysql(String User, String Password, String Email, Connection mysqlcon) {

        try {


            Statement stm = mysqlcon.createStatement();

            ResultSet resultSet = stm.executeQuery("select * from accout_user where username='" + User + "'");

            if (resultSet.next() == false) {
                int is = stm.executeUpdate("INSERT INTO accout_user(username,password,email)VALUES('" + User + "','" + encryption.StringInMd5(Password) + "','" + Email + "')");
                if (is == 1) {
                    return true;
                } else {
                    return false;
                }
            } else {
                return false;
            }


        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

    }
    //用户的登录信息
    @Override
    public boolean User_login_record_mysql(String User, String IP, String client, java.util.Date datetime, Connection mysqlcon) {
        try {
            Statement stm = mysqlcon.createStatement();
            java.sql.Timestamp timestamp = new java.sql.Timestamp(datetime.getTime());
            int is = stm.executeUpdate("INSERT INTO login_record(username,addip,client,datetime)VALUES('" + User + "','" + IP + "','" + client + "','" + timestamp + "')");
            if (is == 1) {
                return true;
            } else {
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //更新密码
    public boolean User_UpdataPwd_mysql(String User, String passowrd_old, String passowrd_new, Connection mysqlcon) {
        try {
            passowrd_old = encryption.StringInMd5(passowrd_old.trim());
            passowrd_new = encryption.StringInMd5(passowrd_new.trim());

            Statement stm = mysqlcon.createStatement();
            ResultSet resultSet = stm.executeQuery("select * from accout_user where username='" + User + "'");
            if (resultSet.next()) {
                String password_mysql = resultSet.getString("password");
                if (password_mysql.equals(passowrd_old) == true) {
                    int is = stm.executeUpdate("update accout_user set password='" + passowrd_new + "' where username='" + User + "'");
                    if (is == 1) {
                        return true;
                    } else {
                        return false;
                    }
                } else {
                    return false;
                }
            } else {
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

    }
    //查询用户的信息
    @Override
    public JSONObject GetinfoUser(String UserName, Connection mysqlcon) {
        try {
            Statement stm = mysqlcon.createStatement();
            ResultSet resultSet = stm.executeQuery("select * from accout_user where username='" + UserName.trim() + "'");
            if (resultSet.next()) {
                //信息获取
                JSONObject json = new JSONObject();
                json.put("username", resultSet.getString("username"));
                json.put("password", resultSet.getString("password"));
                json.put("email", resultSet.getString("email"));
                json.put("donations", resultSet.getString("donations"));
                json.put("permissions", resultSet.getString("permissions"));

                return json;
                //end

            } else {
                return null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
    //利用邮箱查询用户信息
    @Override
    public JSONObject GetinfoEmail(String Email, Connection mysqlcon) {
        try {
            Statement stm = mysqlcon.createStatement();
            ResultSet resultSet = stm.executeQuery("select * from accout_user where username='" + Email.trim() + "'");
            int i = 0;
            //解决JSON名称冲突问题
            JSONObject json = new JSONObject();
            while (resultSet.next()) {
                String str = String.valueOf(i);
                String temp = "username_" + str;
                json.put(temp, resultSet.getString("username"));
            }

            return json;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

    }
    //判断是否是管理员
    @Override
    public boolean Admin_is(String Admin, Connection mysqlcon) {

        try {
            Statement stm = mysqlcon.createStatement();
            ResultSet resultSet = stm.executeQuery("select * from accout_user where username='" + Admin.trim() + "'");

            if (resultSet.next()) {
                int permissions = resultSet.getInt("permissions");
                if (permissions > 0 && permissions < 4) {
                    return true;
                }
            } else {
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    //使用管理员权限更改其他用户的密码
    @Override
    public boolean Admin_Updata_Passwrod(String Admin, String UserName, String UserPassowrd, Connection mysqlcon) {

        try {
            String md5Passowrd = encryption.StringInMd5(UserPassowrd);
            //判断你是否是管理员
            if (Admin_is(Admin, mysqlcon) == true) {
                //比较权限

                JSONObject jsonuser = GetinfoUser(UserName.trim(), mysqlcon);

                JSONObject jsonadmin = GetinfoUser(Admin.trim(), mysqlcon);

                if (jsonadmin != null && jsonadmin != null) {
                    Object accoutadmin = jsonadmin.get("permissions");
                    Object accoutuser = jsonuser.get("permissions");
                    int admin = Integer.parseInt(accoutadmin.toString());
                    int user = Integer.parseInt(accoutuser.toString());
                    if (admin > user) {

                        Statement stm = mysqlcon.createStatement();
                        int i = stm.executeUpdate("UPDATE accout_user set password='" + md5Passowrd + "' where username='" + UserName + "' ");
                        if (i > 0) {
                            return true;
                        }
                    }
                }


            } else {
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    //使用管理员权限更改其他用户的邮箱
    @Override
    public boolean Admin_Updata_Email(String Admin, String UserName, String UserNweEmail, Connection mysqlcon) {

        try {
            if (Admin_is(Admin, mysqlcon) == true) {
                Statement stm = mysqlcon.createStatement();
                int i = stm.executeUpdate("UPDATE accout_user set email='" + UserNweEmail + "' where username='" + UserName + "' ");
                if (i > 0) {
                    return true;
                }
            } else {
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    //使用管理员权限查询所有记录(登录记录)
    @Override
    public ResultSet Admin_Select_Record_Resultset(String UserName, java.util.Date StartTiem, java.util.Date EndTime, String platform, Connection mysqlcon) {

        try {
            String StartTiem_stamp = null;
            String EndTime_stamp = null;
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            if (StartTiem != null) {
                long time = StartTiem.getTime();
                StartTiem_stamp = sdf.format(time);
            }
            if (EndTime != null) {
                long time = EndTime.getTime();
                EndTime_stamp = sdf.format(time);
            }


            //全都知道
            if (UserName != null && StartTiem != null && EndTime != null) {


                Statement stm = mysqlcon.createStatement();
                ResultSet sqldata = stm.executeQuery("Select * from login_record where username='" + UserName + "' and  " + EndTime_stamp + "<datetime and datetime>" + StartTiem_stamp + " and client='" + platform + "'");
                return sqldata;
            } else {
                //全都不知道
                if (UserName == null || UserName == "" && StartTiem == null && EndTime == null) {


                    Statement stm = mysqlcon.createStatement();
                    ResultSet sqldata = stm.executeQuery("Select * from login_record where client='" + platform + "'");
                    return sqldata;
                } else {

                    //知道用户名 不知道时间范围
                    if (UserName != null && StartTiem == null && EndTime == null) {


                        Statement stm = mysqlcon.createStatement();
                        ResultSet sqldata = stm.executeQuery("Select * from login_record where username='" + UserName + "' and client='" + platform + "'");
                        return sqldata;
                    } else {
                        //不知道用户名知道时间
                        if (UserName == null && StartTiem != null && EndTime != null) {

                            Statement stm = mysqlcon.createStatement();
                            ResultSet sqldata = stm.executeQuery("Select * from login_record where " + EndTime_stamp + "<datetime and datetime>" + StartTiem_stamp + " and client='" + platform + "'");
                            return sqldata;
                        } else {
                            //不知道用户名 不知道开始时间 知道结束时间
                            if (UserName == null && StartTiem == null && EndTime != null) {


                                Statement stm = mysqlcon.createStatement();
                                ResultSet sqldata = stm.executeQuery("Select * from login_record where " + EndTime_stamp + "<datetime and client='" + platform + "'");
                                return sqldata;
                            } else {

                                //不知道用户名 知道开始时间 不知道结束时间

                                if (UserName == null && StartTiem != null && EndTime == null) {


                                    Statement stm = mysqlcon.createStatement();
                                    ResultSet sqldata = stm.executeQuery("Select * from login_record where datetime>" + StartTiem_stamp + " and client='" + platform + "'");
                                    return sqldata;
                                } else {
                                    //知道用户名 知道开始时间 不知道结束时间
                                    if (UserName != null && StartTiem != null && EndTime == null) {

                                        Statement stm = mysqlcon.createStatement();
                                        ResultSet sqldata = stm.executeQuery("Select * from login_record where username='" + UserName + "' and datetime>" + StartTiem_stamp + " and client='" + platform + "'");
                                        return sqldata;
                                    } else {
                                        //知道用户名 不知道开始时间 知道结束时间
                                        if (UserName != null && StartTiem == null && EndTime != null) {


                                            Statement stm = mysqlcon.createStatement();
                                            ResultSet sqldata = stm.executeQuery("Select * from login_record where username='" + UserName + "' and " + EndTime_stamp + "<datetime and client='" + platform + "'");
                                            return sqldata;
                                        } else {

                                            return null;
                                        }
                                    }
                                }
                            }
                        }

                    }

                }


            }


//            Statement stm = mysqlcon.createStatement();
//            int i = stm.executeUpdate("Select * from login_record where ");


        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

    }
    //使用管理员权限生成CDK卡密
    public boolean Admin_inset_cdk(String cdk, String money, Date overduetime, Connection mysqlcon) {

        try {
            Statement stm = mysqlcon.createStatement();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String format = sdf.format(overduetime);
            int is = stm.executeUpdate("INSERT INTO accout_cdk(cdk,money,effective,overduetime)VALUES('" + cdk.trim() + "','" + money.trim() + "',0,'" + format + "')");
            if (is == 1) {
                return true;
            } else {
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    //用户提交卡密
    public boolean Acoout_send_Cdk(String username, String key, Connection mysqlcon) {

        try {
            Statement stm = mysqlcon.createStatement();
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String format = sdf.format(date);
            ResultSet resultSet = stm.executeQuery("select * from accout_cdk where cdk='" + key.trim() + "' and overduetime<'" + format + "' and effective=0");
            if (resultSet.next()) {
                double permissions = resultSet.getDouble("money");
                ResultSet resultSet_user = stm.executeQuery("select * from accout_user where username='" + username.trim() + "'");
                if (resultSet_user.next()) {
                    double donations = (double) resultSet_user.getInt("donations");
                    int peace = (int) (donations + permissions);
                    if (peace > 4) {

                        int i = stm.executeUpdate("UPDATE accout_user set donations=" + peace + ",permissions=2 where username='" + username.trim() + "'");
                        stm.executeUpdate("update accout_cdk set effective=1 where cdk='" + key.trim() + "'");
                        if (i > 0) {
                            return true;
                        } else {
                            return false;
                        }
                    } else {
                        int i = stm.executeUpdate("UPDATE accout_user set donations=" + peace + ",permissions=2 where username='" + username.trim() + "'");
                        stm.executeUpdate("update accout_cdk set effective=1 where cdk='" + key.trim() + "'");
                        if (i > 0) {
                            return true;
                        } else {
                            return false;
                        }
                    }
                }


            } else {
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;

    }

    //读取首页内容
    public JSONObject Get_Home_Show_Text(Connection mysqlcon) {

        try {
            Statement stm = mysqlcon.createStatement();
            ResultSet resultSet = stm.executeQuery("select * from Home_Show where id=1");
            if (resultSet.next()) {
                String homeTite = resultSet.getString("HomeTite"); //标题
                String HomeText = resultSet.getString("HomeText");//内容
                String imge_1 = resultSet.getString("imge_1");//播放栏图片1
                String imge_2 = resultSet.getString("imge_2");//播放栏图片1
                String imge_3 = resultSet.getString("imge_3");//播放栏图片1
                Date updata_time = resultSet.getDate("updata_time");//更新时间

                JSONObject json = new JSONObject();
                json.put("homeTite", homeTite);
                json.put("HomeText", HomeText);
                json.put("imge_1", imge_1);
                json.put("imge_2", imge_2);
                json.put("imge_3", imge_3);
                json.put("updata_time", updata_time);

                return json;
            } else {
                return null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;

    }

    //以管理员身份写入首页内容
    public boolean Set_Home_Show_Text(String Title, String Text, String imge_1, String imge_2, String imge_3, Connection mysqlcon) {

        try {
            Statement stm = mysqlcon.createStatement();
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String format = sdf.format(date);
            int i = stm.executeUpdate("update Home_Show set HomeTite=" + Title + " and HomeText=" + Text + " and imge_1=" + imge_1 + " and imge_2=" + imge_2 + " and imge_3=" + imge_3 + " and updata_time=" + format + " where id=1");
            if (i > 0) {
                return true;
            } else {
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


}




package com.Servlet;

import com.user.sql.SQLConfig;
import com.user.sql.data.SQLdatabase;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

@WebServlet(name = "com.Servlet.Login_SQLServer_Servlet",urlPatterns = "/login_sqlserver")
public class Login_SQLServer_Servlet extends HttpServlet {

}

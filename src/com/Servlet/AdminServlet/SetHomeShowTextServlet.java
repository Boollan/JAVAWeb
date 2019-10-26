package com.Servlet.AdminServlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.util.Base64;

@WebServlet(name = "SetHomeShowTextServlet")
public class SetHomeShowTextServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String title = request.getParameter("Title"); //标题
        String text = request.getParameter("Text");//内容
        String imge_1 = request.getParameter("imge_1");//图片
        String imge_2 = request.getParameter("imge_2");
        String imge_3 = request.getParameter("imge_3");

    }

    private void SetHomeTextShow(){



    }
}

package com.user.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.DAO.UserDAOImpl;
import com.DB.DBConnect;
import com.entity.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            UserDAOImpl dao = new UserDAOImpl(DBConnect.getConn());
            HttpSession session = req.getSession();

            String email = req.getParameter("email");
            String password = req.getParameter("password");

            // ADMIN LOGIN
            if ("admin@gmail.com".equals(email) && "admin".equals(password)) {
                User us = new User();
                us.setName("Admin");
                session.setAttribute("userobj", us);
                resp.sendRedirect("admin/home.jsp");
                return;
            }

            // USER LOGIN
            User us = dao.login(email, password);
            if (us != null) {
                session.setAttribute("userobj", us);
                resp.sendRedirect("index.jsp");
            } else {
                session.setAttribute("failedMsg", "Email & Password Invalid");
                resp.sendRedirect("login.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

package com.user.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DAO.BookDAOImpl;
import com.DAO.CartDAOImpl;
import com.DB.DBConnect;
import com.entity.BookDtls;
import com.entity.Cart;
import com.entity.User;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            // ✅ get book id from URL
            int bid = Integer.parseInt(req.getParameter("bid"));

            // ✅ get user from session
            HttpSession session = req.getSession();
            User u = (User) session.getAttribute("userobj");

            if (u == null) {
                resp.sendRedirect("login.jsp");
                return;
            }

            int uid = u.getId();

            // ✅ fetch book details
            BookDAOImpl dao = new BookDAOImpl(DBConnect.getConn());
            BookDtls b = dao.getBookById(bid);

            if (b == null) {
                System.out.println("Book not found");
                return;
            }

            // ✅ create cart object
            Cart c = new Cart();
            c.setBid(bid);
            c.setUserId(uid);
            c.setBookName(b.getBookName());
            c.setAuthor(b.getAuthor());

            double price = Double.parseDouble(b.getPrice().trim());
            c.setPrice(price);
            c.setTotalPrice(price);

            // ✅ save to DB
            CartDAOImpl dao2 = new CartDAOImpl(DBConnect.getConn());
            boolean f = dao2.addCart(c);

            if (f) {
                session.setAttribute("addCart", "Book Added to Cart");
            } else {
                session.setAttribute("failed", "Something went wrong");
            }

            resp.sendRedirect("all_new_book.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

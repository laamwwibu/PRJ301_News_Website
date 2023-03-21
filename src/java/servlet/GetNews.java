package servlet;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import dao.*;
import model.*;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;

/**
 *
 * @author Asus
 */
@WebServlet(name = "GetNews", urlPatterns = {"/GetNews"})
public class GetNews extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            News news;
            NewsDAO newsDAO = new NewsDAO();
            catDAO catDAO = new catDAO();
            userDAO userDAO = new userDAO();
            CommentDAO commentDAO = new CommentDAO();
            int news_id = Integer.parseInt(request.getParameter("news_id"));

            news = newsDAO.getNews(news_id);

            int cat_id = news.getCat_id();

            ArrayList<News> sameCategoryNews = newsDAO.searchCategory(cat_id);
            ArrayList<Comments> commentList = commentDAO.getListComment(news_id);
            HashMap<Integer, Category> categoryList = catDAO.getAllCategorys();
            HashMap<Integer, User> userList = userDAO.getAllUser();

            User user = (User) request.getSession().getAttribute("user");

            if (user != null) {
                int user_Id = user.getId();
                String status = null;
                SaveDAO save = new SaveDAO();

                if (save.findSaveId(user_Id, news_id) == 0) {
                    status = "unsaved";
                } else {
                    status = "saved";
                }
                request.setAttribute("status", status);
            }
            request.setAttribute("news", news);
            request.setAttribute("sameCategoryNews", sameCategoryNews);
            request.setAttribute("commentList", commentList);
            request.setAttribute("user_list", userList);

            getListComments(request, response, news_id);
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void getListComments(HttpServletRequest request, HttpServletResponse response, int news_id) {
        try {
            CommentDAO commentDAO = new CommentDAO();
            ArrayList<Comments> listComments = commentDAO.getListComment(news_id);
            request.setAttribute("listComments", listComments);
            request.getRequestDispatcher("newsInfo.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}
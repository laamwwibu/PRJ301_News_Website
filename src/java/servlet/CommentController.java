    /*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import dao.CommentDAO;
import model.Comments;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.User;

/**
 *
 * @author Asus
 */
@WebServlet(name="CommentController", urlPatterns={"/CommentController"})

public class CommentController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        NewsDAO newsDAO = new NewsDAO();
//        ArrayList<News> list = newsDAO.getListNews(10);
//        request.setAttribute("listNews", list);
//        RequestDispatcher rd = request.getRequestDispatcher("main.jsp");
//        rd.forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            if (action == null || action.length() == 0) {
                action = "list";
            }
            switch (action) {
                case "list":
                    getListComments(request, response);
                    break;
                case "insert":
                    insertComment(request, response);
                    break;
                case "update":
                    updateComment(request, response);
                    break;
                default:
                    getListComments(request, response);
                    break;
            }
        } catch (Exception e) {

        }
    }

    private void getListComments(HttpServletRequest request, HttpServletResponse response) {
        ArrayList<Comments> listComments = new ArrayList<>();
        try {
            CommentDAO commentDAO = new CommentDAO();
            int news_id = Integer.parseInt(request.getParameter("news_id"));
            listComments = commentDAO.getListComment(news_id);
            request.setAttribute("listComments", listComments);
            request.getRequestDispatcher("showNew.jsp").forward(request, response);//need JSP LOCATION
        } catch (Exception e) {
            System.out.println("ERROR SHOWING LIST COMMENTS");
        }
    }

    private void insertComment(HttpServletRequest request, HttpServletResponse response) {
        try {
            CommentDAO commentDAO = new CommentDAO();
            User user = (User) request.getSession().getAttribute("user");
            if(user == null) System.out.println("null user");
            int user_id =user.getId();
            int news_id = Integer.parseInt(request.getParameter("news_id"));
            String comment_content = request.getParameter("comment_content");

            Comments comment = new Comments(user_id, news_id, comment_content);
            if(commentDAO.insertComments(comment)) System.out.println("cant insert comment");;
            
            response.sendRedirect("GetNews?news_id="+news_id);
        } catch (Exception e) {
            System.out.println("ERROR INSERTING COMMENT");
        }

    }

    private void updateComment(HttpServletRequest request, HttpServletResponse response) {
        try {
            CommentDAO commentDAO = new CommentDAO();

            int comment_id = Integer.parseInt(request.getParameter("comment_id"));
            String comment_content = request.getParameter("comment_content");
            Comments comment = new Comments(comment_id, comment_content);
            commentDAO.updateComments(comment);//update comment into database
            int news_id = Integer.parseInt(request.getParameter("news_id"));
            response.sendRedirect("GetNews?news_id="+news_id);
        } catch (Exception e) {
            System.out.println("ERROR UPDATING COMMENT");
        }

    }

   
}

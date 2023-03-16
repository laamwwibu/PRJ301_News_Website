/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package servlet;

import dao.NewsDAO;
import dao.catDAO;
import dao.userDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import model.Category;
import model.News;
import model.User;

/**
 *
 * @author Asus
 */
@WebServlet(name="publicUserInfo", urlPatterns={"/publicUserInfo"})

public class publicUserInfo extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet publicUserInfo</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet publicUserInfo at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try{
            userDAO userDAO = new userDAO();
            NewsDAO newsDAO = new NewsDAO();
            catDAO  catDAO = new catDAO();
            int user_id = Integer.parseInt(request.getParameter("user_id"));
            HashMap<Integer,Category> cat_list = catDAO.getAllCategorys();
                    
            User user = userDAO.getUser(user_id);
            if (user.isIsAdmin()){
                ArrayList<News> list = userDAO.GetAllAdminNews(user);
                request.setAttribute("posted_news", list);
            }
            request.getSession().setAttribute("cat_list", cat_list);
            request.setAttribute("user", user);
            request.getRequestDispatcher("publicUserInfo.jsp").forward(request, response);
        } catch(Exception e){
            System.out.println(e);
            request.setAttribute("error", "Username or password is incorrect !");
            request.setAttribute("return_page", "login.jsp");
            request.getRequestDispatcher("ErrorPage.jsp").forward(request, response);
        }
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package servlet;
import dao.userDAO;
import model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Inspiron
 */
@WebServlet(name="UserUpdate", urlPatterns={"/UserUpdate"})
public class UserUpdate extends HttpServlet {
   
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
            out.println("<title>Servlet UserUpdate</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserUpdate at " + request.getContextPath () + "</h1>");
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
        String mess = null;
        try {
            userDAO userdao = new userDAO();
            int id = Integer.parseInt(request.getParameter("id"));
            String username = request.getParameter("username");
            String pass = request.getParameter("pass");
            String realname = request.getParameter("realname");
            String gender = request.getParameter("gender");
            String strDate = request.getParameter("dob");
            DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            Date dob = df.parse(strDate);
            User user = (User)request.getSession().getAttribute("user");
            if(!username.equals(user.getUname())){ // check username update giong
            if(userdao.CheckDuplicate(username)) throw new NumberFormatException();
            }
            User up_user = new User(id, pass, realname, username, gender, false,dob);
            if(userdao.updateUser(up_user)){
            User new_user = userdao.Login(username, pass);
                        System.out.println("Upuser: "+ new_user.getGender()+" "+new_user.getDob()+" "+new_user.getName()+" "+new_user.getUname());
            request.getSession().setAttribute("user", new_user);
            }
            response.sendRedirect("MainPage");
        } catch (Exception e) {
            request.setAttribute("error", mess);
            request.setAttribute("return_page", "editUserInfo.jsp");
            request.getRequestDispatcher("ErrorPage.jsp").forward(request, response);
        }
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

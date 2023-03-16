/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

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
@WebServlet(name = "Search", urlPatterns = {"/Search"})
public class Search extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String title = request.getParameter("title");
            System.out.println(title);
            String rawCategoryId = request.getParameter("cat_id");

            if (title == null || title.trim().length() == 0) {//if user entered no title in search bar
                if (rawCategoryId == null) {
                    request.getRequestDispatcher("GetListNews");   //if user did NOT chose a category choice  
                } else {//if category id is given
                    searchByCategory(request, response, Integer.parseInt(rawCategoryId));//find by category id
                }
            } else {//if user DID entered a title in search bar
                if (rawCategoryId == null) {//if user did NOT chose a category choice 
                    searchByTitle(request, response, title);//find by title
                } else {//if user did choose a category and entered in a title
                    searchByTitleAndCateogory(request, response, title, Integer.parseInt(rawCategoryId));
                }
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    private void searchByTitle(HttpServletRequest request, HttpServletResponse response, String title) {
        try {
            NewsDAO newsDAO = new NewsDAO();
            userDAO userDAO = new userDAO();

            ArrayList<News> listNews = newsDAO.searchTitle(title);
            HashMap<Integer, User> listUser = userDAO.getAllUser();

            request.setAttribute("news_list", listNews);
            request.setAttribute("user_list", listUser);
            request.setAttribute("title", title);

            request.getRequestDispatcher("searchResult.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    private void searchByCategory(HttpServletRequest request, HttpServletResponse response, int cat_id) {
        try {
            NewsDAO newsDAO = new NewsDAO();
            userDAO userDAO = new userDAO();

            ArrayList<News> news_list = newsDAO.searchCategory(cat_id);
            HashMap<Integer, User> user_list = userDAO.getAllUser();

            request.setAttribute("news_list", news_list);
            request.setAttribute("user_list", user_list);

            request.getRequestDispatcher("Category.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    private void searchByTitleAndCateogory(HttpServletRequest request, HttpServletResponse response, String title, int cat_id) {
        try {
            NewsDAO newsDAO = new NewsDAO();
            userDAO userDAO = new userDAO();

            ArrayList<News> news_list = newsDAO.searchTitleCat(title, cat_id);
            HashMap<Integer, User> user_list = userDAO.getAllUser();

            request.setAttribute("news_list", news_list);
            request.setAttribute("user_list", user_list);
            request.setAttribute("title", title);

            request.getRequestDispatcher("searchResult.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("ERROR SEARCHING NEWS BY TITLE AND CATEGORY");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}

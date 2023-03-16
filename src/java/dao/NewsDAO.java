/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.News;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author Asus
 */
public class NewsDAO {

    public ArrayList<News> getAllNews() {
        ArrayList<News> list = new ArrayList<>();
        News news;
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            if (con != null) {
                String sql = "Select * from News "
                        + "ORDER BY News_id desc ;";
                Statement call = con.createStatement();
                ResultSet rs = call.executeQuery(sql);
                while (rs.next()) {             //needed even if just 1 row       
                    news = new News();
                    news.setUser_id(rs.getInt("User_id"));
                    news.setNews_id(rs.getInt("News_id"));
                    news.setCat_id(rs.getInt("Cat_id"));
                    news.setTitle(rs.getString("News_title"));
                    news.setSubtitle(rs.getString("News_subtitle"));
                    news.setImage(rs.getString("News_image"));
                    list.add(news);
                }
                call.close();
                con.close();
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

//    public ArrayList<News> getListNews(int amountOfNews) {//get x amount of latest news
//        ArrayList<News> listNews = new ArrayList<>();
//        News news;
//        try {
//            DBContext db = new DBContext();
//            Connection con = db.getConnection();
//            Statement st = con.createStatement();
//            String sql = "SELECT TOP " + amountOfNews + " * "
//                    + "FROM News n, Category c "
//                    + "WHERE n.Cat_id = c.Cat_id "
//                    + "ORDER BY n.News_id desc ;";
//            ResultSet rs = st.executeQuery(sql);
//            while (rs.next()) {
//                news = new News();
//                news.setUser_id(rs.getInt("User_id"));
//                news.setNews_id(rs.getInt("News_id"));
//                news.setCat_id(rs.getInt("Cat_id"));
//                news.setTitle(rs.getString("News_title"));
//                news.setSubtitle(rs.getString("News_subtitle"));
//                news.setImage(rs.getString("News_image"));
//                listNews.add(news);
//            }
//            st.close();
//            con.close();
//        } catch (Exception e) {
//            System.out.println("Error");
//        }
//        return listNews;
//    }

    public News getNews(int news_id) {//get all content in a news given news id
        News news = null;
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            Statement st = con.createStatement();
            String sql = " SELECT * "
                    + " FROM News n, Category c "
                    + " WHERE n.Cat_id = c.Cat_id "
                    + " AND n.News_id =  " + news_id + ";";
            ResultSet rs = st.executeQuery(sql);

            rs.next();
            news = new News();
            news.setUser_id(rs.getInt("User_id"));
            news.setNews_id(rs.getInt("News_id"));
            news.setCat_id(rs.getInt("Cat_id"));
            news.setTitle(rs.getString("News_title"));
            news.setContent(rs.getString("News_content"));
            news.setSubtitle(rs.getString("News_subtitle"));
            news.setImage(rs.getString("News_image"));;

            st.close();
            con.close();
        } catch (Exception e) {
            System.out.println("Error");
        }
        return news;
    }

    public void insertNews(News news) {//inserting news
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            String sql = "{call insert_news(?,?,?,?,?,?)}";
            CallableStatement st = con.prepareCall(sql);
            //truyen tham so
            st.setInt(1, news.getUser_id());
            st.setInt(2, news.getCat_id());
            st.setString(3, news.getTitle());
            st.setString(4, news.getSubtitle());
            st.setString(5, news.getContent());
            st.setString(6, news.getImage());

            if (st.executeUpdate() != 1) {
                System.out.println("ERROR INSERTING NEWS");
            }
            st.close();
            con.close();
        } catch (Exception e) {
            System.out.println("amgous");
        }
    }

    public void deleteNews(int news_id) {
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            String sql = "{call delete_news(?)}";
            CallableStatement st = con.prepareCall(sql);
            //truyen tham so
            st.setInt(1, news_id);
            if (st.executeUpdate() != 1) {
                System.out.println("ERROR DELETING NEWS");
            }
            st.close();
            con.close();
        } catch (Exception e) {
            System.out.println("Error");
        }
    }

    public void updateNews(News news) {
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            String sql = "{call update_news(?,?,?,?,?,?)}";
            CallableStatement st = con.prepareCall(sql);
            //truyen tham so
            st.setInt(1, news.getNews_id());
            st.setInt(2, news.getCat_id());
            st.setString(3, news.getTitle());
            st.setString(4, news.getSubtitle());
            st.setString(5, news.getContent());
            st.setString(6, news.getImage());

            if (st.executeUpdate() != 1) {
                System.out.println("ERROR UPDATING NEWS");
            }
            st.close();
            con.close();
        } catch (Exception e) {
            System.out.println("Error");
        }
    }

    public ArrayList<News> searchTitle(String title) {
        ArrayList<News> listNews = new ArrayList<>();
        News news;
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            Statement st = con.createStatement();
            String sql = "SELECT * "
                    + "FROM News  "
                    + "WHERE News_title LIKE N'%" + title + "%' ;";
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                news = new News();
                news.setUser_id(rs.getInt("User_id"));
                news.setNews_id(rs.getInt("News_id"));
                news.setCat_id(rs.getInt("Cat_id"));
                news.setTitle(rs.getString("News_title"));
                news.setSubtitle(rs.getString("News_subtitle"));
                news.setContent(rs.getString("News_content"));
                news.setImage(rs.getString("News_image"));
                listNews.add(news);
            }
            st.close();
            con.close();
        } catch (Exception e) {

        }
        return listNews;
    }

    public ArrayList<News> searchCategory(int cat_id) {
        ArrayList<News> listNews = new ArrayList<>();
        News news = new News();
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            Statement st = con.createStatement();
            String sql = "SELECT * "
                    + "FROM News "
                    + "WHERE Cat_id = " + cat_id;
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                news = new News();
                news.setUser_id(rs.getInt("User_id"));
                news.setNews_id(rs.getInt("News_id"));
                news.setCat_id(rs.getInt("Cat_id"));
                news.setTitle(rs.getString("News_title"));
                news.setSubtitle(rs.getString("News_subtitle"));
                news.setContent(rs.getString("News_content"));
                news.setImage(rs.getString("News_image"));
                listNews.add(news);
            }
            st.close();
            con.close();
        } catch (Exception e) {

        }
        return listNews;
    }

    public ArrayList<News> searchTitleCat(String title, int cat_id) {
        ArrayList<News> listNews = new ArrayList<>();
        News news = new News();
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            Statement st = con.createStatement();
            String sql = "SELECT * "
                    + "FROM News c "
                    + "WHERE News_title LIKE N'%" + title + "%' AND Cat_id = " + cat_id;
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                news = new News();
                news.setUser_id(rs.getInt("User_id"));
                news.setNews_id(rs.getInt("News_id"));
                news.setCat_id(rs.getInt("Cat_id"));
                news.setTitle(rs.getString("News_title"));
                news.setSubtitle(rs.getString("News_subtitle"));
                news.setContent(rs.getString("News_content"));
                news.setImage(rs.getString("News_image"));
                listNews.add(news);
            }
            st.close();
            con.close();
        } catch (Exception e) {

        }
        return listNews;
    }

    public int getLatestId() {
        int latest_id = 0;
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            Statement st = con.createStatement();
            String sql = "SELECT "
                    + "  CASE "
                    + "    WHEN (SELECT "
                    + "        COUNT(1) "
                    + "      FROM News ) = 0 THEN 1 "
                    + "    ELSE IDENT_CURRENT('News') "
                    + "  END AS latest_id;";
            ResultSet rs = st.executeQuery(sql);
            rs.next();
            latest_id = rs.getInt("latest_id");

            st.close();
            con.close();
        } catch (Exception e) {
            System.out.println("amogus");
        }
        return latest_id;
    }

//    public static void main(String[] args) {
//        News news = new News(1, 1, "lờ 'mao", "lờ mao", "lờ mao", "https;");
//        insertNews(news);
//        deleteNews(2);
//        News news = new News(1, 1, 1,"mao","mao", " mao", " mao", "https;");
//        updateNews(news);
//
//        ArrayList<News> listNews = searchCategory(1);
//        ArrayList<News> listNews = getNews(5);
//        for (News i : listNews) {
//            System.out.println(i);
//        }
//
//    }
}
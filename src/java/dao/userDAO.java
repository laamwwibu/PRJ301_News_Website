/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;
import model.News;

/**
 *
 * @author Inspiron
 */
public class userDAO {

    public boolean InsertUser(User user) {
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            if (con != null) {
                String sql = "{call insertUser(?,?,?,?,?,?,?)}";
                CallableStatement call = con.prepareCall(sql);
                call.setString(2, user.getPass());
                call.setNString(3, user.getName());
                call.setString(4, user.getUname());
                call.setInt(5, 0);
                call.setString(6, user.getGender());
                DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
                String strDate = df.format(user.getDob());
                call.setString(7, strDate);
                call.registerOutParameter(1, java.sql.Types.INTEGER);
                call.executeUpdate();
                if(call.getInt(1)==0) throw new Exception();
                call.close();
                con.close();
                return true;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;
    }

    public User Login(String username, String pass) {
        User new_user = new User();
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            if (con != null) {
                String sql = "Select * from UserS where Username = " + "'" + username + "'" + "AND PASSWORD = " + "'" + pass + "'";
                Statement call = con.createStatement();
                ResultSet rs = call.executeQuery(sql);
                while (rs.next()) {             //needed even if just 1 row       
                    boolean isAdmin = false;
                    if (rs.getInt("id_Admin") == 1) {
                        isAdmin = true;
                    }
                    new_user = new User(rs.getInt("User_id"), rs.getString("PASSWORD"), rs.getNString("User_name"), rs.getString("Username"), rs.getNString("Gender"), isAdmin, rs.getDate("dob"));
                }
                call.close();
                con.close();
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return new_user;
    }

    public boolean CheckDuplicate(String username) {
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            if (con != null) {
                String sql = "{call checkDuplicate(?,?)}";
                CallableStatement call = con.prepareCall(sql);
                call.setNString(1, username);
                call.registerOutParameter(2, java.sql.Types.INTEGER);
                call.executeUpdate();
                if (call.getInt(2) > 0) {
                    throw new Exception();
                }
                call.close();
                con.close();
                return false;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return true;
    }

    public User getUser(int id) {
        User new_user = new User();
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            if (con != null) {
                String sql = "Select * from UserS where User_id =" + id;
                Statement call = con.createStatement();
                ResultSet rs = call.executeQuery(sql);
                while (rs.next()) {             //needed even if just 1 row       
                    boolean isAdmin = false;
                    if (rs.getInt("id_Admin") == 1) {
                        isAdmin = true;
                    }
                    new_user = new User(id, rs.getString("PASSWORD"), rs.getNString("User_name"), rs.getString("Username"), rs.getNString("Gender"), isAdmin, rs.getDate("dob"));
                }
                call.close();
                con.close();
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return new_user;
    }

    public HashMap<Integer, User> getAllUser() {
        HashMap<Integer, User> list = new HashMap<>();
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            if (con != null) {
                String sql = "Select * from UserS";
                Statement call = con.createStatement();
                ResultSet rs = call.executeQuery(sql);
                while (rs.next()) {             //needed even if just 1 row       
                    boolean isAdmin = false;
                    if (rs.getInt("id_Admin") == 1) {
                        isAdmin = true;
                    }
                    User new_user = new User(rs.getInt("User_id"), rs.getString("PASSWORD"), rs.getNString("User_name"), rs.getString("Username"), rs.getNString("Gender"), isAdmin, rs.getDate("dob"));
                    list.put(new_user.getId(), new_user);
                }
                call.close();
                con.close();
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public boolean delUser(int id) {
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            if (con != null) {
                String sql = "{call delUser(?)}";
                CallableStatement call = con.prepareCall(sql);
                call.setInt(1, id);
                if (call.executeUpdate() <= 0) {
                    throw new Exception();
                }
                call.close();
                con.close();
                return true;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;
    }

    //trong servlet, thg nao de la null thi set thuoc tinh doi tg gui vao nhu cu
    public boolean updateUser(User user) {//nut bam
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            if (con != null) {
                String sql = "{call updateUser(?,?,?,?,?,?)}";
                CallableStatement call = con.prepareCall(sql);
                call.setInt(1, user.getId());
                call.setString(2, user.getPass());
                call.setNString(3, user.getName());
                call.setString(4, user.getUname());
                call.setNString(5, user.getGender());
                DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
                String strDate = df.format(user.getDob());
                call.setString(6, strDate);
                if (call.executeUpdate() <= 0) {
                    throw new Exception();
                }
                call.close();
                con.close();
                return true;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;
    }

    public ArrayList<News> GetAllAdminNews(User admin) {
        ArrayList<News> list = new ArrayList<>();
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            if (con != null) {
                String sql = "SELECT * FROM News n "
                        + "WHERE User_id =" + admin.getId();
                Statement call = con.createStatement();
                ResultSet rs = call.executeQuery(sql);
                while (rs.next()) {             //needed even if just 1 row       
                    News news = new News(rs.getInt("News_id"), admin.getId(), rs.getInt("Cat_id"), rs.getString("News_title"), rs.getString("News_subtitle"), rs.getString("News_content"), rs.getString("News_image"));
                    list.add(news);
                }
                call.close();
                con.close();
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }
}
//    public static void main(String[] args) {
//        userDAO user = new userDAO();
//        System.out.println("dup:" + user.CheckDuplicate("hung"));
//        // user.InsertUser(new User(1, pass, name, uname, gender, true, dob));
////        User user1 = user.getUser(2);
////        System.out.println(user1.getName());
//        User player = user.Login("hiep", "123");
//        if (player.equals("")) {
//            System.out.println("null 2");
//        }
//        if (player.getUname() == null) {
//            System.out.println("null 3");
//        }
//        System.out.println(player);
//        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
//        java.util.Date dob;
//        try {
//            dob = df.parse("2003-12-10");
//            User user2 = new User(2, "Lam123", "Lam Phung", "Lam", "Male", false, dob);
//            System.out.println(user.updateUser(user2));
//            User add = new User(0, "nghia123", "nghia", "nghia123", "Male", false, dob);
//            System.out.println(user.InsertUser(add));
//        } catch (ParseException ex) {
//            Logger.getLogger(userDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        ArrayList<User> list = user.getAllUser();
//        for (int i = 0; i < list.size(); i++) {
//            System.out.println(list.get(i).getName() + list.get(i).getPass() + list.get(i).getDob());
//        }
////        System.out.println(user.delUser(3));
//    }
//}
//  public static void testCallableStat(int id){
//      try {
//          DBContext db = new DBContext();
//          Connection con  = db.getConnection();
//          String sql = "{call getInfo(?,?,?)}";
//          CallableStatement st = con.prepareCall(sql);
//          st.setInt(1, id);
//          st.registerOutParameter(2, java.sql.Types.NVARCHAR);
//          st.registerOutParameter(3, java.sql.Types.INTEGER);
//          st.executeUpdate();
//          String name = st.getString(2);
//          int nbProd = st.getInt(3);
//          System.out.println("id = "+id+" name = "+name+" nbproduct = "+nbProd);
//      } catch (Exception e) {
//      }
//  }
// public Category getCategory(int id){
//        Category cat =new Category();
//        try {
//            DBContext db = new DBContext();
//            Connection con = db.getConnection();
//            if (con != null) {
//                Statement st = con.createStatement();
//                String sql = "Select * from Categories where ID = "+id;
//                ResultSet rs = st.executeQuery(sql);
//                while (rs.next()) {             //needed even if just 1 row       
//                    cat.setID(rs.getInt("ID"));
//                    cat.setName(rs.getString("Name"));
//                }
//                st.close();
//            }
//            con.close();
//        }catch(Exception e){
//            System.out.println(e.getMessage());
//        }
//        return cat;
//    }

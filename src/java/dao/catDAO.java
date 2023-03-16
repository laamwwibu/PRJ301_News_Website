/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import dao.DBContext;
import java.util.ArrayList;
import model.Category;
import java.sql.*;
import java.util.HashMap;
/**
 *
 * @author Inspiron
 */
public class catDAO {

    public HashMap<Integer, Category> getAllCategorys() {
        HashMap<Integer, Category> categoryList = new HashMap<>();
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            if (con != null) {
                Statement st = con.createStatement();
                String sql = "Select * from Category ";
                ResultSet rs = st.executeQuery(sql);
                while (rs.next()) {
                    Category cat = new Category(rs.getInt("Cat_id"), rs.getNString("Cat_name"), rs.getNString("Cat_description"));
                    categoryList.put(cat.getId(), cat);
                }
                rs.close();
                st.close();
                con.close();
            }
        } catch (Exception e) {
        }
        return categoryList;
    }

    public Category getCategory(int id){
        Category cat =new Category();
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            if (con != null) {
                Statement st = con.createStatement();
                String sql = "Select * from Category where Cat_id = "+id;
                ResultSet rs = st.executeQuery(sql);
                while (rs.next()) {             //needed even if just 1 row       
                    cat.setId(id);
                    cat.setName(rs.getString("Cat_name"));
                    cat.setDes(rs.getNString("Cat_description"));
                }
                st.close();
            }
            con.close();
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return cat;
    }
    public boolean insertCategorys(Category cat) {
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            if (con != null) {
                String sql = "{call insertCate(?,?)}";
                CallableStatement call = con.prepareCall(sql);
                call.setNString(1, cat.getName());
                call.setNString(2, cat.getDes());
                if(call.executeUpdate()<=0) throw new Exception();
                call.close();
                con.close();
                return true;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;
    }
    public boolean delCategory(int id){
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            if(con!=null){
                String sql = "{call delCate(?)}";
                CallableStatement call = con.prepareCall(sql);
                call.setInt(1, id);
                if(call.executeUpdate()<=0) throw new Exception();
                call.close();
                con.close();
                return true;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;
    }
    public static void main(String[] args) {
        catDAO dao = new catDAO();
        dao.insertCategorys(new Category(1, "descrip", "hiep"));
        Category cat = dao.getCategory(0);
        System.out.println(cat.getDes());
        dao.delCategory(1);
    }
}

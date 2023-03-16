/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Comments;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author Asus
 */
public class CommentDAO {

    public ArrayList<Comments> getListComment(int news_id) {
        ArrayList<Comments> listComment = new ArrayList<>();
        Comments comment;
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            Statement st = con.createStatement();
            String sql = " SELECT * "
                    + " FROM Comment "
                    + " WHERE News_id = "+ news_id
                    + " ORDER BY Comment_id desc ";
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                comment = new Comments();
                comment.setComment_id(rs.getInt("Comment_id"));
                comment.setUser_id(rs.getInt("User_id"));
                comment.setCommment_content(rs.getString("Comment_content"));
                listComment.add(comment);
            }
            st.close();
            con.close();
        } catch (Exception e) {
            System.out.println("Error");
        }
        return listComment;
    }

    public boolean insertComments(Comments comments) {
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            String sql = "{call insert_comments(?,?,?)}";
            CallableStatement st = con.prepareCall(sql);
            //truyen tham so
            st.setInt(1, comments.getNews_id());
            st.setInt(2, comments.getUser_id());
            st.setString(3, comments.getCommment_content());
            
            if (st.executeUpdate() != 1){
                System.out.println("ERROR INSERTING COMMENTS");
                throw new Exception();
            }
            st.close();
            con.close();
            return true;
        } catch (Exception e) {
            System.out.println("Error");
        }
        return false;
    }

    public void deleteComments(int comments_id) {
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            String sql = "{call delete_comments(?)}";
            CallableStatement st = con.prepareCall(sql);
            //truyen tham so
            st.setInt(1, comments_id);
            if (st.executeUpdate() != 1){
                System.out.println("ERROR DELETING COMMENTS");
            }
            st.close();
            con.close();
        } catch (Exception e) {
            System.out.println("Error");
        }
    }

    public void updateComments(Comments comments) {
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            String sql = "{call update_comments(?,?)}";
            CallableStatement st = con.prepareCall(sql);
            //truyen tham so
            st.setInt(1, comments.getComment_id());
            st.setString(2, comments.getCommment_content());
            
            if (st.executeUpdate() != 1){
                System.out.println("ERROR UPDATING COMMENTS");
            }
            
            st.close();
            con.close();
        } catch (Exception e) {
            System.out.println("Error");
        }
    }

//    public static void main(String[] args) {
//        Comments comment = new Comments
////        insertComments(comment);
////        deleteComments(1);
//        updateComments(comment);
//        ArrayList <Comments> listComments = getComment();
//        for (Comments i : listComments) {
//            System.out.println(i);
//        }
//
//    }

}

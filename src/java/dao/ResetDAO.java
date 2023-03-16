/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.CallableStatement;
import java.sql.Connection;

/**
 *
 * @author Asus
 */
public class ResetDAO {
    public void resetDatabase() {
        try {
            DBContext db = new DBContext();
            Connection con = db.getConnection();
            String sql = "{call reset_database}";
            CallableStatement st = con.prepareCall(sql);            
            if (st.executeUpdate() != 1){
                System.out.println("ERROR RESETING");
            }
            st.close();
            con.close();
        } catch (Exception e) {
            System.out.println("Error");
        }
    }
}

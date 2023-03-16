/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Asus
 */
public class Comments {
    private int comment_id;
    private int user_id;
    private int news_id;
    private String commment_content;

    public Comments() {
    }
    
    public Comments(int comment_id, String commment_content) {
        this.comment_id = comment_id;
        this.commment_content = commment_content;
    }
    
    public Comments(int user_id, int news_id, String commment_content) {
        this.user_id = user_id;
        this.news_id = news_id;
        this.commment_content = commment_content;
    }


    public int getComment_id() {
        return comment_id;
    }

    public void setComment_id(int comment_id) {
        this.comment_id = comment_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getNews_id() {
        return news_id;
    }

    public void setNews_id(int news_id) {
        this.news_id = news_id;
    }

    public String getCommment_content() {
        return commment_content;
    }

    public void setCommment_content(String commment_content) {
        this.commment_content = commment_content;
    }

    @Override
    public String toString() {
        return "Comments{" + "comment_id=" + comment_id + ", user_id=" + user_id + ", news_id=" + news_id + ", commment_content=" + commment_content + '}';
    }
    
   
    
}

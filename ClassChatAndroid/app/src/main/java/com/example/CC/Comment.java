package com.example.CC;

/**
 * Created by Jack on 4/13/15.
 */
public class Comment {

    String content;
    int id;
    String user_name;
    int created_at;
    int user_id;
    int question_id;
    int likes;

    public Comment(String content, int id, String user_name, int created_at, int user_id, int question_id,int likes){
        this.content = content;
        this.id = id;
        this.user_name = user_name;
        this.created_at = created_at;
        this.user_id = user_id;
        this.question_id = question_id;
        this.likes = likes;

    }
}

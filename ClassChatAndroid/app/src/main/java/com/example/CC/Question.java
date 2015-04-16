package com.example.CC;

/**
 * Created by Jack on 4/12/15.
 */
public class Question {

    String content;
    int id;
    String user_name;
    int created_at;
    int user_id;
    int course_id;
    int likes;

    public Question(String content, int id, String user_name, int created_at, int user_id, int course_id,int likes){
        this.content = content;
        this.id = id;
        this.user_name = user_name;
        this.created_at = created_at;
        this.user_id = user_id;
        this.course_id = course_id;
        this.likes = likes;

    }
}

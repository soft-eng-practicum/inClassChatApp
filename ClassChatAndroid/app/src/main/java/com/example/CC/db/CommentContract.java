package com.example.CC.db;

import android.provider.BaseColumns;

public class CommentContract {
    public static final String DB_NAME = "com.example.TodoList.db.comments";
    public static final int DB_VERSION = 1;
    public static final String TABLE = "tasks";


    public class Columns {
        public static final String TASK = "task";
        public static final String _ID = BaseColumns._ID;
    }
}
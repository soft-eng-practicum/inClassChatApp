package com.cs370.mourya.classchat.db;

/**
 * Created by Mourya on 3/17/2015.
 */
import android.provider.BaseColumns;

public class ClassContract {
    public static final String DB_NAME = "com.cs370.mourya.classchat.db";
    public static final int DB_VERSION = 1;
    public static final String TABLE = "classes";

    public class Columns {
        public static final String CLASS = "class";
        public static final String _ID = BaseColumns._ID;
    }
}


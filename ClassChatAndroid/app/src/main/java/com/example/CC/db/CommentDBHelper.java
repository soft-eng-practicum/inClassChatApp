package com.example.CC.db;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;


public class CommentDBHelper extends SQLiteOpenHelper {

    public CommentDBHelper(Context context) {
        super(context, CommentContract.DB_NAME, null, CommentContract.DB_VERSION);
    }

    @Override
    public void onCreate(SQLiteDatabase sqlDB) {
        String sqlQuery =
                String.format("CREATE TABLE %s (" +
                                "_id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                                "%s TEXT)", CommentContract.TABLE,
                        CommentContract.Columns.TASK);

        Log.d("CommentDBHelper","Query to form table: "+sqlQuery);
        sqlDB.execSQL(sqlQuery);
    }

    @Override
    public void onUpgrade(SQLiteDatabase sqlDB, int i, int i2) {
        sqlDB.execSQL("DROP TABLE IF EXISTS "+CommentContract.TABLE);
        onCreate(sqlDB);
    }
}

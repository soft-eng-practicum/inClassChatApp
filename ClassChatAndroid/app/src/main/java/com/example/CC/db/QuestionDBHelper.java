package com.example.CC.db;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;


public class QuestionDBHelper extends SQLiteOpenHelper {

    public QuestionDBHelper(Context context) {
        super(context, QuestionContract.DB_NAME, null, QuestionContract.DB_VERSION);
    }

    @Override
    public void onCreate(SQLiteDatabase sqlDB) {
        String sqlQuery =
                String.format("CREATE TABLE %s (" +
                                "_id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                                "%s TEXT)", QuestionContract.TABLE,
                        QuestionContract.Columns.TASK);

        Log.d("QuestionDBHelper","Query to form table: "+sqlQuery);
        sqlDB.execSQL(sqlQuery);
    }

    @Override
    public void onUpgrade(SQLiteDatabase sqlDB, int i, int i2) {
        sqlDB.execSQL("DROP TABLE IF EXISTS "+QuestionContract.TABLE);
        onCreate(sqlDB);
    }
}

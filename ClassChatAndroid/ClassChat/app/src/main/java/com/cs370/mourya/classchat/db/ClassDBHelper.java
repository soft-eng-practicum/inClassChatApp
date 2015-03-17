package com.cs370.mourya.classchat.db;

/**
 * Created by Mourya on 3/17/2015.
 */
import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

public class ClassDBHelper extends SQLiteOpenHelper {

    public ClassDBHelper(Context context) {
        super(context, ClassContract.DB_NAME, null, ClassContract.DB_VERSION);
    }

    @Override
    public void onCreate(SQLiteDatabase sqlDB) {
        String sqlQuery =
                String.format("CREATE TABLE %s (" +
                                "_id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                                "%s TEXT)", ClassContract.TABLE,
                        ClassContract.Columns.CLASS);

        Log.d("TaskDBHelper","Query to form table: "+sqlQuery);
        sqlDB.execSQL(sqlQuery);
    }

    @Override
    public void onUpgrade(SQLiteDatabase sqlDB, int i, int i2) {
        sqlDB.execSQL("DROP TABLE IF EXISTS "+ClassContract.TABLE);
        onCreate(sqlDB);
    }
}

package com.cs370.mourya.classchat;

import android.app.AlertDialog;
import android.app.ListActivity;
import android.content.ContentValues;
import android.content.DialogInterface;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.content.Intent;
import android.view.View;
import android.widget.EditText;
import android.widget.ListAdapter;
import android.widget.SimpleCursorAdapter;

import com.cs370.mourya.classchat.db.ClassContract;
import com.cs370.mourya.classchat.db.ClassDBHelper;

public class MyActivity extends ListActivity {
    private ListAdapter listAdapter;
    private ClassDBHelper helper;
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_my);
        updateUI();
    }
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu,menu);
        return true;
    }
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.action_add_task:
                AlertDialog.Builder builder = new AlertDialog.Builder(this);
                builder.setTitle("Add a class");
                builder.setMessage("What do you want to do?");
                final EditText inputField = new EditText(this);
                builder.setView(inputField);
                builder.setPositiveButton("Add", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        String course = inputField.getText().toString();
                        helper = new ClassDBHelper(MyActivity.this);
                        SQLiteDatabase db = helper.getWritableDatabase();
                        ContentValues values = new ContentValues();
                        values.clear();
                        values.put(ClassContract.Columns.CLASS,course);
                        db.insertWithOnConflict(ClassContract.TABLE,null,values,SQLiteDatabase.CONFLICT_IGNORE);
                        updateUI();
                    }
                });
                builder.setNegativeButton("Cancel",null);
                builder.create().show();
                return true;
            default:
                return false;
        }
    }
    private void updateUI() {
        helper = new ClassDBHelper(MyActivity.this);
        SQLiteDatabase sqlDB = helper.getReadableDatabase();
        Cursor cursor = sqlDB.query(ClassContract.TABLE,
                new String[]{ClassContract.Columns._ID, ClassContract.Columns.CLASS},
                null, null, null, null, null);
        listAdapter = new SimpleCursorAdapter(
                this,
                R.layout.class_view,
                cursor,
                new String[]{ClassContract.Columns.CLASS},
                new int[]{R.id.taskTextView},
                0
        );
        this.setListAdapter(listAdapter);
    }


}


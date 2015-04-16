package com.example.CC;

import android.app.AlertDialog;
import android.app.ListActivity;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.ListAdapter;

import com.example.TodoList.R;

import org.apache.commons.io.IOUtils;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;

public class Comments extends ListActivity {
    private ListAdapter listAdapter;
    public int QuestionID;
    public int UserID;
    public ArrayList<Comment> commentList = new ArrayList<Comment>();
    private static final String TAG = Comments.class.getSimpleName();
    public String[] commentNameList;
    public String[] userNameList;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getActionBar().setDisplayHomeAsUpEnabled(false);
        setContentView(R.layout.main);
        Intent intent = getIntent();
        QuestionID = intent.getIntExtra("questionID",0);
        UserID = intent.getIntExtra("id",0);
        updateUI();
    }
    @Override
    public void onBackPressed() {
        super.onBackPressed();
        finish();

    }



    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.action_add_task:
                AlertDialog.Builder builder = new AlertDialog.Builder(this);
                builder.setTitle("Add a Comment");
                builder.setMessage("Enter Comment:");
                final EditText inputField = new EditText(this);
                builder.setView(inputField);
                builder.setPositiveButton("Add", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        final String newComment = inputField.getText().toString();
                        Thread x =new Thread()
                        {
                            public void run()
                            {
                                HttpURLConnection connection = null;
                                try{
                                    URL myUrl = new URL("http://jakemor.com/classchat_backend/postAnswer/user_id="+ UserID + "/question_id=" + QuestionID +"/answer=" + newComment);
                                    connection = (HttpURLConnection)myUrl.openConnection();
                                    InputStream iStream = connection.getInputStream();
                                    final String response = IOUtils.toString(iStream);
                                    Log.i("myTag", response);
                                }
                                catch (MalformedURLException ex){
                                    Log.e(TAG, "Invalid URL Hommie", ex);
                                }
                                catch (IOException ex){
                                    Log.e(TAG, "IO/Connection Hommie", ex);
                                }
                                finally{
                                    connection.disconnect();
                                    if(connection != null){
                                        connection.disconnect();
                                    }
                                }
                            }
                        };//

                        x.start();
                        try{x.join();}
                        catch(InterruptedException e){Log.e(TAG, "Thread interupt Hommie", e);}

                        updateUI();
                    }
                });


                builder.setNegativeButton("Cancel", null);

                builder.create().show();
                return true;

            default:
                return false;
        }
    }

    private void updateUI() {
        Thread x =new Thread()
        {
            public void run()
            {

                HttpURLConnection connection = null;
                try{
                    URL myUrl = new URL("http://jakemor.com/classchat_backend/getQuestionAnswers/question_id=" + QuestionID);
                    connection = (HttpURLConnection)myUrl.openConnection();
                    InputStream iStream = connection.getInputStream();
                    final String response = IOUtils.toString(iStream);

                    try{
                        JSONObject root = new JSONObject(response);
                        JSONArray data = root.getJSONArray("data");
//                        Log.d("Comment DATA:", data.toString());
                        String contentX;
                        String user_nameX;
                        int createdatX;
                        int userIDX;
                        int questionIDX;
                        int likesX;
                        int idX;

                        commentNameList = new String[data.length()];
                        userNameList = new String[data.length()];

                        for(int i = 0; i<data.length(); i++)
                        {

                            JSONObject curQuestion = data.getJSONObject(i);
                            idX = curQuestion.getInt("id");
                            contentX = curQuestion.getString("content");
                            likesX = curQuestion.getInt("likes");
                            createdatX = curQuestion.getInt("created_at");
                            userIDX = curQuestion.getInt("user_id");
                            questionIDX = curQuestion.getInt("question_id");
                            user_nameX = curQuestion.getString("user_name");

                            Comment commentX = new Comment(contentX, idX, user_nameX, createdatX, userIDX, questionIDX, likesX);
                            commentNameList[i]= user_nameX + ": " + contentX;
//                            userNameList[i]= user_nameX;
                            commentList.add(commentX);
                        }
                    }

                    catch(Exception e){e.printStackTrace();}


                }
                catch (MalformedURLException ex){
                    Log.e(TAG, "Invalid URL Hommie", ex);
                }
                catch (IOException ex){
                    Log.e(TAG, "IO/Connection Hommie", ex);
                }
                finally{
                    connection.disconnect();
                    if(connection != null){
                        connection.disconnect();
                    }
                }
            }
        };//


        x.start();
        try{x.join();}
        catch(InterruptedException e){Log.e(TAG, "Thread interupt Hommie", e);}

        setListAdapter(new ArrayAdapter<String>(this, R.layout.activity_comments, R.id.taskTextView, commentNameList));
        getListView().setTextFilterEnabled(true);
    }

}

package com.example.CC;

import android.app.AlertDialog;
import android.app.ListActivity;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.example.TodoList.R;

import org.apache.commons.io.IOUtils;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;


public class Questions extends ListActivity {
    public int ClassID;
    public int UserID;
    public int idX;
    public ArrayList<Question> questionList = new ArrayList<Question>();
    private static final String TAG = Classes.class.getSimpleName();
    public String[] questionNameList;

    @Override
    public void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        getActionBar().setDisplayHomeAsUpEnabled(false);

        setContentView(R.layout.main);
        Intent intent = getIntent();
        ClassID = intent.getIntExtra("id", 0);
        UserID = intent.getIntExtra("user_id", 0);
        Log.i("CREATE ",ClassID + " " + UserID);
        updateUI();
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
                builder.setTitle("Add a Question");
                builder.setMessage("Enter question:");
                final EditText inputField = new EditText(this);
                builder.setView(inputField);
                builder.setPositiveButton("Add", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        String newQuestion = inputField.getText().toString();
                        final String zz =newQuestion.replaceAll("[#]","%23");
                        final String zzz =zz.replaceAll("[&]","%26");
                        final String zzzz =zzz.replaceAll("[+]","%2B");
                        final String z =zzzz.replaceAll("[?]","%3F");

                        Thread x =new Thread()
                        {
                            public void run()
                            {

                                HttpURLConnection connection = null;
                                try{
                                    String urlNewQuestion = URLEncoder.encode(z, "UTF-8");
                                    URL myUrl = new URL("http://jakemor.com/classchat_backend/postQuestion/user_id="+ UserID + "/course_id=" + ClassID+ "/question=" +urlNewQuestion );
                                    connection = (HttpURLConnection)myUrl.openConnection();
                                    InputStream iStream = connection.getInputStream();
                                    final String response = IOUtils.toString(iStream);

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
                        Toast.makeText(getApplicationContext(), newQuestion + " added", Toast.LENGTH_SHORT).show();
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

                //JSONArray JSONid = null;
                HttpURLConnection connection = null;
                try{
                    URL myUrl = new URL("http://jakemor.com/classchat_backend/getCourseQuestions/course_id=" + ClassID);
                    connection = (HttpURLConnection)myUrl.openConnection();
                    InputStream iStream = connection.getInputStream();
                    final String response = IOUtils.toString(iStream);
                    Log.i("QUESTIONS: ", "uid: "+ UserID + "Class: " + ClassID + "response" + response );
                    try{
                        JSONObject root = new JSONObject(response);
                        JSONArray data = root.getJSONArray("data");
                        //Log.d("QUESTION DATA:", data.toString());
                        String contentX;
                        String user_nameX;
                        int createdatX;
                        int userIDX;
                        int courseIDX;
                        int likesX;

                        questionNameList = new String[data.length()];

                        for(int i = 0; i<data.length(); i++)
                        {

                            JSONObject curQuestion = data.getJSONObject(i);
                            contentX = curQuestion.getString("content");
                            idX = curQuestion.getInt("id");
                            user_nameX = curQuestion.getString("user_name");
                            createdatX = curQuestion.getInt("created_at");
                            userIDX = curQuestion.getInt("user_id");
                            courseIDX = curQuestion.getInt("course_id");
                            likesX = curQuestion.getInt("likes");

                            Question questionX = new Question(contentX, idX, user_nameX, createdatX, userIDX, courseIDX, likesX);
                            questionNameList[i]= contentX;
                            questionList.add(questionX);
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

       setListAdapter(new ArrayAdapter<String>(this, R.layout.activity_questions, R.id.taskTextView, questionNameList));
        getListView().setTextFilterEnabled(true);
    }
    @Override
    public void onBackPressed() {
        super.onBackPressed();
        finish();

    }
    public void onChatButton( View view){
        View v = (View) view.getParent();
        TextView taskTextView = (TextView) v.findViewById(R.id.taskTextView);
        final String goClass = taskTextView.getText().toString();
        int var = -1;
        for( int i = 0; i<questionList.size(); i++){

            if (questionList.get(i).content.compareTo(goClass)==0) {
                var = questionList.get(i).id;
            }
            else{
                //Toast.makeText(getApplicationContext(), "You done messed up again", Toast.LENGTH_SHORT).show();
            }
        }

        Intent intent = new Intent(Questions.this, Comments.class);
        intent.putExtra("questionID",var);
        intent.putExtra("id",UserID);

        startActivity(intent);
        //finish();
    }
}
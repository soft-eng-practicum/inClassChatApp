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
import android.widget.ListAdapter;
import android.widget.TextView;

import com.example.CC.db.TaskDBHelper;
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

public class Classes extends ListActivity {
	private ListAdapter listAdapter;
	private TaskDBHelper helper;
    public int ClassID;
    public String[] ClassName;
    public int SchoolID;
//    public Course course;
    public ArrayList<Course> courseList = new ArrayList<Course>();
    private static final String TAG = Classes.class.getSimpleName();
    public String[] nameList;


	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
        getActionBar().setDisplayHomeAsUpEnabled(false);

        setContentView(R.layout.main);
        Intent intent = getIntent();
        ClassID = intent.getIntExtra("id",0);
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
				builder.setTitle("Add a Class");
				builder.setMessage("Enter class name:");
				final EditText inputField = new EditText(this);
				builder.setView(inputField);
				builder.setPositiveButton("Add", new DialogInterface.OnClickListener() {
					@Override
					public void onClick(DialogInterface dialogInterface, int i) {
						final String newClass = inputField.getText().toString();

                        Thread x =new Thread()
                        {
                            public void run()
                            {
                                HttpURLConnection connection = null;
                                try{
                                    URL myUrl = new URL("http://jakemor.com/classchat_backend/enrollUserInCourse/user_id=" + ClassID +"/course_name=" + newClass);
                                    connection = (HttpURLConnection)myUrl.openConnection();
                                    InputStream iStream = connection.getInputStream();
                                    final String response = IOUtils.toString(iStream);
//                                    Log.i("myTag", response);
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

				builder.setNegativeButton("Cancel",null);

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
                    URL myUrl = new URL("http://jakemor.com/classchat_backend/getUserCourses/user_id=" + ClassID);
                    connection = (HttpURLConnection)myUrl.openConnection();
                    InputStream iStream = connection.getInputStream();
                    final String response = IOUtils.toString(iStream);
//                    Log.i("myTag", response);
                    try{
                        JSONObject root = new JSONObject(response);
                        JSONArray data = root.getJSONArray("data");
//                        Log.d("data:", data.toString());
                        int idX;
                        String nameX;
                        int school_idX;
                        nameList = new String[data.length()];

                        for(int i = 0; i<data.length(); i++)
                        {
                            JSONObject curClass = data.getJSONObject(i);
                            idX = curClass.getInt("id");
                            nameX = curClass.getString("name");
                            school_idX = curClass.getInt("school_id");
                            Course courseX = new Course(nameX,idX,school_idX);
                            nameList[i]= nameX;
                            courseList.add(courseX);
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
                    //connection.disconnect();
                    if(connection != null){
                        connection.disconnect();
                    }
                }
            }
        };

        x.start();
        try{x.join();}
        catch(InterruptedException e){Log.e(TAG, "Thread interupt Hommie", e);}

        setListAdapter(new ArrayAdapter<String>(this, R.layout.class_view, R.id.taskTextView, nameList));
        getListView().setTextFilterEnabled(true);
	}

	public void onDoneButtonClick(View view) {
		View v = (View) view.getParent();
		TextView taskTextView = (TextView) v.findViewById(R.id.taskTextView);
		final String deleteClass = taskTextView.getText().toString();
        Thread x =new Thread()
        {
            public void run()
            {
                HttpURLConnection connection = null;
                try{
                    URL myUrl = new URL("http://jakemor.com/classchat_backend/dropUserFromCourse/user_id=" + ClassID +"/course_name=" + deleteClass);
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
        catch(InterruptedException e){Log.e(TAG, "Thread interupt, Hommie", e);}

		updateUI();
	}
    @Override
    public void onBackPressed() {
        super.onBackPressed();

        finish();

    }
    public void addQuestionButton(View view){
        View v = (View) view.getParent();
        TextView taskTextView = (TextView) v.findViewById(R.id.taskTextView);
        final String goClass = taskTextView.getText().toString();
        int var = -1;
        for( int i = 0; i<courseList.size(); i++){

            if (courseList.get(i).name.compareTo(goClass)==0) {
                var = courseList.get(i).id;
            }
            else{
                //Toast.makeText(getApplicationContext(),"You done messed up",Toast.LENGTH_SHORT).show();
            }
        }

        Intent intent = new Intent(Classes.this, Questions.class);/////////////////////////
        intent.putExtra("id",var);
        intent.putExtra("user_id",ClassID);
        startActivity(intent);///////////////////////////////////////////////////////
        //finish();
    }

}

package com.example.CC;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.example.TodoList.R;

import org.apache.commons.io.IOUtils;
import org.json.JSONObject;

import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;


public class Register extends Activity {
    private static final String TAG = Register.class.getSimpleName();
    private Button btnRegister;
    private EditText inputFirstname;
    private EditText inputLastname;

    private EditText inputEmail;
    private EditText inputPassword;
    private ProgressDialog pDialog;
    public boolean isErrorX;
    public String errorX;
    private Error errors;

    @Override
    public void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        getActionBar().setDisplayHomeAsUpEnabled(false);

        setContentView(R.layout.activity_register);


        inputFirstname = (EditText) findViewById(R.id.fname);
        inputLastname = (EditText) findViewById(R.id.lname);
        inputEmail = (EditText) findViewById(R.id.email);
        inputPassword = (EditText) findViewById(R.id.password);
        btnRegister = (Button) findViewById(R.id.btnRegister);
        final String fname = inputFirstname.getText().toString();
        final String lname = inputLastname.getText().toString();
        final String email = inputEmail.getText().toString();
        final String password = inputPassword.getText().toString();

        // Progress dialog
        pDialog = new ProgressDialog(this);
        pDialog.setCancelable(false);

        // Register Button Click event
        btnRegister.setOnClickListener(new View.OnClickListener() {
            public void onClick(View view) {
                String fname = inputFirstname.getText().toString();
                String lname = inputLastname.getText().toString();
                String email = inputEmail.getText().toString();
                String password = inputPassword.getText().toString();

                if (!fname.isEmpty() && !lname.isEmpty() && !email.isEmpty() && !password.isEmpty()) {
                    registerUser(fname, lname, email, password);
                } else {
                    Toast.makeText(getApplicationContext(),
                            "Please enter your details!", Toast.LENGTH_LONG)
                            .show();
                }
            }
        });

    }//onCreate
    public void backToLogin(View view){
        Intent intent = new Intent(Register.this, Chalkboard.class);
        startActivity(intent);

    }

    public void registerUser( String fname,  String lname,  String email, String password) {
        final String fnameZ =fname.replaceAll("[?]","%3F");
        final String lnameZ =lname.replaceAll("[?]","%3F");
        final String emailZ =email.replaceAll("[?]","%3F");
        final String passwordZ =password.replaceAll("[?]","%3F");


        pDialog.setMessage("Registering ...");
        showDialog();
        Thread x =new Thread()
        {
            public void run()
            {
                HttpURLConnection connection = null;
                try{
                    String fnameZZ = URLEncoder.encode(fnameZ, "UTF-8");
                    String lnameZZ = URLEncoder.encode(lnameZ, "UTF-8");
                    String emailZZ = URLEncoder.encode(emailZ, "UTF-8");
                    String passwordZZ = URLEncoder.encode(passwordZ, "UTF-8");
                    URL myUrl = new URL("http://jakemor.com/classchat_backend/createUser/email="+ emailZZ + "/first_name=" + fnameZZ + "/last_name="+ lnameZZ+ "/password=" + passwordZZ);
                    connection = (HttpURLConnection)myUrl.openConnection();
                    InputStream iStream = connection.getInputStream();
                    final String response = IOUtils.toString(iStream);
                    Log.i("Response: ", response);
                    try {
                        JSONObject root = new JSONObject(response);
                        isErrorX = root.getBoolean("error");
                        errorX = root.getString("error_message");
                        errors = new Error(isErrorX, errorX);
                    }
                    catch(Exception e){
                        e.printStackTrace();
                    }
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

        };
        x.start();
        try{x.join();}
        catch(InterruptedException e){Log.e(TAG, "Thread interupt Hommie", e);}
        hideDialog();
        if(isErrorX){
            Toast.makeText(getApplicationContext(),
                    errorX, Toast.LENGTH_LONG)
                    .show();
//            Log.i("error message: ", errorX);
        }
        else {
           // Log.i("error message: ", errorX);
            Intent intent = new Intent(this, Chalkboard.class);
            startActivity(intent);
            //finish();
        }
    }
    private void showDialog() {
        if (!pDialog.isShowing())
            pDialog.show();
    }

    private void hideDialog() {
        if (pDialog.isShowing())
            pDialog.dismiss();
    }
}
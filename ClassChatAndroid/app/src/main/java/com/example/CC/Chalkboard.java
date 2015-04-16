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

public class Chalkboard extends Activity {
    // LogCat tag
    private static final String TAG = Register.class.getSimpleName();
    private Button btnLogin;
    private Button btnLinkToRegister;
    private EditText inputEmail;
    private EditText inputPassword;
    private ProgressDialog pDialog;
    public int id;
    public boolean isErrorX;
    public String errorX;
    private Error errors;
    public int y=0;
    public String test;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        inputEmail = (EditText) findViewById(R.id.email);
        inputPassword = (EditText) findViewById(R.id.password);
        btnLogin = (Button) findViewById(R.id.btnLogin);
        btnLinkToRegister = (Button) findViewById(R.id.btnLinkToRegisterScreen);

        // Progress dialog
        pDialog = new ProgressDialog(this);
        pDialog.setCancelable(false);

        // Login button Click Event
        btnLogin.setOnClickListener(new View.OnClickListener() {

            public void onClick(View view) {
                inputEmail = (EditText) findViewById(R.id.email);
                inputPassword = (EditText) findViewById(R.id.password);
                String email = inputEmail.getText().toString();
                String password = inputPassword.getText().toString();

                // Check for empty data in the form
                if (email.trim().length() > 0 && password.trim().length() > 0) {
                    // login user
                    checkLogin(email, password);
                } else {
                    // Prompt user to enter credentials
                    Toast.makeText(getApplicationContext(),
                            "Please enter the credentials!", Toast.LENGTH_LONG)
                            .show();
                }
            }

        });

    }

    public void onRegisterClick(View view){
        Intent intent = new Intent(this, Register.class);/////////////////////////
        startActivity(intent);
    }

    public void checkLogin(final String email, final String password) {

        pDialog.setMessage("Logging in ...");
        showDialog();
        Thread x =new Thread()
        {
            public void run()
            {
                HttpURLConnection connection = null;
                try{
                    URL myUrl = new URL("http://jakemor.com/classchat_backend/login/email=" + email + "/password=" + password);
                    connection = (HttpURLConnection) myUrl.openConnection();
                    InputStream iStream = connection.getInputStream();
                    final String response = IOUtils.toString(iStream);
                    Log.i("RESPONSE: ", response);

                        try {
                            JSONObject root = new JSONObject(response);

//                            JSONObject errorMessage = root.getJSONObject("error_message");JSONObject errorResponse = root.getJSONObject("error");


                            isErrorX = root.getBoolean("error");
                            errorX = root.getString("error_message");
                            errors = new Error(isErrorX, errorX);
                            if (!isErrorX ) {
                                JSONObject data = root.getJSONObject("data");
                                id = data.getInt("id");
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
            Log.i("error message: ", errorX);
        }
        else {
            Intent intent = new Intent(this, Classes.class);/////////////////////////
            intent.putExtra("id", id);
            startActivity(intent);///////////////////////////////////////////////////////
            //finish();
        }
    }

    @Override
    public void onBackPressed() {
        super.onBackPressed();
        finish();

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

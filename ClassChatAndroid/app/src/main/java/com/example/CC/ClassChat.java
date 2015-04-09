package com.example.CC;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.example.TodoList.R;

import org.apache.commons.io.IOUtils;
import org.json.JSONObject;

import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

//import info.androidhive.loginandregistration.app.AppConfig;
//import info.androidhive.loginandregistration.app.AppController;
//import info.androidhive.loginandregistration.helper.SessionManager;

//import com.android.volley.Request.Method;
//import com.android.volley.Response;
//import com.android.volley.VolleyError;
//import com.android.volley.toolbox.StringRequest;

public class ClassChat extends Activity {
    // LogCat tag
    private static final String TAG = Register.class.getSimpleName();
    private Button btnLogin;
    private Button btnLinkToRegister;
    private EditText inputEmail;
    private EditText inputPassword;
    private ProgressDialog pDialog;
//    private SessionManager session;
    public int id;

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

        // Session manager
//        session = new SessionManager(getApplicationContext());
//
//        // Check if user is already logged in or not
//        if (session.isLoggedIn()) {
//            // User is already logged in. Take him to main activity
//            Intent intent = new Intent(LoginActivity.this, MainActivity.class);
//            startActivity(intent);
//            finish();
//        }

        // Login button Click Event
        btnLogin.setOnClickListener(new View.OnClickListener() {

            public void onClick(View view) {
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

        // Link to Register Screen
//        btnLinkToRegister.setOnClickListener(new View.OnClickListener() {
//
//            public void onClick(View view) {
//                Intent i = new Intent(getApplicationContext(),
//                        Register.class);
//                startActivity(i);
//                finish();
//            }
//       });

    }
    public void onRegisterClick(View view){
        Intent intent = new Intent(this, Register.class);/////////////////////////
        startActivity(intent);
    }
    /**
     * function to verify login details in mysql db
     * */
    public void checkLogin(final String email, final String password) {

//        pDialog.setMessage("Logging in ...");
//        showDialog();

        Thread x =new Thread()
        {
            public void run()
            {

                //JSONArray JSONid = null;
                HttpURLConnection connection = null;
                try{
                    URL myUrl = new URL("http://jakemor.com/classchat_backend/login/email="+ email + "/password=" + password);
                    connection = (HttpURLConnection)myUrl.openConnection();
                    InputStream iStream = connection.getInputStream();
                    final String response = IOUtils.toString(iStream);
                    try{
                        JSONObject root = new JSONObject(response);
                        JSONObject data = root.getJSONObject("data");
                        id = data.getInt("id");


                        final TextView fView = (TextView) findViewById(R.id.email);
                        fView.post( new Runnable() {
                            @Override
                            public void run() {
                                //fView.setText("Response: "+ id);
                            }
                        });
                        //iStream.

                    }

                    catch(Exception e){e.printStackTrace();}


//                    final TextView fView = (TextView) findViewById(R.id.email);
//                    fView.post( new Runnable() {
//                        @Override
//                        public void run() {
//                            fView.setText("Response:" + response );
//                        }
//                    });

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
        Intent intent = new Intent(this, Classes.class);/////////////////////////
        intent.putExtra("id",id);
        startActivity(intent);///////////////////////////////////////////////////////
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

package com.example.CC.db;

import android.app.DownloadManager;
import android.app.ProgressDialog;
import android.util.Log;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.concurrent.Callable;

/**
 * Created by Mourya on 3/31/2015.
 */
public class thebackend {
    public static ProgressDialog pDialog;

    private static void showDialog() {
        if (!pDialog.isShowing())
            pDialog.show();
    }

    public void onSuccess(HashMap response){
//        pDialog.setMessage(response.toString());
//        showDialog();
        System.out.println(response.toString());

    }
    public void onFailure(String errorMessage){
//        pDialog.setMessage(errorMessage);
//        showDialog();
        System.out.println(errorMessage);

    }

    public static String request(String url) {
        //pDialog.setMessage("Test2");
        //showDialog();
        HttpClient httpclient = new DefaultHttpClient();
        HttpGet httpget = new HttpGet(url);

        try {
            HttpResponse response = httpclient.execute(httpget);
            System.out.println(response);
            HttpEntity entity = response.getEntity();

            if (entity != null) {
                InputStream inputstream = entity.getContent();
                BufferedReader bufferedreader =
                        new BufferedReader(new InputStreamReader(inputstream));
                StringBuilder stringbuilder = new StringBuilder();

                String currentline = null;
                while ((currentline = bufferedreader.readLine()) != null) {
                    stringbuilder.append(currentline + "\n");
                }
                String result = stringbuilder.toString();

                System.out.println(result);
//                pDialog.setMessage(result);
//                showDialog();
                inputstream.close();
                return result;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "";

        }
        return "";
    }

}
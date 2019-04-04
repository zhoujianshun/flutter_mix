package com.example.android4flutter;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.Toast;

import io.flutter.app.FlutterActivity;
import io.flutter.facade.Flutter;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.FlutterView;

public class FlutterCustomActivity extends AppCompatActivity {


    private static final String CHANNEL = "com.flutter.sample/home";

    public static final String STREAM = "com.flutter.sample/native_post";

    private EventChannel.EventSink eventSink;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        FlutterView flutterView = Flutter.createView(this,getLifecycle(),"main");
        FrameLayout.LayoutParams params = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,ViewGroup.LayoutParams.MATCH_PARENT);
        addContentView(flutterView,params);


       setupMethodChannel(flutterView);
       setupEventChannel(flutterView);

       new Handler().postDelayed(new Runnable() {
           @Override
           public void run() {
               eventSink.success("啊啊啊啊啊啊啊啊");
           }
       },4000);
    }


    void setupEventChannel(FlutterView flutterView){
        new EventChannel(flutterView, STREAM).setStreamHandler(
                new EventChannel.StreamHandler() {
                    @Override
                    public void onListen(Object args, final EventChannel.EventSink events) {
                       // Log.w("1", "adding listener");
                        eventSink = events;

                        eventSink.success("hello");

                    }

                    @Override
                    public void onCancel(Object args) {
                      //  Log.w(TAG, "cancelling listener");
                    }
                }
        );


    }

    void setupMethodChannel(FlutterView flutterView){
        new MethodChannel(flutterView, CHANNEL).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                        // TODO

                        if (call.method.equals("getBatteryLevel")) {
//                            int batteryLevel = getBatteryLevel();
//
//                            if (batteryLevel != -1) {
//                                result.success(batteryLevel);
//                            } else {
//                                result.error("UNAVAILABLE", "Battery level not available.", null);
//                            }
                        }else if(call.method.equals("flutter_toNativePop")){

                            onBackPressed();

                        } else if(call.method.equals("flutter_toNativeSomething")){

                            Toast.makeText(FlutterCustomActivity.this,"flutter_toNativeSomething",Toast.LENGTH_SHORT).show();

                        }else if(call.method.equals("flutter_toNativePush")){

                            startActivity(new Intent(FlutterCustomActivity.this, OtherActivity.class));

                        } else {
                            result.notImplemented();
                        }
                    }
                });

    }




}

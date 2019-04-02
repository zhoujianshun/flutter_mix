package com.example.android4flutter;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;

import io.flutter.app.FlutterActivity;
import io.flutter.facade.Flutter;
import io.flutter.view.FlutterView;

public class FlutterCustomActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        View flutterView = Flutter.createView(this,getLifecycle(),"main");
        FrameLayout.LayoutParams params = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,ViewGroup.LayoutParams.MATCH_PARENT);
        addContentView(flutterView,params);

//        Flutter.createView()

    }


}

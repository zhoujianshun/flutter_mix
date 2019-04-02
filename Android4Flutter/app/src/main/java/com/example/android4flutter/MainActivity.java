package com.example.android4flutter;

import android.content.Intent;
import android.os.Handler;
import android.support.constraint.ConstraintLayout;
import android.support.v4.app.FragmentTransaction;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.FrameLayout;

import io.flutter.facade.Flutter;

public class MainActivity extends AppCompatActivity implements View.OnClickListener {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Button button = findViewById(R.id.flutter_button);
        button.setOnClickListener(this);


    }

    @Override
    public void onClick(View v) {
       switch (v.getId())  {
           case R.id.flutter_button: {
               startActivity(new Intent(MainActivity.this,FlutterCustomActivity.class));
           }
               break;
       }
                                        
    }


}

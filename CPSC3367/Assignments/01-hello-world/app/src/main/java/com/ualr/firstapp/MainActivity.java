package com.ualr.firstapp;

import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    // TODO 17. Every element included in the layout derives a Java object that we can freely modify
    private TextView userMsgTV;
    private EditText userInputET;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // TODO 13. We do the initial "setup" of the Activity, setting the activity content from
        //  the layout resource previously defined.
        // TODO 14. Note that we reference the layout by the name of the corresponding file
        setContentView(R.layout.activity_main);
        // TODO 18. We get a reference to the several GUI elements by using their id value.
        userMsgTV = findViewById(R.id.userMsgTV);
        userInputET = findViewById(R.id.userInputET);
    }

    // TODO. How do we handle button click events in a easy way?
    // TODO 15. Create a new public method with actions we want to execute when the button is tapped
    public void showTextMessage(View view) {
        userMsgTV.setText(userInputET.getText().toString());
    }
}

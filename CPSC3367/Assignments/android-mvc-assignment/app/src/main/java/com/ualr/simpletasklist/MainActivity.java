package com.ualr.simpletasklist;

import androidx.appcompat.app.AppCompatActivity;

import android.annotation.SuppressLint;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;

import com.ualr.simpletasklist.databinding.ActivityMainBinding;
import com.ualr.simpletasklist.model.TaskList;


public class MainActivity extends AppCompatActivity {

    private ActivityMainBinding binding;

    // TODO 05. Add a TaskList member to the MainActivity. Initialize the new member.
    private TaskList taskList = new TaskList();

    private EditText mTaskET;
    private EditText mIDET;
    private ImageView mAddBtn;
    private Button mDeleteBtn;
    private Button mDoneBtn;
    private TextView mOutputTaskList;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        binding = ActivityMainBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        this.mTaskET = findViewById(R.id.editTextTextPersonName);
        this.mIDET = findViewById(R.id.editTextTaskId);
        this.mOutputTaskList = findViewById(R.id.taskList);

        //TODO 06.02 Bind the onAddBtnClicked method to the add button, so the onAddBtnClicked is
        // triggered whenever the user clicks on that button
        this.mAddBtn = findViewById(R.id.add_btn);
        this.mAddBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                onAddBtnClicked();
            }
        });

        //TODO 07.02 Bind the onDeleteBtnClicked method to the delete button, so that method is
        // triggered whenever the user clicks on that button
        this.mDeleteBtn = findViewById(R.id.deleteBtn);
        this.mDeleteBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                onDeleteBtnClicked();
            }
        });

        //TODO 08.02 Bind the onDoneBtnClicked method to the done button, so the onDoneBtnClicked method is
        // triggered whenever the user clicks on that button
        this.mDoneBtn = findViewById(R.id.clearBtn);
        this.mDoneBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                onDoneBtnClicked();
            }
        });
    }


    // TODO 06. Create a new functionality to add a new task using the description provided
    //  through the text field on the top of the screen by tapping the "+" on the right
    // TODO 06.01. Create a new method called onAddBtnClicked.
    private void onAddBtnClicked() {
        String description = this.mTaskET.getText().toString();
        if(description == "") return;

        // TODO 06.05. Invoke TaskList class' add method to ask the TaskList to
        //  add a new Task with the description provided through the text field.
        this.taskList.add(description);

        // TODO 06.06. Use TaskList class' toString method to get a string with the formatted task list
        //  and display it on screen in the TextView with the id "textView"
        this.mOutputTaskList.setText(this.taskList.toString());

        this.mTaskET.setText("");
    }


    // TODO 07. Create a new functionality to delete a task from the task list
    // TODO 07.01. Create a new method called onDeleteBtnClicked.
    private void onDeleteBtnClicked() {
        String str_id = this.mIDET.getText().toString();
        if(str_id.equals("")) return;
        int id = Integer.parseInt(str_id);

        // TODO 07.04. Invoke TaskList class' delete method to ask the TaskList to
        //  delete a Task given the id provided through the text field on the bottom.
        this.taskList.delete(id);

        // TODO 07.05. Use TaskList class' toString method to get a string with the formatted task list
        //  and display it on screen in the TextView with the id "textView"
        this.mOutputTaskList.setText(this.taskList.toString());
        this.mIDET.setText("");
    }



    // TODO 08. Create a new functionality to mark a task as done.
    // TODO 08.01. Create a new method called onDoneBtnClicked
    private void onDoneBtnClicked() {
        String str_id = this.mIDET.getText().toString();
        if(str_id.equals("")) return;
        int id = Integer.parseInt(str_id);

        this.taskList.markDone(id);
        this.mOutputTaskList.setText(this.taskList.toString());
        this.mIDET.setText("");
    }
    // TODO 08.04. Invoke TaskList class' markDone method to ask the TaskList to
    //  mark a Task given the id provided through the text field on the bottom.

    // TODO 08.05. Use TaskList class' toString method to get a string with the formatted task list
    //  and display it on screen in the TextView with the id "textView"

}
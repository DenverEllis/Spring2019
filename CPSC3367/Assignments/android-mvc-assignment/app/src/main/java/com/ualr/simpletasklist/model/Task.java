package com.ualr.simpletasklist.model;

public class Task {

    // TODO 01. Define two attributes for the Task class: one to store the task description and a second one that
    //  indicates whether the task is done or not
    String description;
    String is_done = "";

    // TODO 02. Define the class constructor and the corresponding getters and setters.
    public Task(String description, String is_done) {
        this.description = description;
        this.is_done = "";
    }

    public Task(String description) {
        this.description = description;
        this.is_done = "";
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getIs_done() {
        return is_done;
    }

    public void setIs_done(String is_done) {
        this.is_done = is_done;
    }

    @Override
    public String toString() {
        return description + " " + is_done;
    }
}

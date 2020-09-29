package com.ualr.simpletasklist.model;


import java.util.HashMap;
import java.util.Objects;

public class TaskList {

    // TODO 03. Define TaskList's attributes. The class will have just one attribute to store all
    //  the tasks created by the user.
    // TIP. We need a data structure able to dynamically grow and shrink. That's why we'll use a HashMap.
    // where keys will be integer values and the mapped values will be a task object
    HashMap<Integer, Task> tasks;
    private int last_id;

    // TODO 04. Define the class constructor and the corresponding getters and setters.
    public TaskList() {
        this.tasks = new HashMap<>();
        this.last_id = 1;
    }

    public TaskList(HashMap<Integer, Task> task_list) {
        this.tasks = task_list;
    }

    public HashMap<Integer, Task> getTasks() {
        return tasks;
    }

    public void setTasks(HashMap<Integer, Task> tasks) {
        this.tasks = tasks;
    }


    // TODO 06.03. Define a new method called "add" that, given a task description, will create a
    //  new task and add it to the task list.
    public void add(String description) {
        this.tasks.put(last_id, new Task(description));
        last_id += 1;
    }

    // TODO 06.04. Define a new "toString" method that provides a formatted string with all the tasks in the task list.
    // Format: 1 line per task. Each line should start with the id number of the task, then a dash, and the task description right after that.
    // If the task is marked as done, "Done" should be included at the end of the line
    @Override
    public String toString() {
        StringBuilder output = new StringBuilder();
        // I could use the keySet() function for this, but since I track the last id, I like this more
        for (int i = 1; i < last_id; i++) {
            if (tasks.get(i) == null) continue;
            output.append(i).append(" - ").append(tasks.get(i)).append("\n");
        }
        return output.toString();
    }

    // TODO 07.03. Define a new method called "delete" that, given a task id, will delete the
    //  corresponding task from the task list.
    public void delete(int id) {
        this.tasks.remove(id);
    }

    // TODO 08.03. Define a new method called "markDone" that, given a task id, will mark the
    //  corresponding task as done.
    public void markDone(int id) {
        this.tasks.get(id).setIs_done("Done");
    }

}

import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_planner/models/task_model.dart';
import 'dart:convert';

class TaskStorage {
  static const _key = 'tasks'; // Key for storing tasks in SharedPreferences

  static Future<List<Task>> loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? taskStrings = prefs.getStringList(_key);
    if (taskStrings == null) {
      return []; // Returns empty list if there are no tasks
    }
    List<Task> tasks = taskStrings.map((taskString) {
      Map<String, dynamic> taskMap = json.decode(taskString); // Parse Json chain to a map
      return Task.fromJson(taskMap); // Creates task object from map
    }).toList();
    return tasks;
  }

  static Future<void> saveTasks(List<Task> tasks) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> taskStrings = tasks.map((task) => json.encode(task.toJson())).toList();
    await prefs.setStringList(_key, taskStrings);
  }

}
import 'package:flutter/foundation.dart';
import 'package:study_planner/models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  // ignore: prefer_final_fields
  List<Task> _tasks = [
    Task(title: 'Task 1'),
    Task(title: 'Task 2'),
    Task(title: 'Task 3'),
    Task(title: 'Task 4'),
  ];

  List<Task> get tasks => _tasks.where((task) => !task.isCompleted).toList();
  List<Task> get completedTasks => _tasks.where((task) => task.isCompleted).toList();

  void toggleTaskCompletion(Task task) {
    task.isCompleted = !task.isCompleted;
    notifyListeners();
  }

  void addTask(String taskName) {
    Task newTask = Task(title: taskName);
    _tasks.add(newTask);
    notifyListeners();
  }
}
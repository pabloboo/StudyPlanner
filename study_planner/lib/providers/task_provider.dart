import 'package:flutter/foundation.dart';
import 'package:study_planner/models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  // ignore: prefer_final_fields
  List<Task> _tasks = [
    Task(title: 'Task 1', date: DateTime.now()),
    Task(title: 'Task 2', date: DateTime.now()),
    Task(title: 'Task 3', date: DateTime.now()),
    Task(title: 'Task 4', date: DateTime.now()),
  ];

  List<Task> get tasks => _tasks.where((task) => !task.isCompleted).toList();
  List<Task> get completedTasks => _tasks.where((task) => task.isCompleted).toList();

  void toggleTaskCompletion(Task task) {
    task.isCompleted = !task.isCompleted;
    notifyListeners();
  }

  void addTask(String taskName, DateTime taskDate ) {
    Task newTask = Task(title: taskName, date: taskDate);
    _tasks.add(newTask);
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
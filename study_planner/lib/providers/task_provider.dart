import 'package:flutter/foundation.dart';
import 'package:study_planner/models/task_model.dart';
import 'package:study_planner/storage/task_storage.dart';

class TaskProvider extends ChangeNotifier {
  // ignore: prefer_final_fields
  List<Task> _tasks = [
    // Task(title: 'Task 1', date: DateTime.now(), isHabit: false),
    // Task(title: 'Task 2', date: DateTime.now(), isHabit: false),
    // Task(title: 'Task 3', date: DateTime.now(), isHabit: false),
    // Task(title: 'Task 4', date: DateTime.now(), isHabit: false),
  ];

  List<Task> get tasks => _tasks.where((task) => !task.isCompleted).toList();
  List<Task> get completedTasks => _tasks.where((task) => task.isCompleted).toList();

  void toggleTaskCompletion(Task task) {
    task.isCompleted = !task.isCompleted;
    TaskStorage.saveTasks(_tasks);
    notifyListeners();
  }

  void addTask(String taskName, DateTime taskDate, bool isHabit, bool isWeekTask) {
    if (!isHabit) {
      Task newTask = Task(title: taskName, date: taskDate, isHabit: isHabit, isWeekTask: isWeekTask);
      _tasks.add(newTask);
    } else {
      DateTime currentDate = taskDate;
      DateTime nextSunday = currentDate.add(Duration(days: DateTime.sunday - currentDate.weekday + 1));

      // Itera sobre los días y crea una tarea para cada uno hasta el próximo domingo
      while (currentDate.isBefore(nextSunday)) {
        Task newTask = Task(title: taskName, date: currentDate, isHabit: isHabit);
        _tasks.add(newTask);
        currentDate = currentDate.add(const Duration(days: 1));
      }
    }
    TaskStorage.saveTasks(_tasks);
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    TaskStorage.saveTasks(_tasks);
    notifyListeners();
  }

  void loadTasksFromStorage(List<Task> loadedTasks) {
    _tasks = loadedTasks;
    TaskStorage.saveTasks(_tasks);
    notifyListeners();
  }
}
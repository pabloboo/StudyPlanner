import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:study_planner/models/task_model.dart';
import 'package:study_planner/storage/task_repository.dart';

class TaskProvider extends ChangeNotifier {

  final taskRepo = Get.put(TaskRepository());

  void toggleTaskCompletion(Task task) {
    task.isCompleted = !task.isCompleted;
    taskRepo.updateTask(task);
    notifyListeners();
  }

  void addTask(String taskName, DateTime taskDate, String email, bool isHabit, bool isWeekTask) {
    if (!isHabit) {
      Task newTask = Task(title: taskName, date: taskDate, email: email, isHabit: isHabit, isWeekTask: isWeekTask);
      taskRepo.createTask(newTask);
    } else {
      DateTime currentDate = taskDate;
      DateTime nextSunday = currentDate.add(Duration(days: DateTime.sunday - currentDate.weekday + 1));

      // Itera sobre los días y crea una tarea para cada uno hasta el próximo domingo
      while (currentDate.isBefore(nextSunday)) {
        Task newTask = Task(title: taskName, date: currentDate, email: email, isHabit: isHabit);
        taskRepo.createTask(newTask);
        currentDate = currentDate.add(const Duration(days: 1));
      }
    }
    notifyListeners();
  }

  void removeTask(Task task) {
    taskRepo.removeTask(task);
    notifyListeners();
  }

  Future<List<Task>> loadTasksFromStorage(User user) async {
    return await taskRepo.getUserTasks(user.email!);
  }

  Future<List<Task>> getUserNotCompletedTasks(User user) async {
    return await taskRepo.getUserNotCompletedTasks(user.email!);
  }

  Future<List<Task>> getUserCompletedTasks(User user) async {
    return await taskRepo.getUserCompletedTasks(user.email!);
  }
}
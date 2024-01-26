import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:study_planner/models/task_model.dart';

class TaskRepository extends GetxController {
  static TaskRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createTask(Task task) async {
    await _db.collection("Tasks").add(task.toJson());
  }

  // Fetch all tasks from an user
  Future<List<Task>> getUserTasks(String email) async {
    final tasks = await _db.collection("Tasks").where("email", isEqualTo: email).get();
    final tasksData = tasks.docs.map((e) => Task.fromJson(e)).toList();
    return tasksData;
  }

  // Fetch all not completed tasks from an user
  Future<List<Task>> getUserNotCompletedTasks(String email) async {
    final tasks = await _db.collection("Tasks").where("email", isEqualTo: email).where("isCompleted", isEqualTo: false).get();
    final tasksData = tasks.docs.map((e) => Task.fromJson(e)).toList();
    return tasksData;
  }

  // Fetch all completed tasks from an user
  Future<List<Task>> getUserCompletedTasks(String email) async {
    final tasks = await _db.collection("Tasks").where("email", isEqualTo: email).where("isCompleted", isEqualTo: true).get();
    final tasksData = tasks.docs.map((e) => Task.fromJson(e)).toList();
    return tasksData;
  }

  // Update task data
  Future<void> updateTask(Task task) async {
    await _db.collection("Tasks").doc(task.id).update(task.toJson());
  }

  // Remove task
  Future<void> removeTask(Task task) async {
    try {
      await _db.collection("Tasks").doc(task.id).delete();
    } catch(e) {
      throw 'Something went wrong';
    }
  }
  
}
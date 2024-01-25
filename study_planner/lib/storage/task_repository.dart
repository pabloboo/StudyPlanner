import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:study_planner/models/task_model.dart';

class TaskRepository extends GetxController {
  static TaskRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createTask(Task task) async {
    await _db.collection("Tasks").add(task.toJson());
  }
  
}
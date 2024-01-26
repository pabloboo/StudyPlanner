import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_planner/models/task_model.dart';
import 'package:study_planner/providers/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:study_planner/screens/task_list.dart';

class TaskListConsumer extends StatelessWidget {
  final DateTime? selectedDate;
  final User? user;

  const TaskListConsumer({super.key, this.selectedDate, this.user,});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, _) {
        List<Task> tasksForSelectedDate = [];

        // wait for asynchronous function
        Future<List<Task>> fetchTasks() async {
          List<Task> tasks = await taskProvider.getUserNotCompletedTasks(user!);
          tasksForSelectedDate = tasks.where((task) {
            return task.date.day == selectedDate!.day &&
                task.date.month == selectedDate!.month &&
                task.date.year == selectedDate!.year &&
                !task.isWeekTask;
          }).toList();
          return tasksForSelectedDate;
        }

        return FutureBuilder<List<Task>>(
          future: fetchTasks(), 
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Muestra un indicador de carga mientras espera
              return const SizedBox.shrink();
            } else if (snapshot.hasError) {
              // Maneja errores, si los hay
              return Text('Error: ${snapshot.error}');
            } else {
              // Construye TaskList con los datos obtenidos
              return TaskList(
                tasks: snapshot.data ?? [],
              );
            }
          },
        );
      },
    );
  }
}

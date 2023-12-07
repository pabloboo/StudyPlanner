import 'package:flutter/material.dart';
import 'package:study_planner/models/task_model.dart';
import 'package:study_planner/providers/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:study_planner/screens/task_list.dart';

class TaskListConsumer extends StatelessWidget {
  final DateTime? selectedDate;

  const TaskListConsumer({Key? key, this.selectedDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, _) {
        List<Task> tasksForSelectedDate = taskProvider.tasks.where((task) {
          return task.date.day == selectedDate!.day &&
            task.date.month == selectedDate!.month &&
            task.date.year == selectedDate!.year &&
            !task.isWeekTask;
        }).toList();

        return TaskList(
          tasks: tasksForSelectedDate,
        );
      },
    );
  }
}

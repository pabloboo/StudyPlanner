import 'package:flutter/material.dart';
import 'package:study_planner/providers/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:study_planner/screens/task_list.dart';

class TaskListConsumer extends StatelessWidget {
  const TaskListConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, _) {
        return TaskList(
          tasks: taskProvider.tasks,
          onTaskToggle: (task) {
            taskProvider.toggleTaskCompletion(task);
          },
        );
      },
    );
  }
}
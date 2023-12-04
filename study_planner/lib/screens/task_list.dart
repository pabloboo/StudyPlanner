import 'package:flutter/material.dart';
import 'package:study_planner/models/task_model.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final Function(Task) onTaskToggle;

  const TaskList({super.key, 
    required this.tasks,
    required this.onTaskToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return ListTile(
          title: Text(task.title),
          leading: Checkbox(
            value: task.isCompleted,
            onChanged: (_) {
              onTaskToggle(task); // Llama a la función proporcionada para cambiar el estado de la tarea
            },
          ),
        );
      },
    );
  }
}


import 'package:flutter/material.dart';
import 'package:study_planner/models/task_model.dart';
import 'package:study_planner/providers/task_provider.dart';
import 'package:provider/provider.dart';

class TaskListConsumer extends StatelessWidget {
  const TaskListConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, _) {
        return ListView.builder(
          itemCount: taskProvider.tasks.length,
          itemBuilder: (context, index) {
            final Task task = taskProvider.tasks[index];
            return ListTile(
              leading: Checkbox(
                value: task.isCompleted,
                onChanged: (value) {
                  taskProvider.toggleTaskCompletion(task);
                },
              ),
              title: Row(
                children: [
                  Expanded(
                    child: Text(task.title),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      taskProvider.removeTask(task);
                    },
                  ),
                ],
              ),
              onTap: () {
                taskProvider.toggleTaskCompletion(task);
              },
            );
          },
        );
      },
    );
  }
}

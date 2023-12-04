import 'package:flutter/material.dart';
import 'package:study_planner/models/task_model.dart';
import 'package:study_planner/providers/task_provider.dart';
import 'package:provider/provider.dart';

class TaskListConsumer extends StatelessWidget {
  final DateTime? selectedDate;

  const TaskListConsumer({Key? key, this.selectedDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, _) {
        List<Task> tasksForSelectedDate = taskProvider.tasks.where((task) {
          return task.date.day == selectedDate!.day;
        }).toList();

        return ListView.builder(
          itemCount: tasksForSelectedDate.length,
          itemBuilder: (context, index) {
            final Task task = tasksForSelectedDate[index];
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

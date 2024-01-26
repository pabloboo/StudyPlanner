import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_planner/models/task_model.dart';
import 'package:study_planner/providers/task_provider.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;

  const TaskList({
    super.key,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider = Provider.of<TaskProvider>(context, listen: false);
    return ListView.separated(
      itemCount: tasks.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(
        color: Colors.grey, // Color de la línea horizontal entre elementos
        height: 1, // Grosor de la línea horizontal
        thickness: 1, // Grosor de la línea horizontal
      ),
      itemBuilder: (context, index) {
        final task = tasks[index];
        return ListTile(
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
          leading: Checkbox(
            value: task.isCompleted,
            onChanged: (_) {
              taskProvider.toggleTaskCompletion(task);
            },
          ),
        );
      },
    );
  }
}
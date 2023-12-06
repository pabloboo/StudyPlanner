import 'package:flutter/material.dart';
import 'package:study_planner/models/task_model.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final Function(Task) onTaskToggle;
  final Function(Task) onTaskDeletion;

  const TaskList({
    Key? key,
    required this.tasks,
    required this.onTaskToggle,
    required this.onTaskDeletion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  onTaskDeletion(task);
                },
              ),
            ],
          ),
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
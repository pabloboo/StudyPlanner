import 'package:flutter/material.dart';
import 'package:study_planner/providers/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:study_planner/screens/task_list.dart';
import 'package:study_planner/models/task_model.dart';

class TaskListCompletedConsumer extends StatefulWidget {
  final Function(bool) updateExpanded;
  final DateTime? selectedDate;

  const TaskListCompletedConsumer({Key? key, required this.updateExpanded, this.selectedDate}) : super(key: key);

  @override
  State<TaskListCompletedConsumer> createState() => _TaskListCompletedConsumerState();
}

class _TaskListCompletedConsumerState extends State<TaskListCompletedConsumer> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, _) {
        List<Task> tasksForSelectedDate = taskProvider.completedTasks.where((task) {
          return task.date.day == widget.selectedDate!.day &&
            task.date.month == widget.selectedDate!.month &&
            task.date.year == widget.selectedDate!.year;
        }).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              title: const Text('Tareas Completadas'),
              trailing: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
              onTap: () {
                setState(() {
                  widget.updateExpanded(!_isExpanded);
                  _isExpanded = !_isExpanded;
                });
              },
            ),
            if (_isExpanded)
              Expanded(
                child: TaskList(
                  tasks: tasksForSelectedDate,
                  onTaskToggle: (task) {
                    taskProvider.toggleTaskCompletion(task);
                  },
                  onTaskDeletion: (task) {
                    taskProvider.removeTask(task);
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
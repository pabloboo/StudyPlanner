import 'package:flutter/material.dart';
import 'package:study_planner/providers/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:study_planner/screens/task_list.dart';

class TaskListCompletedConsumer extends StatefulWidget {

  const TaskListCompletedConsumer({Key? key}) : super(key: key);

  @override
  State<TaskListCompletedConsumer> createState() => _TaskListCompletedConsumerState();
}

class _TaskListCompletedConsumerState extends State<TaskListCompletedConsumer> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              title: const Text('Tareas Completadas'),
              trailing: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
            if (_isExpanded)
              Expanded(
                child: TaskList(
                  tasks: taskProvider.completedTasks,
                  onTaskToggle: (task) {
                    taskProvider.toggleTaskCompletion(task);
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
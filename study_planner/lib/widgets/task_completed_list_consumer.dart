import 'package:flutter/material.dart';
import 'package:study_planner/providers/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:study_planner/screens/task_list.dart';
import 'package:study_planner/models/task_model.dart';

class TaskListCompletedConsumer extends StatefulWidget {
  final DateTime? selectedDate;

  const TaskListCompletedConsumer({
    Key? key,
    this.selectedDate,
  }) : super(key: key);

  @override
  State<TaskListCompletedConsumer> createState() => _TaskListCompletedConsumerState();
}

class _TaskListCompletedConsumerState extends State<TaskListCompletedConsumer> {
  bool _isExpanded = false;

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
                  _isExpanded = !_isExpanded;
                });
              },
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              height: _isExpanded ? MediaQuery.of(context).size.height * 0.25 : 0, // height for expanded/not expanded tasks
              child: TaskList(
                tasks: tasksForSelectedDate,
              ),
            ),
          ],
        );
      },
    );
  }
}
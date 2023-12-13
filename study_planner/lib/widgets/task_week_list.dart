import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:study_planner/models/task_model.dart';
import 'package:study_planner/providers/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:study_planner/screens/task_list.dart';

class TaskWeekList extends StatelessWidget {
  final DateTime? selectedDate;

  const TaskWeekList({Key? key, this.selectedDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, _) {

        // ignore: no_leading_underscores_for_local_identifiers
        int _getWeekNumber(DateTime date) {
          int dayOfYear = int.parse(DateFormat("D").format(date));
          return ((dayOfYear - date.weekday + 10) / 7).floor();
        }

        List<Task> tasksForSelectedDate = taskProvider.tasks.where((task) {
          return _getWeekNumber(task.date) == _getWeekNumber(selectedDate!) &&
            task.isWeekTask;
        }).toList();

        return TaskList(
          tasks: tasksForSelectedDate,
        );
      },
    );
  }
}

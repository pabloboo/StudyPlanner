import 'package:flutter/material.dart';
import 'package:study_planner/models/task_model.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  AddTaskDialogState createState() => AddTaskDialogState();
}

class AddTaskDialogState extends State<AddTaskDialog> {
  TextEditingController taskController = TextEditingController();
  bool _isHabit = false;
  bool _isWeekTask = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar tarea'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: taskController,
            decoration: const InputDecoration(hintText: 'Nombre de la tarea'),
          ),
          Row(
            children: [
              const Text('Hábito'),
              Checkbox(
                value: _isHabit,
                onChanged: (value) {
                  setState(() {
                    _isHabit = value!;
                    if (_isHabit) { //Only one can be checked to true
                      _isWeekTask = false;
                    }
                  });
                },
              ),
            ],
          ),
          Row(
            children: [
              const Text('Tarea para esta semana'),
              Checkbox(
                value: _isWeekTask,
                onChanged: (value) {
                  setState(() {
                    _isWeekTask = value!;
                    if (_isWeekTask) { //Only one can be checked to true
                      _isHabit = false;
                    }
                  });
                },
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Agregar'),
          onPressed: () {
            String? taskName = taskController.text.trim();
            Task task = Task(title: taskName, date: DateTime.now(), email: '', isHabit: _isHabit, isWeekTask: _isWeekTask);
            if (taskName.isNotEmpty) {
              Navigator.of(context).pop(task);
            }
          },
        ),
      ],
    );
  }
}
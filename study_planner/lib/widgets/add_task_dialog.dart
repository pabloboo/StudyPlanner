import 'package:flutter/material.dart';
import 'package:study_planner/models/task_model.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
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
                    if (_isHabit) {
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
                    if (_isWeekTask) {
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
            Task task = Task(title: taskName, date: DateTime.now(), isHabit: _isHabit, isWeekTask: _isWeekTask);
            if (taskName.isNotEmpty) {
              Navigator.of(context).pop(task);
            }
          },
        ),
      ],
    );
  }
}
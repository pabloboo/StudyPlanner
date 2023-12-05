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
            Task task = Task(title: taskName, date: DateTime.now(), isHabit: _isHabit);
            if (taskName.isNotEmpty) {
              Navigator.of(context).pop(task);
            }
          },
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';

class AddTaskDialog {
  static Future<String?> showAddTaskDialog(BuildContext context) async {
    TextEditingController taskController = TextEditingController();
    
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agregar tarea'),
          content: TextField(
            controller: taskController,
            decoration: const InputDecoration(hintText: 'Nombre de la tarea'),
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
                if (taskName.isNotEmpty) {
                  Navigator.of(context).pop(taskName);
                }
              },
            ),
          ],
        );
      },
    );
  }
}

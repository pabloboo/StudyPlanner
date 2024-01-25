import 'package:flutter/material.dart';
import 'package:study_planner/screens/user_page.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:study_planner/widgets/task_list_consumer.dart';
import 'package:provider/provider.dart';
import 'package:study_planner/providers/task_provider.dart';
import 'package:study_planner/widgets/task_completed_list_consumer.dart';
import 'package:study_planner/widgets/add_task_dialog.dart';
import 'package:study_planner/widgets/task_week_list.dart';
import 'package:study_planner/models/task_model.dart';
import 'package:study_planner/storage/task_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainScreen extends StatefulWidget {
  final User? user;

  const MainScreen({super.key, this.user,});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider = Provider.of<TaskProvider>(context, listen: false);
    TaskStorage.loadTasks().then((tasks) { //load tasks
      taskProvider.loadTasksFromStorage(tasks);
    },);

    // This method is rerun every time setState is called
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Center(child: Text('Study Planner')),
        actions: [
          InkWell(
            onTap: () {
              // Navegar a UserPage al hacer clic en la imagen del usuario
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserPage(user: widget.user)),
              );
            },
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget.user!.photoURL!),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            child: TableCalendar(
              locale: 'es_ES',
              firstDay: DateTime.utc(2021, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              availableCalendarFormats: {_calendarFormat: _calendarFormat.name}, // Only show week format
              headerStyle: const HeaderStyle(
                leftChevronVisible: false,
                rightChevronVisible: false,
                headerPadding: EdgeInsets.symmetric(horizontal: 120.0, vertical: 10.0),
                formatButtonVisible: false,
              ),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: const CalendarStyle(
                selectedDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          const Text('Hoy',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            child: Container(
              color: const Color.fromARGB(255, 207, 207, 207),
              child: TaskListCompletedConsumer(
                selectedDate: _selectedDay,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 255, 255, 255),
              child: TaskListConsumer(selectedDate: _selectedDay,),
            ),
          ),
          const Text('Esta semana',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 255, 255, 255),
              child: TaskWeekList(selectedDate: _selectedDay,),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
            Task? task = await showDialog<Task>(
              context: context,
              builder: (BuildContext context) {
                return const AddTaskDialog(); //Form which retrieves a Task
              },
            );
            if (task != null && task.title != '') {
              taskProvider.addTask(task.title, _selectedDay!, widget.user!.email!, task.isHabit, task.isWeekTask);
            }
          },
        tooltip: 'Añadir tarea',
        child: const Icon(Icons.add),
      ),
    );
  }
}
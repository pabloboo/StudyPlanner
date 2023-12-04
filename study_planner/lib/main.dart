// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:study_planner/widgets/task_list_consumer.dart';
import 'package:provider/provider.dart';
import 'package:study_planner/providers/task_provider.dart';
import 'package:study_planner/widgets/task_completed_list_consumer.dart';
import 'package:study_planner/widgets/add_task_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Root widget of the application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(), // Crea una instancia de TaskProvider
      child: MaterialApp(
        title: 'Study Planner',
        theme: ThemeData(
          // Theme of the application.
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 78, 90, 85)),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Study Planner'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();

  bool _isCompletedExpanded = false;

  void updateCompletedExpanded(bool value) {
    setState(() {
      _isCompletedExpanded = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider = Provider.of<TaskProvider>(context, listen: false);

    // This method is rerun every time setState is called
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Center(child: Text(widget.title)),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            child: TableCalendar(
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
          SizedBox(
            height: _isCompletedExpanded ? 200 : 50,
            child: Container(
              color: const Color.fromARGB(255, 207, 207, 207),
              child: TaskListCompletedConsumer(updateExpanded: updateCompletedExpanded,
              selectedDate: _selectedDay,),
            ),
          ),
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 255, 255, 255),
              child: TaskListConsumer(selectedDate: _selectedDay,),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.orange,
              child: const Center(
                child: Text(
                  'Section 3',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
            String? taskName = await AddTaskDialog.showAddTaskDialog(context);
            if (taskName != null) {
              taskProvider.addTask(taskName, _selectedDay!);
            }
          },
        tooltip: 'Añadir tarea',
        child: const Icon(Icons.add),
      ),
    );
  }
}

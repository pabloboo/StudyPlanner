import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_planner/providers/task_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:study_planner/screens/home_page.dart';
import 'firebase_options.dart';

void main() async {
  await initializeDateFormatting('es_ES', null);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MaterialApp(
        title: 'Study Planner',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 78, 90, 85)),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
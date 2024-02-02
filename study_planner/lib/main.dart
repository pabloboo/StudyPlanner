import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_planner/providers/task_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:study_planner/screens/introduction/introduction_screen_page';
import 'package:study_planner/screens/main_screen.dart';
import 'firebase_options.dart';

void main() async {
  await initializeDateFormatting('es_ES', null);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    runApp(MyApp(mainWidget: MainScreen(user: user,)));
  } else {
    runApp(MyApp(mainWidget: IntroductionScreenPage()));
  }
  
}

class MyApp extends StatelessWidget {
  final Widget mainWidget;

  const MyApp({super.key, required this.mainWidget});

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
        home: mainWidget,
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_list/screens/home.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List',
      home: HomeScreen(),
    );
  }
}


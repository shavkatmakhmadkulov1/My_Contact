import 'package:flutter/material.dart';
import 'package:my_contact/demo_contact.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Contact',
      theme: ThemeData(
        primaryColor: Colors.amber,
      ),
      home: const DemoContact(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:restapi/example_five.dart';
import 'package:restapi/example_four.dart';
import 'package:restapi/signup_api.dart';
import 'package:restapi/upload_image_api.dart';
import 'package:restapi/users_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UploadImageAPI(),
    );
  }
}

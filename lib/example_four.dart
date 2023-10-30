import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleFour extends StatefulWidget {
  const ExampleFour({super.key});

  @override
  State<ExampleFour> createState() => _ExampleFourState();
}

var data;
Future<void> getUserApi() async {
  final response = await http.get(
    Uri.parse("https://jsonplaceholder.typicode.com/users"),
  );

  if (response.statusCode == 200) {
    data = jsonDecode(response.body.toString());
  } else {
    return data;
  }
}

class _ExampleFourState extends State<ExampleFour> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Example 4 Rest API"),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: getUserApi(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusuableRow(
                              title: 'Name',
                              value: data[index]['name'].toString()),
                          ReusuableRow(
                              title: 'User Name',
                              value: data[index]['username'].toString()),
                          ReusuableRow(
                              title: 'Address',
                              value:
                                  data[index]['address']['street'].toString()),
                          ReusuableRow(
                              title: 'Lat',
                              value: data[index]['address']['geo']['lat']
                                  .toString()),
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ))
        ],
      ),
    );
  }
}

class ReusuableRow extends StatelessWidget {
  dynamic title, value;
  ReusuableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/user_model.dart';

class ExampleThree extends StatefulWidget {
  const ExampleThree({super.key});

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

List<UserModel> usersList = [];
Future<List<UserModel>> getUsers() async {
  final response = await http.get(
    Uri.parse("https://jsonplaceholder.typicode.com/users"),
  );
  var data = jsonDecode(response.body) as List; // Cast data to List

  if (response.statusCode == 200) {
    for (Map<String, dynamic> i in data) {
      // Specify the type for i
      usersList.add(UserModel.fromJson(i));
    }
    return usersList;
  } else {
    return usersList;
  }
}

class _ExampleThreeState extends State<ExampleThree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users Model"),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: getUsers(),
            builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              } else {
                return ListView.builder(
                  itemCount: usersList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ReusuableRow(
                                title: 'Name',
                                value: snapshot.data![index].name.toString()),
                            ReusuableRow(
                                title: 'Username',
                                value:
                                    snapshot.data![index].username.toString()),
                            ReusuableRow(
                                title: 'Email',
                                value: snapshot.data![index].email.toString()),
                            ReusuableRow(
                              title: 'Address',
                              value:
                                  "${snapshot.data![index].address!.city}   ${snapshot.data![index].address!.geo!.lat}",
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          )),
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

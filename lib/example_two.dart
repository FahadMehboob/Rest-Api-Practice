import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RestApiExamplTwo extends StatefulWidget {
  const RestApiExamplTwo({super.key});

  @override
  State<RestApiExamplTwo> createState() => _RestApiExamplTwoState();
}

List<Comments> commentList = [];
Future<List<Comments>> getComments() async {
  final response =
      await http.get(Uri.parse("https://jsonplaceholder.org/comments"));
  var data = jsonDecode(response.body.toString());
  if (response.statusCode == 200) {
    for (Map i in data) {
      Comments comments = Comments(comment: i["comment"], id: i["id"]);
      commentList.add(comments);
    }
    return commentList;
  } else {
    return commentList;
  }
}

class _RestApiExamplTwoState extends State<RestApiExamplTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Example Two API"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getComments(),
              builder: (context, AsyncSnapshot<List<Comments>> snapshot) {
                return ListView.builder(
                  itemCount: commentList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data![index].comment.toString()),
                      subtitle: Text(snapshot.data![index].id.toString()),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Comments {
  String comment;
  int id;

  Comments({required this.comment, required this.id});
}

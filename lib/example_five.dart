import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/products_model.dart';

class ExampleFive extends StatefulWidget {
  const ExampleFive({super.key});

  @override
  State<ExampleFive> createState() => _ExampleFiveState();
}

Future<ProductList> getProdcuts() async {
  final response = await http.get(
      Uri.parse('https://webhook.site/fb28d272-a670-439c-bf0e-9da60dc72d9a'));
  var data = jsonDecode(response.body.toString());

  if (response.statusCode == 200) {
    return ProductList.fromJson(data);
  } else {
    return ProductList.fromJson(data);
  }
}

class _ExampleFiveState extends State<ExampleFive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Example Five"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<ProductList>(
                future: getProdcuts(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(snapshot.data!.data![index].shop!.name
                                  .toString()),
                              subtitle: Text(snapshot
                                  .data!.data![index].shop!.shopemail
                                  .toString()),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  snapshot.data!.data![index].shop!.image
                                      .toString(),
                                ),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * .3,
                              width: MediaQuery.of(context).size.width * 1,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    snapshot.data!.data![index].images!.length,
                                itemBuilder: (context, position) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .25,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .5,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(snapshot
                                              .data!
                                              .data![index]
                                              .images![position]
                                              .url
                                              .toString()),
                                        ))),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                child: Icon(
                                    snapshot.data!.data![index].inWishlist ==
                                            true
                                        ? Icons.favorite
                                        : Icons.favorite_outline),
                              ),
                            )
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

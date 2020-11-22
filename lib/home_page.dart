import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:chopper/chopper.dart';
import 'package:provider/provider.dart';

import 'post_api_service.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('chopper blog'),
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final response =
              await Provider.of<PostApiService>(context, listen: false)
                  .postPost({'key': 'value'});
          print(response.body);
        },
      ),
    );
  }

  FutureBuilder<Response> _buildBody(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<PostApiService>(context).getTodos(2),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                textAlign: TextAlign.center,
                textScaleFactor: 1.3,
              ),
            );
          }
          final Map<dynamic, dynamic> posts = json.decode(snapshot.data.bodyString);
          print(snapshot.data.bodyString);
          // return ListView.builder(
          //   itemCount: posts.length,
          //   padding: const EdgeInsets.all(8),
          //   itemBuilder: (context, index) {
          //     return Card(
          //       elevation: 4,
          //       child: Text(posts[index]['body']),
          //     );
          //   },
          // );
          return Text(posts['title'].toString());
        } else {
          // Show a loading indicator while waiting for the posts
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

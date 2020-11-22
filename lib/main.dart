import 'package:flutter/material.dart';
import 'package:flutter_api/home_page.dart';
import 'package:flutter_api/post_api_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<PostApiService>(
      create: (BuildContext context) {
        return PostApiService.create();
      },
      dispose: (_, PostApiService service) => service.client.dispose(),
      child: MaterialApp(
        title: 'Material App',
        home: HomePage(),
      ),
    );
  }
}



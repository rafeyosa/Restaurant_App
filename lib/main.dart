import 'package:flutter/material.dart';
import 'package:restaurant_app/presentation/router/app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final AppRouter _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant App',
      theme: ThemeData(
          primarySwatch: Colors.amber,
          primaryColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      onGenerateRoute: _router.generateRoute,
    );
  }
}

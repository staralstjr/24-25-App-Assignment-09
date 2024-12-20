import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'goRouter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router, // GoRouter 설정
    );
  }
}

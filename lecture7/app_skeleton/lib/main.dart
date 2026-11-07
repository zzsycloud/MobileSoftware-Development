import 'package:flutter/material.dart';

import 'pages/book_list_page.dart';

void main() => runApp(const AppSkeletonApp());

class AppSkeletonApp extends StatelessWidget {
  const AppSkeletonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lecture 7 App Skeleton',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const BookListPage(),
    );
  }
}

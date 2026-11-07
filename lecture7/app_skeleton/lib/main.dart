import 'package:flutter/material.dart';

import 'pages/about_page.dart';
import 'pages/book_detail_page.dart';
import 'pages/book_list_page.dart';
import 'pages/home_page.dart';
import 'routes/app_routes.dart';

void main() => runApp(const Lecture7App());

class Lecture7App extends StatelessWidget {
  const Lecture7App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lecture 7',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (_) => const HomePage(),
        AppRoutes.bookList: (_) => const BookListPage(),
        AppRoutes.bookDetail: (_) => const BookDetailPage(),
        AppRoutes.about: (_) => const AboutPage(),
      },
    );
  }
}

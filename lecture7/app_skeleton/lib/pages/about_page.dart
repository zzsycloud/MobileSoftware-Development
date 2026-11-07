import 'package:flutter/material.dart';

import '../routes/app_routes.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('关于本作业')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          Text('Lecture 7 · 可滚动组件与多页面结构'),
          SizedBox(height: 12),
          Text('命名路由表：'),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(AppRoutes.home),
            subtitle: Text('首页网格'),
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text(AppRoutes.bookList),
            subtitle: Text('图书列表'),
          ),
          ListTile(
            leading: Icon(Icons.menu_book),
            title: Text(AppRoutes.bookDetail),
            subtitle: Text('图书详情'),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text(AppRoutes.about),
            subtitle: Text('关于'),
          ),
        ],
      ),
    );
  }
}

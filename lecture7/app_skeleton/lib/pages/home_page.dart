import 'package:flutter/material.dart';

import '../models/route_arguments.dart';
import '../routes/app_routes.dart';
import '../widgets/category_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const List<_CategoryEntry> _entries = [
    _CategoryEntry('全部图书', Icons.apps, null),
    _CategoryEntry('文学', Icons.menu_book, '文学'),
    _CategoryEntry('计算机', Icons.computer, '计算机'),
    _CategoryEntry('历史', Icons.history_edu, '历史'),
    _CategoryEntry('科学', Icons.science, '科学'),
  ];

  String? _filterLabel;

  Future<void> _openList(String? category) async {
    final result = await Navigator.pushNamed(
      context,
      AppRoutes.bookList,
      arguments: BookListArgs(category: category),
    );
    if (!mounted || result is! BookListResult) return;
    setState(() => _filterLabel = result.label);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('图书分类'),
            Text(
              _filterLabel ?? '选择分类查看图书',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: '关于',
            onPressed: () => Navigator.pushNamed(context, AppRoutes.about),
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _entries.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.35,
        ),
        itemBuilder: (context, index) {
          final entry = _entries[index];
          return CategoryCard(
            category: entry.name,
            icon: entry.icon,
            onTap: () => _openList(entry.category),
          );
        },
      ),
    );
  }
}

class _CategoryEntry {
  const _CategoryEntry(this.name, this.icon, this.category);

  final String name;
  final IconData icon;
  final String? category;
}

import 'package:flutter/material.dart';

import '../models/book.dart';

class BookDetailPage extends StatelessWidget {
  const BookDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is! Book) {
      return Scaffold(
        appBar: AppBar(title: const Text('图书详情')),
        body: const Center(child: Text('参数错误：未收到 Book 实例')),
      );
    }

    final book = args;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('图书详情'),
        leading: IconButton(
          tooltip: '返回',
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(book.title, style: theme.textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(
              '${book.author} · ${book.category}',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            _InfoRow(label: '编号', value: book.id),
            _InfoRow(label: '分类', value: book.category),
            _InfoRow(label: '作者', value: book.author),
            _InfoRow(label: '借阅量', value: '${book.borrowCount}'),
            const Divider(height: 32),
            Text('内容简介', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(book.description, style: theme.textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 72, child: Text(label, style: style)),
          Expanded(child: Text(value, style: style)),
        ],
      ),
    );
  }
}

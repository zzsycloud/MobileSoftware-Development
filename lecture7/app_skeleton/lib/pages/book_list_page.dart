import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/book.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  static const int _initialCount = 20;

  late final Future<List<Book>> _booksFuture;

  @override
  void initState() {
    super.initState();
    _booksFuture = _loadBooks();
  }

  Future<List<Book>> _loadBooks() async {
    final raw = await rootBundle.loadString('assets/data/books.json');
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => Book.fromJson(item as Map<String, dynamic>))
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('图书列表'),
      ),
      body: FutureBuilder<List<Book>>(
        future: _booksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text('数据加载失败：${snapshot.error}'),
              ),
            );
          }

          final books = snapshot.data ?? const <Book>[];
          final visibleBooks = books.take(_initialCount).toList(growable: false);

          return ListView.builder(
            key: const Key('book-list'),
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: visibleBooks.length,
            itemBuilder: (context, index) {
              final book = visibleBooks[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(book.category.substring(0, 1)),
                ),
                title: Text(
                  book.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text('${book.author} · ${book.category}'),
                trailing: Text('借阅 ${book.borrowCount}'),
              );
            },
          );
        },
      ),
    );
  }
}

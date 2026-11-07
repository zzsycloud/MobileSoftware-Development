import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/book.dart';
import '../models/route_arguments.dart';
import '../routes/app_routes.dart';
import '../widgets/book_tile.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  static const int _pageSize = 20;

  late final Future<List<Book>> _booksFuture;
  int _visibleCount = _pageSize;

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

  void _loadMore(int total) {
    if (_visibleCount >= total) return;
    setState(() {
      _visibleCount += _pageSize;
      if (_visibleCount > total) _visibleCount = total;
    });
  }

  Future<void> _showFilterSheet(String? category) async {
    final selected = await showModalBottomSheet<bool>(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.filter_alt),
                title: const Text('仅看高借阅量'),
                subtitle: const Text('借阅量 ≥ 80'),
                onTap: () => Navigator.pop(sheetContext, true),
              ),
            ],
          ),
        );
      },
    );

    if (!mounted || selected != true) return;
    Navigator.pop(
      context,
      BookListResult(highBorrowOnly: true, category: category),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final category = args is BookListArgs ? args.category : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(category ?? '全部图书'),
        actions: [
          IconButton(
            tooltip: '筛选说明',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('长按任意书目，可选择“仅看高借阅量”'),
                ),
              );
            },
            icon: const Icon(Icons.filter_alt_outlined),
          ),
        ],
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

          final allBooks = snapshot.data ?? const <Book>[];
          final books = category == null
              ? allBooks
              : allBooks
                  .where((book) => book.category == category)
                  .toList(growable: false);
          final visibleBooks =
              books.take(_visibleCount).toList(growable: false);
          final hasMore = _visibleCount < books.length;

          return ListView.builder(
            key: const Key('book-list'),
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: visibleBooks.length + 1,
            itemBuilder: (context, index) {
              if (index == visibleBooks.length) {
                if (!hasMore) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(child: Text('没有更多了')),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: OutlinedButton.icon(
                    onPressed: () => _loadMore(books.length),
                    icon: const Icon(Icons.expand_more),
                    label: Text(
                      '加载更多（剩余 ${books.length - _visibleCount} 条）',
                    ),
                  ),
                );
              }

              final book = visibleBooks[index];
              return BookTile(
                book: book,
                onTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.bookDetail,
                  arguments: book,
                ),
                onLongPress: () => _showFilterSheet(category),
              );
            },
          );
        },
      ),
    );
  }
}

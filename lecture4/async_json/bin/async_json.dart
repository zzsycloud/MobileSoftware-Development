import 'dart:convert';
import 'dart:io';

import 'package:async_json/book.dart';
import 'package:path/path.dart' as p;

Future<List<Book>> loadBooks(String filePath) async {
  final file = File(filePath);
  final text = await file.readAsString();
  final data = jsonDecode(text) as List<dynamic>;
  return data
      .map((e) => Book.fromJson(e as Map<String, dynamic>))
      .toList();
}

void printStats(List<Book> books) {
  print('总数：${books.length}');

  final categoryCount = <String, int>{};
  for (final b in books) {
    categoryCount[b.category] = (categoryCount[b.category] ?? 0) + 1;
  }
  print('各类目数量：$categoryCount');

  final top3 = [...books]
    ..sort((a, b) => b.borrowCount.compareTo(a.borrowCount));
  print('借阅量Top3：');
  for (final b in top3.take(3)) {
    print('${b.title}（${b.category}）- ${b.borrowCount}');
  }
}

Future<void> main() async {
  final filePath = p.join('data', 'books.json');
  final books = await loadBooks(filePath);
  printStats(books);
}
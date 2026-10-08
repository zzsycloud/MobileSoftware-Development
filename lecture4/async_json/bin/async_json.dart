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

bool roundTripCheck(List<Book> books) {
  for (final b in books) {
    final json = b.toJson();
    final back = Book.fromJson(json);
    if (jsonEncode(json) != jsonEncode(back.toJson())) {
      return false;
    }
  }
  return true;
}

Future<void> main() async {
  final filePath = p.join('data', 'books.json');

  try {
    final books = await loadBooks(filePath);
    printStats(books);
    print('roundtrip 一致：${roundTripCheck(books)}');
  } on FileSystemException catch (e) {
    print('数据文件缺失，请检查data/books.json。路径：${e.path}');
  } on FormatException catch (e) {
    print('JSON格式错误：${e.message}');
  } on TypeError catch (e) {
    print('JSON字段类型错误：$e');
  } catch (e) {
    print('未知错误：$e');
  } finally {
    print('处理结束');
  }
}
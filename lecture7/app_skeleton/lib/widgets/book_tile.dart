import 'package:flutter/material.dart';

import '../models/book.dart';

class BookTile extends StatelessWidget {
  const BookTile({
    super.key,
    required this.book,
    this.onTap,
    this.onLongPress,
  });

  final Book book;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      onLongPress: onLongPress,
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
  }
}

class BookListArgs {
  const BookListArgs({this.category});

  final String? category;
}

class BookListResult {
  const BookListResult({
    required this.highBorrowOnly,
    this.category,
  });

  final bool highBorrowOnly;
  final String? category;

  String get label {
    final scope = category ?? '全部图书';
    return highBorrowOnly ? '仅看高借阅量 · $scope' : scope;
  }
}

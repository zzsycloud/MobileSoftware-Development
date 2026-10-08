class Book {
  final String id;
  final String title;
  final String category;
  final int borrowCount;

  Book({
    required this.id,
    required this.title,
    required this.category,
    required this.borrowCount,
  });

  factory Book.fromJson(Map<String, dynamic> j) {
    return Book(
      id: j['id'] as String? ?? '',
      title: j['title'] as String? ?? '',
      category: j['category'] as String? ?? '未分类',
      borrowCount: (j['borrowCount'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'category': category,
        'borrowCount': borrowCount,
      };
}
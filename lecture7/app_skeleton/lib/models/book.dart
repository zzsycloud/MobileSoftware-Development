class Book {
  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.borrowCount,
    required this.description,
  });

  final String id;
  final String title;
  final String author;
  final String category;
  final int borrowCount;
  final String description;

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      category: json['category'] as String,
      borrowCount: (json['borrowCount'] as num).toInt(),
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'category': category,
      'borrowCount': borrowCount,
      'description': description,
    };
  }
}

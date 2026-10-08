class Student {
  final String id;
  final String name;
  double _score;

  Student(this.id, this.name, [this._score = 0]);

  Student.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['name'] as String,
        _score = 0 {
    score = (json['score'] as num).toDouble();
  }

  double get score => _score;

  set score(double v) {
    if (v < 0 || v > 100) throw ArgumentError('分数越界');
    _score = v;
  }

  bool get passed => _score >= 60;
}
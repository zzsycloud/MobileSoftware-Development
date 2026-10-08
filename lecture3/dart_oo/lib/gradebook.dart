import 'student.dart';
import 'logger.dart';

class GradeBook with Logger {
  final List<Student> students;

  GradeBook(this.students);

  double get average {
    if (students.isEmpty) return 0;
    final value = students.fold<double>(0, (sum, s) => sum + s.score) /
        students.length;
    log('average=$value');
    return value;
  }

  Student? get maxBy {
    if (students.isEmpty) return null;
    return students.reduce((a, b) => a.score >= b.score ? a : b);
  }

  int get countPassed => students.where((s) => s.passed).length;

  Map<String, List<Student>> get groupByGrade {
    final result = students.fold<Map<String, List<Student>>>({}, (map, s) {
      final key = _gradeOf(s.score);
      map.putIfAbsent(key, () => <Student>[]).add(s);
      return map;
    });
    log('groupByGrade keys=${result.keys.toList()}');
    return result;
  }

  String _gradeOf(double score) {
    if (score >= 90) return '优';
    if (score >= 80) return '良';
    if (score >= 70) return '中';
    if (score >= 60) return '及格';
    return '不及格';
  }
}
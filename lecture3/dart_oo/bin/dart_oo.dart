import 'package:dart_oo/student.dart';
import 'package:dart_oo/gradebook.dart';

void main() {
  final gb = GradeBook([
    Student('01', '李华', 92),
    Student('02', '王芳', 55),
    Student('03', '张伟', 78),
    Student('04', '赵敏', 88),
  ]);

  print('平均分: ${gb.average}');
  print('最高分: ${gb.maxBy?.name} - ${gb.maxBy?.score}');
  print('及格人数: ${gb.countPassed}');
  print('分档: ${gb.groupByGrade}');
}
import 'package:test/test.dart';
import 'package:dart_oo/student.dart';
import 'package:dart_oo/gradebook.dart';

void main() {
  group('GradeBook 统计', () {
    test('正常数据统计正确', () {
      final gb = GradeBook([
        Student('01', '李华', 92),
        Student('02', '王芳', 55),
        Student('03', '张伟', 78),
        Student('04', '赵敏', 88),
      ]);

      expect(gb.average, closeTo(78.25, 0.001));
      expect(gb.maxBy?.name, '李华');
      expect(gb.countPassed, 3);
      expect(gb.groupByGrade['优']?.length, 1);
      expect(gb.groupByGrade['不及格']?.length, 1);
    });

    test('越界分数抛弃常', () {
      final s = Student('05', '测试', 60);
      expect(() => s.score = 101, throwsArgumentError);
      expect(() => s.score = -1, throwsArgumentError);
    });
  });
}
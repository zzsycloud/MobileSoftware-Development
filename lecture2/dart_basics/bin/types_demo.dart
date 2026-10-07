void typesDemo() {
  var count = 10;
  int year = 2026;
  double score = 92.5;
  final now = DateTime.now();
  const pi = 3.14159;

  String title = '第一次作业';
  print('你好，$title，成绩${score + 5}');
  print('count=$count, year=$year, now=$now, pi=$pi');

  // 空安全四件套
  String? nickname;
  print(nickname?.length);        // null
  print(nickname ?? '未填写');     // 未填写
  nickname = 'hu';
  print(nickname!.length);        // 2

  late String token;
  token = 'abc123';
  print(token);
}
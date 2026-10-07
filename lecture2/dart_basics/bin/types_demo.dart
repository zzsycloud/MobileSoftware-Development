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

  // 1) ?? 默认值：此时 nickname 就是 null，是合法的兜底演示
  print(nickname ?? '未填写');     // 未填写

  // 2) ?. 安全调用：用一个函数返回值，让编译器无法静态推断
  nickname = pickNickname();
  print(nickname?.length);         // 2 或 null

  // 3) 非空访问：赋值后编译器已知非空，直接 .length 即可，不需要 !
  nickname = 'hu';
  print(nickname.length);          // 2

  // 4) late 延迟初始化
  late String token;
  token = 'abc123';
  print(token);
}

// 让编译器无法在编译期推断返回是否为 null
String? pickNickname() => 'hu';
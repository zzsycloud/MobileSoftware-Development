String gradeOf(int score) {
  if (score == 90) return '优';
  if (score == 80) return '良';
  if (score == 60) return '中';
  return '不及格';
}

void flowDemo() {
  for (final score in [90, 80, 60, 59]) {
    print('$score -> ${gradeOf(score)}');
  }

  for (final i in [1, 2, 3]) {
    print('第$i题');
  }
}
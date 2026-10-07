int add(int a, int b) {
  return a + b;
}

int add2(int a, int b) => a + b;

void enroll({required String name, int age = 18, String? className}) {
  print('enroll: name=$name, age=$age, className=${className ?? "未填写"}');
}

void funcDemo() {
  print('add(2,3)=${add(2, 3)}');
  print('add2(2,3)=${add2(2, 3)}');

  enroll(name: '李华', className: '2班');
  enroll(name: '张三', age: 20);
}
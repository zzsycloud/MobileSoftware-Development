## 一、任务概述

本课进入 Dart 语言基础第一个单元，目标是能读懂、能写出、能解释基础程序。完成内容：

1. 变量、内置类型与空安全；
2. 函数：箭头函数、命名参数、默认值、`required`；
3. 运算符与控制流：`/` 与 `~/`、`if/else`、`for-in`；
4. 复现 `dart_basics` 工程；
5. 完成 TraeCode 对拍练习一组；
6. 通过 `dart run` 与 `dart analyze` 检查。

---

## 二、环境与工具

- 操作系统：[Windows / macOS / Linux]
- Dart SDK 版本：[`dart --version` 输出]
- 编辑器 / IDE：TraeCode / VS Code
- 终端：PowerShell / CMD / zsh
- Git：已初始化仓库并完成 3 次以上提交

---

## 三、实践过程

1. 在 `lecture2` 目录下执行 `dart create dart_basics`；
2. 进入工程：`cd dart_basics`；
3. 查看默认入口 `bin/dart_basics.dart`；
4. 在 `bin/` 下新增：
   - `types_demo.dart`
   - `func_demo.dart`
   - `flow_demo.dart`
5. 将 `bin/dart_basics.dart` 改为统一入口，调用三个 demo；
6. 运行 `dart run`，确认三组输出；
7. 运行 `dart analyze`，修复 `dead_code` 与 `unnecessary_non_null_assertion`；
8. 让 TraeCode 出 5 道预测输出题，先手写作答，再对照参考答案并记录分歧；
9. 按阶段完成 Git 提交。

---

## 四、关键代码

### 4.1 空安全改写前后对照

**改写前：含隐患的可空代码**

```dart
void show(String? nickname) {
  // 隐患1：可空类型不能直接访问 length
  // print(nickname.length);

  // 隐患2：如果 nickname 为 null，! 会运行时抛错
  print(nickname!.length);
}
```

**改写后：安全版本**

```dart
void show(String? nickname) {
  // 1. 安全调用：null 则短路返回 null
  print(nickname?.length);

  // 2. 默认值：null 时使用“未填写”
  print(nickname ?? '未填写');

  // 3. 确实需要非空时，先用 ?? 兜底，再访问
  final safeName = nickname ?? '';
  print(safeName.length);
}
```

**逐处解释**：

| 位置                | 原问题                                                 | 改写方式                 | 原因                             |
| ------------------- | ------------------------------------------------------ | ------------------------ | -------------------------------- |
| `nickname.length` | 可空类型不能直接访问成员                               | `nickname?.length`     | `?.` 在 null 时短路，返回 null |
| `nickname!`       | 为 null 时运行时抛`Null check operator used on null` | `nickname ?? '未填写'` | `??` 提供默认值，避免崩溃      |
| 后续需要非空        | 直接`!` 风险高                                       | 先`?? ''` 得到非空值   | 用兜底值保证安全                 |

### 4.2 `types_demo.dart` 最终版

```dart
void typesDemo() {
  var count = 10;
  int year = 2026;
  double score = 92.5;
  final now = DateTime.now();
  const pi = 3.14159;

  String title = '第一次作业';
  print('你好，$title，成绩${score + 5}');
  print('count=$count, year=$year, now=$now, pi=$pi');

  String? nickname;
  print(nickname ?? '未填写');

  nickname = pickNickname();
  print(nickname?.length);

  nickname = 'hu';
  print(nickname.length);

  late String token;
  token = 'abc123';
  print(token);
}

String? pickNickname() => 'hu';
```

### 4.3 命名参数示例

```dart
void enroll({required String name, int age = 18, String? className}) {
  print('enroll: name=$name, age=$age, className=${className ?? "未填写"}');
}
```

调用：

```dart
enroll(name: '李华', className: '2班');
enroll(name: '张三', age: 20);
```

### 4.4 控制流示例

```dart
String gradeOf(int score) {
  if (score == 90) return '优';
  if (score == 80) return '良';
  if (score == 60) return '中';
  return '不及格';
}
```

---

## 五、检查点结果

### 检查点 1：`dart run` 全部输出正确

执行：

```bash
dart run
```

输出包含：

```text
===== types_demo =====
你好，第一次作业，成绩97.5
count=10, year=2026, ...
未填写
2
2
abc123
===== func_demo =====
add(2,3)=5
add2(2,3)=5
enroll: name=李华, age=18, className=2班
enroll: name=张三, age=20, className=未填写
===== flow_demo =====
90 -> 优
80 -> 良
60 -> 中
59 -> 不及格
第1题
第2题
第3题
```

结果：全部输出正确，无运行报错。
证据：见 `screenshots/03_dart_run.png`。

### 检查点 2：空安全无编译告警

执行：

```bash
dart analyze
```

输出：

```text
Analyzing dart_basics...
No issues found!
```

结果：无 warning、无 error。
证据：见 `screenshots/04_dart_analyze.png`。

### 检查点 3：能口头解释 `??` 与 `!`

- `??`：左侧为 `null` 时返回右侧，否则返回左侧，用于兜底。
- `!`：断言左侧非 `null`，若为 `null` 会运行时抛错，慎用。

证据：见 `screenshots/05_oral_explain.md` 或课堂口头解释记录。

---

## 六、问题与解决

| 问题                                    | 现象                                  | 原因                   | 解决                        |
| --------------------------------------- | ------------------------------------- | ---------------------- | --------------------------- |
| `dart run` 找不到 `pubspec.yaml`    | `Found no pubspec.yaml file in ...` | 终端不在工程根目录     | `cd dart_basics` 后再运行 |
| `dead_code` 告警                      | `types_demo.dart:14`                | 编译器已知变量为 null  | 用函数返回值阻断静态推断    |
| `unnecessary_non_null_assertion` 告警 | `types_demo.dart:17`                | 变量已被类型提升为非空 | 去掉多余的`!`             |
| 命名参数漏`required`                  | 编译错误                              | 必填字段未传           | 调用时补上`name:`         |

---

## 七、AI 使用记录：TraeCode 使用清单

| 序号 | 用途         | 指令摘要                                        | 输出                | 本人验证方式                    |
| ---- | ------------ | ----------------------------------------------- | ------------------- | ------------------------------- |
| 1    | 生成案例骨架 | 按指南第五节给出四文件结构与代码                | 四段 Dart 代码      | 逐行阅读，`dart run` 实跑通过 |
| 2    | 出对拍题     | 出 5 道预测输出题，范围：空安全、命名参数、整除 | 5 道题              | 先手写作答，再对照参考答案      |
| 3    | 批改与讲解   | 提交我的 5 题答案，要求逐题批改并输出分歧清单   | 批改结果 + 分歧清单 | 对分歧题本地`dart run` 验证   |
| 4    | 编译错误解释 | 贴`Found no pubspec.yaml` 报错                | 原因解释 + 解决步骤 | 按建议`cd dart_basics` 后成功 |
| 5    | 报告措辞润色 | 检查第五节、第七节表述                          | 修改建议            | 只采纳与事实相符部分            |

**AI 使用标注**：以上 AI 输出均经本人本地 `dart run` / `dart analyze` 验证，未直接照抄未经验证的代码。

### 对拍分歧清单

| 题号 | 考查点            | 我的答案 | AI 答案 | 是否一致 | 分歧原因 | 复核结论         |
| ---- | ----------------- | -------- | ------- | -------- | -------- | ---------------- |
| 1    | 空安全`?.`      | [填写]   | [填写]  | [是/否]  | [填写]   | [以本地运行为准] |
| 2    | 空安全`!`       | [填写]   | [填写]  | [是/否]  | [填写]   | [填写]           |
| 3    | 命名参数默认值    | [填写]   | [填写]  | [是/否]  | [填写]   | [填写]           |
| 4    | `required` 漏传 | [填写]   | [填写]  | [是/否]  | [填写]   | [填写]           |
| 5    | `~/` 整除       | [填写]   | [填写]  | [是/否]  | [填写]   | [填写]           |

## 八、总结与反思

通过本课，我掌握了 Dart 变量声明、内置类型、空安全四件套、命名参数与默认值、基本控制流。最容易出错的地方是：

1. 把可空类型直接当非空用；
2. 命名参数漏掉 `required`；
3. `!` 滥用导致运行时错误；
4. `dart run` 不在工程根目录执行。

后续会继续用 `dart analyze` 检查代码，并在 AI 辅助时坚持先手写、再对拍、最后本地验证。

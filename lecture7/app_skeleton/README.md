# app_skeleton

Lecture 7 案例复现与自主实践工程：可滚动组件与多页面结构。

## 功能

- 首页 GridView：全部图书 + 文学、计算机、历史、科学 4 个分类。
- 列表页：ListView.builder 数据驱动，按分类过滤，初始 20 条，“加载更多”每次追加 20 条。
- 详情页：接收 Book 强类型参数，完整显示编号、书名、作者、分类、借阅量、简介，返回按钮 pop 无值。
- 回传值：长按列表项弹出“仅看高借阅量”，选择后 pop 回首页，首页更新 AppBar 副标题。
- 4 条命名路由，全部使用 MaterialApp.routes + Navigator.pushNamed。
- 参数化组件：BookTile、CategoryCard，位于 lib/widgets/。

## 运行

```bash
flutter pub get
flutter run -d chrome
```

Windows 桌面：

```bash
flutter run -d windows
```

## 检查

```bash
flutter analyze
flutter test
```

## 目录

```text
lib/
├─ main.dart
├─ models/       Book、BookListArgs、BookListResult
├─ pages/        首页、列表、详情、关于
├─ routes/       AppRoutes
└─ widgets/      BookTile、CategoryCard
assets/data/books.json
test/widget_test.dart
```

路由表、截图与提交记录见上级目录 README。

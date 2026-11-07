# app_skeleton

Lecture 7 案例复现工程：可滚动组件与多页面结构。

## 运行

```bash
flutter pub get
flutter run -d chrome
```

## A1 当前内容

- `lib/models/book.dart`：Book 强类型模型与 JSON 互转。
- `assets/data/books.json`：60 条图书数据，4 个分类各 15 条。
- `lib/pages/book_list_page.dart`：`ListView.builder` 渲染前 20 条。
- `test/widget_test.dart`：验证列表页渲染 20 条数据。

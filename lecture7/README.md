# Lecture 7 - 可滚动组件与多页面结构

本目录包含课堂作业 7 的 Flutter 工程与提交记录。

## 目录结构

```text
lecture7/
├─ app_skeleton/      # 案例复现：首页网格 → 列表 → 详情
├─ app_practice/      # 自主实践：在案例基础上增量完成（B 阶段）
├─ screenshots/       # 运行截图
├─ docs/              # 本地报告，不提交 GitHub
└─ README.md
```

## 环境

- Flutter 3.47.7 stable
- Dart 3.13.5
- 运行目标：Windows desktop / Chrome / Android 模拟器

## 运行方式

```bash
cd lecture7/app_skeleton
flutter pub get
flutter run -d chrome
```

也可以使用 Windows 桌面：

```bash
flutter run -d windows
```

## 案例复现进度

| 提交点 | 内容 | 状态 |
|---|---|---|
| A1 | Book 模型、books.json、ListView.builder 前 20 条 | 已完成 |
| A2 | 三条命名路由、强类型参数、详情页 | 待完成 |
| A3 | GridView 首页、分类过滤、回传值 | 待完成 |

## 路由表

A2 完成后补充。

## 截图

- A1 列表页首屏：[screenshots/a1_list_page.png](screenshots/a1_list_page.png)
- A1 列表页滚动到底部：[screenshots/a1_list_page_scrolled.png](screenshots/a1_list_page_scrolled.png)

## AI 使用说明

本作业使用 AI 辅助完成工程骨架、数据模型和页面初稿；所有代码均经过本地运行、静态分析与测试后提交。详细记录见本地 `docs/` 中的报告，不随仓库上传。

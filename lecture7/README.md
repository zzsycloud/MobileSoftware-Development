# Lecture 7 - 可滚动组件与多页面结构

课堂作业 7 的 Flutter 工程。三页闭环为：首页 GridView 分类入口 → 列表页 → 详情页 → 返回。

## 目录结构

```text
lecture7/
├─ app_skeleton/
│  ├─ lib/
│  │  ├─ main.dart              # MaterialApp + 4 条命名路由
│  │  ├─ models/                # Book、BookListArgs、BookListResult
│  │  ├─ pages/                 # 首页、列表、详情、关于
│  │  ├─ routes/app_routes.dart # 路由常量
│  │  └─ widgets/               # BookTile、CategoryCard
│  ├─ assets/data/books.json    # 60 条图书数据
│  └─ test/widget_test.dart     # 导航、回传值、分页测试
├─ screenshots/                 # 运行截图
├─ docs/                        # 本地报告，不提交 GitHub
└─ README.md
```

## 环境

- Flutter 3.47.7 stable
- Dart 3.13.5
- 运行目标：Chrome（Flutter Web）、Windows 桌面

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

静态检查与测试：

```bash
flutter analyze
flutter test
```

## 命名路由表

| 路由 | 页面 | 去程参数 | 回程值 |
|---|---|---|---|
| `/` | 首页分类网格 | 无 | 无 |
| `/list` | 图书列表 | `BookListArgs(category)` | `BookListResult(highBorrowOnly, category)` |
| `/detail` | 图书详情 | `Book` 实例 | 无（返回按钮 pop 无值） |
| `/about` | 关于与路由表 | 无 | 无 |

所有页面跳转统一使用 `MaterialApp.routes` + `Navigator.pushNamed`，不使用直接 `MaterialPageRoute`。

## 完成情况

| 检查点 | 内容 | 状态 |
|---|---|---|
| A1 | Book 模型、books.json、ListView.builder 前 20 条 | 已完成 |
| A2 | 三条命名路由、Book 强类型参数、详情页、返回无值 | 已完成 |
| A3 | GridView 首页、分类过滤、长按弹层、回传值显示在 AppBar 副标题 | 已完成 |
| B1 | ListView.builder 分页，每次“加载更多”追加 20 条 | 已完成 |
| B2 | 4 条命名路由，全部命名式跳转 | 已完成 |
| B3 | 去程强类型模型，回程 await + setState 生效 | 已完成 |
| B4 | BookTile、CategoryCard 两个参数化组件位于 lib/widgets/ | 已完成 |
| B5 | AI 使用标注与本地进度报告 | 已完成（本地 docs/） |
| C | 独立研究任务（选做） | 未做 |

## 截图

- 首页分类网格：[screenshots/a3_home_grid.png](screenshots/a3_home_grid.png)
- 文学分类列表：[screenshots/a3_list_wenxue.png](screenshots/a3_list_wenxue.png)
- 图书详情：[screenshots/a2_detail.png](screenshots/a2_detail.png)
- 长按筛选弹层：[screenshots/a3_filter_sheet.png](screenshots/a3_filter_sheet.png)
- 回传值生效：[screenshots/a3_home_filtered.png](screenshots/a3_home_filtered.png)
- 加载更多之前：[screenshots/b1_load_more_before.png](screenshots/b1_load_more_before.png)
- 加载更多之后：[screenshots/b1_load_more_after.png](screenshots/b1_load_more_after.png)
- 四条命名路由：[screenshots/b2_about_routes.png](screenshots/b2_about_routes.png)

## 提交记录

```text
1577573 feat: list page with builder
```

后续 A2/A3/B 提交见 `git log --oneline`。

## AI 使用说明

本作业使用 AI 辅助完成工程骨架、数据模型、页面初稿和测试草稿；所有代码均经过本地 `flutter analyze`、`flutter test`、`flutter build web` 与浏览器截图验证后提交。详细记录保存在本地 `docs/`，不随仓库上传。

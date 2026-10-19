import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// 根组件：StatelessWidget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter Deep',
      // 【T2 改造点 1】把主题色从默认色改为 teal 种子色
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Counter Deep - 步长与主题'),
    );
  }
}

/// 首页组件：StatefulWidget
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0; // 计数值状态
  int _step = 1;    // 【T2 改造点 2】步长状态（支持 1 / 2 / 5）

  /// 点击 FAB 按当前步长累加
  void _incrementCounter() {
    setState(() {
      _counter += _step;
    });
  }

  /// 重置计数
  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  /// 【T2 改造点 3】底部弹层选择步长（1 / 2 / 5）
  void _showStepSelector() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  '选择计数步长',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ...[1, 2, 5].map((stepValue) {
                return ListTile(
                  leading: Icon(
                    _step == stepValue
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text('每次点击 +$stepValue'),
                  onTap: () {
                    setState(() {
                      _step = stepValue;
                    });
                    Navigator.pop(ctx);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // 【T2 改造点 4】至少两处调用 Theme.of(context) 获取主题数据
    // 第 1 处：获取主题配色方案 (ColorScheme)
    final colorScheme = Theme.of(context).colorScheme;
    // 第 2 处：获取主题文本样式 (TextTheme)
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            tooltip: '弹层选择步长',
            onPressed: _showStepSelector,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: '重置计数',
            onPressed: _resetCounter,
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '当前累计点击数值（步长：+$_step）：',
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.secondary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$_counter',
                style: textTheme.displayLarge?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              // 页面快捷步长切换按钮组（1 / 2 / 5）
              Wrap(
                spacing: 12,
                children: [1, 2, 5].map((stepValue) {
                  return ChoiceChip(
                    label: Text('步长 +$stepValue'),
                    selected: _step == stepValue,
                    selectedColor: colorScheme.primaryContainer,
                    onSelected: (_) {
                      setState(() {
                        _step = stepValue;
                      });
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _incrementCounter,
        tooltip: '增加 $_step',
        icon: const Icon(Icons.add),
        label: Text('+$_step'),
      ),
    );
  }
}
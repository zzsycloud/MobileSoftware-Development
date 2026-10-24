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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Counter Deep 完整改造版'),
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
  int _counter = 0;
  int _step = 1;

  // ================= 【T3 改造点 2】State 生命周期钩子日志 =================

  @override
  void initState() {
    super.initState();
    print('[Lifecycle] 1. initState: 一次性初始化（当前 _counter = $_counter）');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('[Lifecycle] 2. didChangeDependencies: 依赖变化（如 Theme/Locale）');
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('[Lifecycle] 4. didUpdateWidget: 父组件重建传入新配置（按 r 热重载时触发）');
  }

  @override
  void dispose() {
    print('[Lifecycle] 5. dispose: 组件销毁清理资源');
    super.dispose();
  }

  // ================= 状态更新方法 =================

  void _incrementCounter() {
    setState(() {
      _counter += _step;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

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
    // 【T3 改造点 2】build 阶段日志
    print('[Lifecycle] 3. build: 构建 Widget 树（_counter = $_counter, _step = $_step）');

    final colorScheme = Theme.of(context).colorScheme;
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
              // ================= 【T3 改造点 3】读取并展示自定义图片资源 =================
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Column(
                      children: [
                        Icon(Icons.image_not_supported,
                            size: 64, color: colorScheme.error),
                        const SizedBox(height: 8),
                        const Text('请放入 assets/images/logo.png 并完整重启应用'),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
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
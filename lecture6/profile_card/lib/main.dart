import 'package:flutter/material.dart';

void main() => runApp(const ProfileCardApp());

class ProfileCardApp extends StatelessWidget {
  const ProfileCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Card',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFF2F2F7),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  _AvatarWithBadge(),
                  SizedBox(height: 16),
                  _NameAndBio(),
                  SizedBox(height: 20),
                  _StatsCard(),
                  SizedBox(height: 20),
                  _TagCloud(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------- 头像 + 在线徽标（Stack + Positioned） ----------
class _AvatarWithBadge extends StatelessWidget {
  const _AvatarWithBadge();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const CircleAvatar(
          radius: 48,
          backgroundColor: Color(0xFFE0E0E0),
          child: Icon(Icons.person, size: 48, color: Colors.grey),
        ),
        Positioned(
          right: 2,
          bottom: 2,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2.5),
            ),
          ),
        ),
      ],
    );
  }
}

// ---------- 姓名与签名（同步骤一，略） ----------
class _NameAndBio extends StatelessWidget {
  const _NameAndBio();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          '曾仕宇',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Flutter 学习者 · 记录每一行布局代码',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}

// ---------- 统计条：外面包一层卡片容器 ----------
class _StatsCard extends StatelessWidget {
  const _StatsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7FA),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        //临时内容mainAxisAlignment: MainAxisAlignment.spaceEvenly,故意实验
        children: const [
          Expanded(child: _StatItem(value: '128', label: '动态')),
          Expanded(child: _StatItem(value: '2.4k', label: '粉丝')),
          Expanded(child: _StatItem(value: '86', label: '关注')),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
      ],
    );
  }
}

// ---------- 标签云（同步骤一，略） ----------
class _TagCloud extends StatelessWidget {
  const _TagCloud();

  @override
  Widget build(BuildContext context) {
    const tags = ['Flutter', 'Dart', '布局', 'Widget', '学习打卡'];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: tags
          .map((t) => Chip(
                label: Text(t, style: const TextStyle(fontSize: 12)),
                padding: const EdgeInsets.symmetric(horizontal: 4),
                visualDensity: VisualDensity.compact,
              ))
          .toList(),
    );
  }
}
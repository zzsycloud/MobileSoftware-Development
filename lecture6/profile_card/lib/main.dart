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
          child: SizedBox(
            width: 360,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                _AvatarSection(),
                SizedBox(height: 16),
                _NameAndBio(),
                SizedBox(height: 20),
                _StatsBar(),
                SizedBox(height: 20),
                _TagCloud(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------- 头像区（步骤一只放 CircleAvatar，不加徽标） ----------
class _AvatarSection extends StatelessWidget {
  const _AvatarSection();

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 48,
      backgroundColor: Color(0xFFE0E0E0),
      child: Icon(Icons.person, size: 48, color: Colors.grey),
    );
  }
}

// ---------- 姓名与签名 ----------
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

// ---------- 统计条：三个 Expanded ----------
class _StatsBar extends StatelessWidget {
  const _StatsBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: _StatItem(value: '128', label: '动态')),
        Expanded(child: _StatItem(value: '2.4k', label: '粉丝')),
        Expanded(child: _StatItem(value: '86', label: '关注')),
      ],
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

// ---------- 标签云：Wrap + Chip ----------
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
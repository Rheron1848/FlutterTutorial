import 'package:flutter/material.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

  final List<Map<String, dynamic>> skillCategories = const [
    {
      'title': '移动开发',
      'skills': ['Flutter', 'Dart', 'Android', 'iOS'],
      'icon': Icons.phone_android,
      'color': Colors.blue,
    },
    {
      'title': '前端技术',
      'skills': ['HTML', 'CSS', 'JavaScript'],
      'icon': Icons.web,
      'color': Colors.orange,
    },
    {
      'title': '后端技术',
      'skills': ['Python', 'Node.js', 'MySQL'],
      'icon': Icons.dns,
      'color': Colors.green,
    },
    {
      'title': '工具',
      'skills': ['Git', 'VS Code', 'Figma', 'Docker'],
      'icon': Icons.build,
      'color': Colors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('技能'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: skillCategories.length,
        itemBuilder: (context, index) {
          final category = skillCategories[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        category['icon'] as IconData,
                        color: category['color'] as Color,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        category['title'] as String,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: (category['skills'] as List<String>).map((skill) {
                      return Chip(
                        label: Text(skill),
                        backgroundColor:
                            (category['color'] as Color).withOpacity(0.1),
                        side: BorderSide(
                          color: (category['color'] as Color).withOpacity(0.3),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() => runApp(const ReflectApp());

/// Reflect — офлайн-навигатор по кампусу МАИ без GPS.
/// Сейчас — каркас: экран заглушки до этапа 1 роадмапа (офлайн-карта).
class ReflectApp extends StatelessWidget {
  const ReflectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reflect',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reflect'), centerTitle: true),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.map_outlined, size: 72, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Здесь будет офлайн-карта кампуса МАИ',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Этап 1 роадмапа — см. PRODUCT.md',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        // Кнопка «Снять здание» — засечка по фото (сценарий A из PRODUCT.md)
        onPressed: () {},
        icon: const Icon(Icons.photo_camera_outlined),
        label: const Text('Снять здание'),
      ),
    );
  }
}

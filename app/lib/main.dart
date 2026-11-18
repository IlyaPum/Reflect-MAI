import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

/// Центр кампуса МАИ (Волоколамское шоссе, 64).
const LatLng maiCenter = LatLng(55.9215, 37.5335);

void main() => runApp(const ReflectApp());

/// Reflect — офлайн-навигатор по кампусу МАИ без GPS.
/// Этап 1 роадмапа: офлайн-карта из assets + статичный маркер позиции.
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
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: maiCenter,
          initialZoom: 17,
          minZoom: 16,
          maxZoom: 18,
        ),
        children: [
          // Офлайн-подложка: тайлы OSM из assets (скачаны tools/download_tiles.dart)
          TileLayer(
            urlTemplate: 'assets/map/{z}/{x}/{y}.png',
            tileProvider: AssetTileProvider(),
            userAgentPackageName: 'com.reflect.reflect_app',
          ),
          // Заглушка позиции: на этапе 5 её поставит фильтр частиц
          MarkerLayer(
            markers: [
              Marker(
                point: maiCenter,
                width: 36,
                height: 36,
                child: const Icon(
                  Icons.navigation,
                  color: Color(0xFF3D5AFE),
                  size: 32,
                ),
              ),
            ],
          ),
        ],
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

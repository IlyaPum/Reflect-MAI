/// Модуль 1 PRODUCT.md: офлайн-база ориентиров из assets.
///
/// Хранит векторы-отпечатки (256–512 чисел на точку) + координаты + азимут съёмки.
/// Формат файла — бинарный (float32 + заголовок), определяется на этапе 3.
/// Заглушка (этап 3 роадмапа).
library;

import 'dart:typed_data';

/// Одна запись базы: вектор фасада + где и под каким углом снят.
class LandmarkRecord {
  final Float32List embedding; // 256–512 чисел
  final double latitude;
  final double longitude;
  final double azimuthDeg; // направление съёмки из EXIF

  const LandmarkRecord({
    required this.embedding,
    required this.latitude,
    required this.longitude,
    required this.azimuthDeg,
  });
}

/// Загрузка и поиск по базе (~4 МБ на 2000 точек).
class LandmarkDatabase {
  final List<LandmarkRecord> _records = [];

  int get size => _records.length;

  /// Загрузка из assets/db/landmarks.bin.
  Future<void> load() async {
    // TODO(этап 3): бинарный парсинг + косинусное сходство
  }

  /// Поиск ближайшего вектора (косинусное сходство), < 2 мс на 2000 записей.
  (LandmarkRecord, double similarity)? nearest(Float32List query) {
    // TODO(этап 3)
    return null;
  }
}

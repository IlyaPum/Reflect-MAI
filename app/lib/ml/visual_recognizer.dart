/// Модуль 2 PRODUCT.md: визуальное распознавание места.
///
/// Фото → эмбеддер (tflite_flutter, 30–70 мс) → поиск ближайшего вектора
/// в офлайн-базе (< 2 мс) → координаты здания + уверенность.
/// Заглушка (этап 3 роадмапа).
library;

/// Результат фото-засечки.
class PhotoFix {
  final double latitude;
  final double longitude;
  final double confidence; // 0..1; ниже порога — отказ, а не ложная позиция
  final String landmarkId;

  const PhotoFix({
    required this.latitude,
    required this.longitude,
    required this.confidence,
    required this.landmarkId,
  });
}

/// Распознаватель: принимает кадр камеры, возвращает координаты или отказ.
class VisualPlaceRecognizer {
  /// Порог уверенности: ниже — просим снять другой ракурс.
  static const double confidenceThreshold = 0.6;

  Future<PhotoFix?> recognize(List<int> jpegBytes) async {
    // TODO(этап 3): tflite-инференс эмбеддера → вектор → поиск в LandmarkDatabase
    return null;
  }
}

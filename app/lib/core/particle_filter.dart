/// Модуль 4 PRODUCT.md: фильтр частиц — ядро комплексирования.
///
/// Объединяет редкие точные фото-засечки с непрерывными данными PDR.
/// Заглушка (этап 5 роадмапа).
library;

import 'dart:math' as math;

/// Одно состояние-гипотеза о позиции пользователя.
class Particle {
  double latitude;
  double longitude;
  double weight;

  Particle({required this.latitude, required this.longitude, this.weight = 1.0});
}

/// Результат работы фильтра: центр облака + радиус неопределённости.
class PositionEstimate {
  final double latitude;
  final double longitude;
  final double accuracyMeters; // радиус ореола доверия на карте

  const PositionEstimate({
    required this.latitude,
    required this.longitude,
    required this.accuracyMeters,
  });
}

/// Фильтр частиц (~1000 частиц).
///
/// predict(): сдвиг всех частиц на шаг PDR (дистанция + азимут + шум).
/// resampleByPhoto(): стягивание облака к координатам распознанного здания.
/// estimate(): центр облака + разброс → на карту и в триггер «сфотографируй здание».
class ParticleFilter {
  // Используется на этапе 5 при predict/resample (шум сдвига частиц)
  final math.Random random = math.Random();
  final List<Particle> _particles = [];
  static const int particleCount = 1000;

  PositionEstimate? estimate() {
    if (_particles.isEmpty) return null;
    // TODO(этап 5): взвешенный центр + дисперсия по разбросу частиц
    return null;
  }

  void predict({required double stepMeters, required double azimuthDeg}) {
    // TODO(этап 5): сдвиг частиц + гауссов шум по дистанции и углу
  }

  void resampleByPhoto({
    required double latitude,
    required double longitude,
    required double confidence,
  }) {
    // TODO(этап 5): переразрешение частиц вокруг фото-засечки с учётом уверенности
  }
}

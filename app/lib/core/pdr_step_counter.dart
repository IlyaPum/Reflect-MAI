/// Модуль 3 PRODUCT.md: инерциальное счисление (PDR).
///
/// Детекция шагов по пикам ускорения, оценка дистанции и азимута.
/// Заглушка (этап 4 роадмапа).
library;

/// Событие одного шага от детектора.
class StepEvent {
  final double lengthMeters; // оценка длины шага
  final double azimuthDeg; // азимут движения
  final DateTime timestamp;

  const StepEvent({
    required this.lengthMeters,
    required this.azimuthDeg,
    required this.timestamp,
  });
}

/// Детектор шагов: читает поток акселерометра, ищет пики ускорения.
///
/// Подписка на sensors_plus делается на уровне интеграции (ui/data).
class StepCounter {
  final List<StepEvent> steps = [];

  /// Обработка очередного сэмпла акселерометра (м/с²).
  /// Возвращает StepEvent, если зафиксирован шаг.
  StepEvent? processSample(double x, double y, double z, DateTime t) {
    // TODO(этап 4): фильтр низких частот → поиск пиков → оценка длины шага
    return null;
  }
}

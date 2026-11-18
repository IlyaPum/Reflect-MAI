/// Загрузчик офлайн-тайлов OSM (этап 1 роадмапа PRODUCT.md).
///
/// Скачивает растровые тайлы OpenStreetMap для заданного bbox и зумов
/// в `app/assets/map/{z}/{x}/{y}.png`, из которых собирается офлайн-подложка.
///
/// Запуск из корня репозитория:
///   dart run tools/download_tiles.dart
///
/// Соблюдаем вежливый режим к tile.openstreetmap.org: один запрос за раз,
/// пауза между запросами, честный User-Agent.
/// https://operations.osmfoundation.org/policies/tiles/
library;

import 'dart:io';
import 'dart:math' as math;

const String server = 'https://tile.openstreetmap.org';

// Bbox территории кампуса МАИ (Волоколамское шоссе, 64) с запасом по краям.
const double latMin = 55.915;
const double latMax = 55.930;
const double lonMin = 37.525;
const double lonMax = 37.545;

const List<int> zooms = [16, 17, 18];
const String outputRoot = 'app/assets/map';
const String userAgent =
    'Reflect-MAI-Navigator-dev/0.1 (student project; contact: iburmolichenko@gmail.com)';

/// Перевод координат в индекс тайла (стандартная схема XYZ, Меркатор).
(int, int) lonLatToTile(double lon, double lat, int z) {
  final n = 1 << z;
  final x = ((lon + 180.0) / 360.0 * n).floor();
  final latRad = lat * math.pi / 180.0;
  final y =
      ((1.0 - (math.log(math.tan(latRad) + 1 / math.cos(latRad)) / math.pi)) /
              2.0 *
              n)
          .floor();
  return (x, y.clamp(0, n - 1));
}

Future<void> main() async {
  final client = HttpClient();
  client.userAgent = userAgent;

  var downloaded = 0;
  var skipped = 0;
  var failed = 0;

  for (final z in zooms) {
    final (x0, y0) = lonLatToTile(lonMin, latMax, z); // левый-верхний угол
    final (x1, y1) = lonLatToTile(lonMax, latMin, z); // правый-нижний угол
    stdout.writeln('Zoom $z: x $x0..$x1, y $y0..$y1');

    for (var x = x0; x <= x1; x++) {
      for (var y = y0; y <= y1; y++) {
        final dir = Directory('$outputRoot/$z/$x');
        if (!dir.existsSync()) dir.createSync(recursive: true);
        final file = File('${dir.path}/$y.png');
        if (file.existsSync() && file.lengthSync() > 0) {
          skipped++;
          continue;
        }

        final url = '$server/$z/$x/$y.png';
        try {
          final request = await client.getUrl(Uri.parse(url));
          final response = await request.close();

          if (response.statusCode != 200) {
            stderr.writeln('FAIL $url: HTTP ${response.statusCode}');
            await response.drain();
            failed++;
            continue;
          }

          final bytes = await response.fold<List<int>>(
              <int>[], (acc, chunk) => acc..addAll(chunk));
          file.writeAsBytesSync(bytes);
          downloaded++;
        } on HttpException catch (e) {
          stderr.writeln('FAIL $url: $e');
          failed++;
        }
        // Вежливая пауза: не вламываемся в сервер пачкой запросов
        await Future<void>.delayed(const Duration(milliseconds: 300));
      }
    }
  }

  client.close();
  stdout.writeln(
      'Готово: скачано $downloaded, пропущено (уже были) $skipped, ошибок $failed.');
}

/// Модуль 5 PRODUCT.md: роутер по графу кампуса.
///
/// Кратчайший путь (Дейкстра/A*) по графу дорожек МАИ,
/// маршрут от текущей позиции фильтра частиц до выбранного POI («Корпус 1»).
/// Заглушка (этап 6 роадмапа).
library;

import 'package:latlong2/latlong.dart';

/// Узел графа: перекрёсток дорожек, вход в корпус или точка POI.
class CampusNode {
  final String id;
  final LatLng position;

  const CampusNode(this.id, this.position);
}

/// Ребро: пешеходный проход между узлами.
class CampusEdge {
  final String fromId;
  final String toId;
  final double lengthMeters;

  const CampusEdge(this.fromId, this.toId, this.lengthMeters);
}

/// Точка интереса кампуса: корпус, столовая, вход.
class CampusPoi {
  final String name; // «Корпус 1»
  final String nodeId; // узел графа, у которого стоит цель

  const CampusPoi(this.name, this.nodeId);
}

/// Построение маршрута по кампусу.
class CampusRouter {
  CampusRouter({required List<CampusNode> nodes, required List<CampusEdge> edges})
      : _nodes = nodes,
        _edges = edges;

  final List<CampusNode> _nodes;
  final List<CampusEdge> _edges;

  /// Возвращает полилинию маршрута (узлы от старта к цели) + остаток дистанции.
  /// Пересчитывается при отклонении пользователя от маршрута.
  List<CampusNode> route({required CampusNode from, required CampusPoi to}) {
    // TODO(этап 6): Дейкстра/A* по _edges
    return const [];
  }
}

class PointEntity<T> {
  final T x;
  final T y;

  const PointEntity({required this.x, required this.y});
}

class SizeEntity {
  final int width;
  final int height;

  const SizeEntity({required this.width, required this.height});
}

class ViewAreaEntity {
  final PointEntity xy;
  final SizeEntity size;

  PointEntity get center => PointEntity(x: xy.x + size.width ~/ 2, y: xy.y + size.height ~/ 2);

  bool contains(PointEntity point) =>
      point.x >= xy.x && point.x <= xy.x + size.width && point.y >= xy.y && point.y <= xy.y + size.height;

  const ViewAreaEntity({required this.xy, required this.size});
}

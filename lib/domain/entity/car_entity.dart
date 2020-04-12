import 'package:meta/meta.dart';

@immutable
class CarEntity {
  final int id;
  final String photo;
  final String name;

  const CarEntity({
    @required this.id,
    @required this.photo,
    @required this.name,
  });
}
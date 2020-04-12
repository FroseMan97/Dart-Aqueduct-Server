import 'package:meta/meta.dart';

@immutable
class DriverEntity {
  final int id;
  final String name;
  final String avatar;

  const DriverEntity({
    @required this.id,
    @required this.name,
    @required this.avatar,
  }) : assert(id != null, 'driver id cant be null'),
       assert(name != null, 'driver name cant be null'),
       assert(avatar != null, 'driver avatar cant be null');
}
import 'package:car_drivers/domain/entity/car_entity.dart';
import 'package:car_drivers/domain/entity/driver_entity.dart';
import 'package:meta/meta.dart';

@immutable
class PairEntity {
  final CarEntity car;
  final DriverEntity driver;

  const PairEntity({
    this.car,
    this.driver,
  });
}
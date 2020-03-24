import 'dart:math';

import 'package:car_drivers/models/car_driver_model.dart';
import 'package:car_drivers/models/car_model.dart';

import '../car_drivers.dart';

class RandomController extends ResourceController {
  RandomController(this.context);

  final ManagedContext context;

  /// Получить всех водителей
  @Operation.get()
  Future<Response> getRandomMatch() async {
    final carQuery = Query<Car>(context);
    final carList = await carQuery.fetch();
    final randomCar = carList == null || carList.isEmpty
      ? null
      : carList[Random().nextInt(carList.length)];

    final driverQuery = Query<CarDriver>(context);
    final driverList = await driverQuery.fetch();
    final randomDriver = driverList == null || driverList.isEmpty
      ? null
      : driverList[Random().nextInt(driverList.length)];
    return Response.ok(
      {
        "driver": randomDriver?.asMap(),
        "car": randomCar?.asMap(),
      },
      headers: {'Content-type': 'application/json'},
    );
  }
}

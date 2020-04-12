import 'dart:math';

import 'package:car_drivers/models/car_db_model.dart';
import 'package:car_drivers/models/driver_db_model.dart';

import '../car_drivers.dart';

class RandomController extends ResourceController {
  RandomController(this.context);

  final ManagedContext context;

  /// Получить всех водителей
  @Operation.get()
  Future<Response> getRandomMatch() async {
    final carQuery = Query<CarDBModel>(context);
    final carList = await carQuery.fetch();
    final randomCar = carList == null || carList.isEmpty
      ? null
      : carList[Random().nextInt(carList.length)];

    final driverQuery = Query<DriverDBModel>(context);
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

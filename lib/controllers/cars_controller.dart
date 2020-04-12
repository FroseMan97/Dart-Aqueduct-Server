import 'package:car_drivers/models/car_db_model.dart';

import '../car_drivers.dart';

class CarsController extends ResourceController {
  CarsController(this.context);

  final ManagedContext context;

  /// Получить все авто
  @Operation.get()
  Future<Response> getAllCars({@Bind.query('name') String name}) async {
    final carQuery = Query<CarDBModel>(context);
    if (name != null) {
      carQuery.where((h) => h.name).contains(name, caseSensitive: false);
    }
    final drivers = await carQuery.fetch();

    return Response.ok(drivers, headers: {
      'Content-type': 'application/json'
    });
  }

  /// Получить авто по его id
  @Operation.get('id')
  Future<Response> getCarByID(@Bind.path('id') int id) async {
    final carQuery = Query<CarDBModel>(context)
      ..where((h) => h.id).equalTo(id);

    final car = await carQuery.fetchOne();

    if (car == null) {
      return Response.notFound();
    }
    return Response.ok(car, headers: {
      'Content-type': 'application/json'
    });
  }

  @Operation.post()
  Future<Response> addCar(
    @Bind.body(ignore: ["id"]) CarDBModel inputDriver,
  ) async {
    final query = Query<CarDBModel>(context)..values = inputDriver;

    final insertedDriver = await query.insert();
    final result = Response.ok(insertedDriver);
    print(result.body);
    return result;
  }

  @Operation.delete('id')
  Future<Response> deleteCar(
    @Bind.path('id') int driverID,
  ) async {
    final query = Query<CarDBModel>(context)
    ..where((item) => item.id).equalTo(driverID);

    final deletedID = await query.delete();

    return Response.ok(deletedID);
  }
}

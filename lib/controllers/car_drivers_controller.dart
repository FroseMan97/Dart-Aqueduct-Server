import 'package:car_drivers/models/car_driver_model.dart';

import '../car_drivers.dart';

class CarDriversController extends ResourceController {
  CarDriversController(this.context);

  final ManagedContext context;

  /// Получить всех водителей
  @Operation.get()
  Future<Response> getAllDrivers({@Bind.query('name') String name}) async {
    final driverQuery = Query<CarDriver>(context);
    if (name != null) {
      driverQuery.where((h) => h.name).contains(name, caseSensitive: false);
    }
    final drivers = await driverQuery.fetch();

    return Response.ok(drivers, headers: {
      'Content-type': 'application/json'
    });
  }

  /// Получить водителя по его id
  @Operation.get('id')
  Future<Response> getDriverByID(@Bind.path('id') int id) async {
    final driverQuery = Query<CarDriver>(context)
      ..where((h) => h.id).equalTo(id);

    final driver = await driverQuery.fetchOne();

    if (driver == null) {
      return Response.notFound();
    }
    return Response.ok(driver, headers: {
      'Content-type': 'application/json'
    });
  }

  @Operation.post()
  Future<Response> addDriver(
    @Bind.body(ignore: ["id"]) CarDriver inputDriver,
  ) async {
    final query = Query<CarDriver>(context)..values = inputDriver;

    final insertedDriver = await query.insert();
    final result = Response.ok(insertedDriver);
    print(result.body);
    return result;
  }

  // локаль, SSL, cookie

  @Operation.delete('id')
  Future<Response> deleteDriver(
    @Bind.path('id') int driverID,
  ) async {
    final query = Query<CarDriver>(context)
    ..where((item) => item.id).equalTo(driverID);

    final deletedID = await query.delete();

    return Response.ok(deletedID);
  }
}

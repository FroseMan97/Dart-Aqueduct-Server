import 'package:car_drivers/data/mappers/driver_mapper.dart';
import 'package:car_drivers/domain/models/add_driver_model.dart';
import 'package:car_drivers/domain/usecase/create_driver_usecase.dart';
import 'package:car_drivers/domain/usecase/delete_driver_usecase.dart';
import 'package:car_drivers/domain/usecase/get_driver_usecase.dart';
import 'package:car_drivers/domain/usecase/get_drivers_usecase.dart';

import '../../car_drivers.dart';

class DriversController extends ResourceController {

  DriversController(
    this.getDriverUsecase,
    this.getDriversUsecase,
    this.deleteDriverUsecase,
    this.createDriverUsecase,
  );

  final GetDriverUsecase getDriverUsecase;
  final GetDriversUsecase getDriversUsecase;
  final DeleteDriverUsecase deleteDriverUsecase;
  final CreateDriverUsecase createDriverUsecase;

  /// Получить всех водителей
  @Operation.get()
  Future<Response> getAllDrivers() async {
    final result = await getDriversUsecase();
    return Response.ok(DriverMapper.mapEntitiesToModels(result), headers: {'Content-type': 'application/json'});
  }

  /// Получить водителя по его id
  @Operation.get('id')
  Future<Response> getDriverByID(@Bind.path('id') int id) async {
    final result = await getDriverUsecase(id);
    return Response.ok(DriverMapper.mapEntityToModel(result), headers: {'Content-type': 'application/json'});
  }

  @Operation.post()
  Future<Response> addDriver(
    @Bind.body() AddDriverModel input,
  )  async {

    final result = await createDriverUsecase(input);
    
    return Response.ok(DriverMapper.mapEntityToModel(result), headers: {'Content-type': 'application/json'});
  }

  @Operation.delete('id')
  Future<Response> deleteDriver(
    @Bind.path('id') int driverID,
  ) async {
    
    final result = await deleteDriverUsecase(driverID);

    return Response.ok(result);
  }
}

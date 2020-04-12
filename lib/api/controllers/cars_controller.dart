import 'package:car_drivers/data/mappers/car_mapper.dart';
import 'package:car_drivers/domain/models/add_car_model.dart';
import 'package:car_drivers/domain/usecase/create_car_usecase.dart';
import 'package:car_drivers/domain/usecase/delete_car_usecase.dart';
import 'package:car_drivers/domain/usecase/get_car_usecase.dart';
import 'package:car_drivers/domain/usecase/get_cars_usecase.dart';

import '../../car_drivers.dart';

class CarsController extends ResourceController {
  CarsController(
    this.createCarUsecase,
    this.deleteCarUsecase,
    this.getCarUsecase,
    this.getCarsUsecase,
  );

  final GetCarUsecase getCarUsecase;
  final GetCarsUsecase getCarsUsecase;
  final CreateCarUsecase createCarUsecase;
  final DeleteCarUsecase deleteCarUsecase;

  /// Получить все авто
  @Operation.get()
  Future<Response> getAllCars() async {

    final result = await getCarsUsecase();

    return Response.ok(CarMapper.mapEntitiesToModels(result), headers: {'Content-type': 'application/json'});
  }

  /// Получить авто по его id
  @Operation.get('id')
  Future<Response> getCarByID(@Bind.path('id') int id) async {
    
    final result = await getCarUsecase(id);
    return Response.ok(CarMapper.mapEntityToModel(result), headers: {'Content-type': 'application/json'});
  }

   @Operation.post()
  Future<Response> addCar(
    @Bind.body() AddCarModel input
  ) async {

    final result = await createCarUsecase(input);
    
    return Response.ok(CarMapper.mapEntityToModel(result), headers: {'Content-type': 'application/json'});
  }

  @Operation.delete('id')
  Future<Response> deleteCar(
    @Bind.path('id') int carID,
  ) async {
    
    final result = await deleteCarUsecase(carID);

    return Response.ok(result);
  }
}

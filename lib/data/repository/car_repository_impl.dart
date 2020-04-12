import 'package:car_drivers/data/datasource/car_datasource.dart';
import 'package:car_drivers/data/mappers/car_mapper.dart';
import 'package:car_drivers/domain/entity/car_entity.dart';
import 'package:car_drivers/domain/models/add_car_model.dart';
import 'package:car_drivers/domain/repository/car_repository.dart';
import 'package:meta/meta.dart';

class CarRepository implements ICarRepository {

  final CarDatasource carDatasource;

  const CarRepository({
    @required this.carDatasource,
  }) : assert(carDatasource != null, 'carDatasource cant be null');

  @override
  Future<CarEntity> createCar(AddCarModel request) async {
    final result = await carDatasource.addCar(request);
    return CarMapper.mapModelToEntity(result);
  }

  @override
  Future<int> deleteCar(int id) async {
    return await carDatasource.deleteCar(id);
  }

  @override
  Future<CarEntity> getCar(int id) async {
    final result = await carDatasource.getCar(id: id);
    return CarMapper.mapModelToEntity(result);
  }

  @override
  Future<List<CarEntity>> getAllCars() async {
    final result = await carDatasource.getAllCars();
    return CarMapper.mapModelsToEntities(result);
  }

  @override
  Future<CarEntity> getRandomCar() async {
    final result = await carDatasource.getRandomCar();
    return CarMapper.mapModelToEntity(result);
  }
  
}
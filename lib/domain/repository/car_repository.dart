import 'package:car_drivers/domain/entity/car_entity.dart';
import 'package:car_drivers/domain/models/add_car_model.dart';

abstract class ICarRepository {
  Future<CarEntity> getCar(int id);
  Future<List<CarEntity>> getAllCars();
  Future<int> deleteCar(int id);
  Future<CarEntity> createCar(AddCarModel request);
  Future<CarEntity> getRandomCar();
}
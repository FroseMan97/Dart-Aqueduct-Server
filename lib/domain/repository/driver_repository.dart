import 'package:car_drivers/domain/entity/driver_entity.dart';
import 'package:car_drivers/domain/models/add_driver_model.dart';

abstract class IDriverRepository {

  Future<DriverEntity> getDriver(int id);
  Future<List<DriverEntity>> getAllDrivers();
  Future<int> deleteDriver(int id);
  Future<DriverEntity> createDriver(AddDriverModel request);
  Future<DriverEntity> getRandomDriver();

}
import 'package:car_drivers/data/datasource/driver_datasource.dart';
import 'package:car_drivers/data/mappers/driver_mapper.dart';
import 'package:car_drivers/domain/entity/driver_entity.dart';
import 'package:car_drivers/domain/models/add_driver_model.dart';
import 'package:car_drivers/domain/repository/driver_repository.dart';
import 'package:meta/meta.dart';

class DriverRepository implements IDriverRepository {
  final DriverDatasource driverDatasource;

  const DriverRepository({
    @required this.driverDatasource,
  }) : assert(driverDatasource != null, 'driver datasource cant be null');

  @override
  Future<DriverEntity> createDriver(AddDriverModel request) async {
    final result = await driverDatasource.addDriver(request);
    return DriverMapper.mapModelToEntity(result);
  }

  @override
  Future<int> deleteDriver(int id) async {
    return await driverDatasource.deleteDriver(id);
  }

  @override
  Future<DriverEntity> getDriver(int id) async {
    final result = await driverDatasource.getDriver(id: id);
    return DriverMapper.mapModelToEntity(result);
  }

  @override
  Future<List<DriverEntity>> getAllDrivers() async {
    final results = await driverDatasource.getAllDrivers();
    return DriverMapper.mapModelsToEntities(results);
  }

  @override
  Future<DriverEntity> getRandomDriver() async{
    final result = await driverDatasource.getRandomDriver();
    return DriverMapper.mapModelToEntity(result);
  }

}

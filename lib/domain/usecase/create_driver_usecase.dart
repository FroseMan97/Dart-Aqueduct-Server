import 'package:car_drivers/domain/entity/driver_entity.dart';
import 'package:car_drivers/domain/models/add_driver_model.dart';
import 'package:car_drivers/domain/repository/driver_repository.dart';

class CreateDriverUsecase {
  final IDriverRepository driverRepository;

  CreateDriverUsecase(this.driverRepository) : assert(driverRepository != null, 'driver repository cant be null');

  Future<DriverEntity> call(AddDriverModel request) async {
    return await driverRepository.createDriver(request);
  }
}
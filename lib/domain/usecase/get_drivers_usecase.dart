import 'package:car_drivers/domain/entity/driver_entity.dart';
import 'package:car_drivers/domain/repository/driver_repository.dart';

class GetDriversUsecase {
  final IDriverRepository driverRepository;

  GetDriversUsecase(this.driverRepository): assert(driverRepository != null, 'driverRepository cant be null');

  Future<List<DriverEntity>> call() async {
    return await driverRepository.getAllDrivers();
  }
}
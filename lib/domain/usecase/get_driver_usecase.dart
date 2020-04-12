import 'package:car_drivers/domain/entity/driver_entity.dart';
import 'package:car_drivers/domain/repository/driver_repository.dart';

class GetDriverUsecase {
  final IDriverRepository driverRepository;

  GetDriverUsecase(this.driverRepository): assert(driverRepository != null, 'driverRepository cant be null');

  Future<DriverEntity> call(int id) async {
    return await driverRepository.getDriver(id);
  }
}
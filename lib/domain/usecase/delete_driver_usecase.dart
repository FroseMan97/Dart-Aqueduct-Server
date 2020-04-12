import 'package:car_drivers/domain/repository/driver_repository.dart';

class DeleteDriverUsecase {
  final IDriverRepository driverRepository;

  DeleteDriverUsecase(this.driverRepository): assert(driverRepository != null, 'driverRepository cant be null');

  Future<int> call(int id) async {
    return await driverRepository.deleteDriver(id);
  }
}
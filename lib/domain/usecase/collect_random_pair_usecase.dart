import 'package:car_drivers/domain/entity/random_pair_entity.dart';
import 'package:car_drivers/domain/repository/car_repository.dart';
import 'package:car_drivers/domain/repository/driver_repository.dart';

class CollectRandomPairUsecase {
  final ICarRepository carRepository;
  final IDriverRepository driverRepository;

  CollectRandomPairUsecase(this.carRepository, this.driverRepository)
      : assert(driverRepository != null, 'driverRepository cant be null'),
        assert(carRepository != null, 'carRepository cant be null');

  Future<PairEntity> call() async {
    return PairEntity(
      car: await carRepository.getRandomCar(),
      driver: await driverRepository.getRandomDriver(),
    );
  }
}

import 'package:car_drivers/domain/entity/car_entity.dart';
import 'package:car_drivers/domain/repository/car_repository.dart';

class GetCarsUsecase {
  final ICarRepository carRepository;

  GetCarsUsecase(this.carRepository): assert(carRepository != null, 'carRepository cant be null');

  Future<List<CarEntity>> call() async {
    return await carRepository.getAllCars();
  }
}
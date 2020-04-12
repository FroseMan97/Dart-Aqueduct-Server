import 'package:car_drivers/domain/entity/car_entity.dart';
import 'package:car_drivers/domain/repository/car_repository.dart';

class GetCarUsecase {
  final ICarRepository carRepository;

  GetCarUsecase(this.carRepository): assert(carRepository != null, 'carRepository cant be null');

  Future<CarEntity> call(int id) async {
    return await carRepository.getCar(id);
  }
}
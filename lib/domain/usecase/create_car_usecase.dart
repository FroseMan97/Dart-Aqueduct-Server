import 'package:car_drivers/domain/entity/car_entity.dart';
import 'package:car_drivers/domain/models/add_car_model.dart';
import 'package:car_drivers/domain/repository/car_repository.dart';

class CreateCarUsecase {
  final ICarRepository carRepository;

  CreateCarUsecase(this.carRepository): assert(carRepository != null, 'carRepository cant be null');

  Future<CarEntity> call(AddCarModel request) async {
    return await carRepository.createCar(request);
  }
}
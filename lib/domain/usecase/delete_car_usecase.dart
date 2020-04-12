import 'package:car_drivers/domain/repository/car_repository.dart';

class DeleteCarUsecase {
  final ICarRepository carRepository;

  DeleteCarUsecase(this.carRepository): assert(carRepository != null, 'carRepository cant be null');

  Future<int> call(int id) async {
    return await carRepository.deleteCar(id);
  }
}
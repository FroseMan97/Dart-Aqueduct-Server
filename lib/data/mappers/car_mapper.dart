import 'package:car_drivers/data/models/car_model.dart';
import 'package:car_drivers/domain/entity/car_entity.dart';

class CarMapper {
  static List<CarEntity> mapModelsToEntities(List<CarModel> models) {
    return models
        .map(mapModelToEntity)
        .toList();
  }

  static List<CarModel> mapEntitiesToModels(List<CarEntity> entities) {
    return entities.map(mapEntityToModel).toList();
  }

  static CarEntity mapModelToEntity(CarModel model) {
    return CarEntity(
      id: model.id,
      name: model.name,
      photo: model.photo,
    );
  }

  static CarModel mapEntityToModel(CarEntity entity) {
    return CarModel()
        ..name = entity.name
        ..id = entity.id
        ..photo = entity.photo;
  }
}
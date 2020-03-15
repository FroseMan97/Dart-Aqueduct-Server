import 'dart:async';
import 'package:aqueduct/aqueduct.dart';

class Migration1 extends Migration {
  @override
  Future upgrade() async {
    database.createTable(SchemaTable("_CarDriver", [
      SchemaColumn("id", ManagedPropertyType.bigInteger,
          isPrimaryKey: true,
          autoincrement: true,
          isIndexed: false,
          isNullable: false,
          isUnique: false),
      SchemaColumn("name", ManagedPropertyType.string,
          isPrimaryKey: false,
          autoincrement: false,
          isIndexed: false,
          isNullable: false,
          isUnique: false),
      SchemaColumn(
        "avatar",
        ManagedPropertyType.string,
        isPrimaryKey: false,
        autoincrement: false,
        isIndexed: false,
        isNullable: true,
        isUnique: false,
      )
    ]));
  }

  @override
  Future downgrade() async {}

  @override
  Future seed() async {
    final heroNames = [
      {
        'name': "Lewis Hamilton",
        'avatar':
            'http://behandsome.ru/wp-content/uploads/2018/08/Tommy-Hilfiger-x-Lewis-Hamilton-02.jpg',
      },
      {
        'name': "Kimi Raikkonen",
        'avatar':
            'https://www.formula1.com/content/fom-website/en/drivers/kimi-raikkonen/_jcr_content/image.img.640.medium.jpg/1554819054944.jpg',
      }
    ];

    for (final heroName in heroNames) {
      await database.store.execute(
          "INSERT INTO _CarDriver (name, avatar) VALUES (@name, @avatar)",
          substitutionValues: {
            "name": heroName['name'],
            'avatar': heroName['avatar']
          });
    }
  }
}

import 'harness/app.dart';

Future main() async {
  final harness = Harness()..install();

  test("GET /drivers returns 200, body is list and item contains driver fields", () async {
    final response = await harness.agent.get("/drivers");
    final body = await response.body.decode();
    print(body);
    expectResponse(response, 200,);
    expect(body, isList);
    final firstItem = List<Map>.from(body as List).cast<Map>().first;
    expect(true, firstItem.containsKey('id') && firstItem.containsKey('avatar') && firstItem.containsKey('name'));
  });

  test("GET /cars returns 200, body is list and item contains driver fields", () async {
    final response = await harness.agent.get("/cars");
    final body = await response.body.decode();
    print(body);
    expectResponse(response, 200,);
    expect(body, isList);
    final firstItem = List<Map>.from(body as List).cast<Map>().first;
    expect(true, firstItem.containsKey('id') && firstItem.containsKey('photo') && firstItem.containsKey('name'));
  });

  test("GET /random returns 200, body contains driver and car", () async {
    final response = await harness.agent.get("/random");
    final body = await response.body.decode();
    print(body);
    expectResponse(response, 200,);
    expect(body, isMap);
    final Map map = body as Map;
    expect(true, map.containsKey('driver') && map.containsKey('car'));
  });
  
}

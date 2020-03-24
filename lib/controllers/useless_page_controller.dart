

import '../car_drivers.dart';

class UselessPageController extends ResourceController {

  @Operation.get()
  Future<Response> getAllDrivers(
    {@Bind.header('Accept-Language') String lang}
  ) async {
    Map data = {
      'Title': 'Zdarova'
    };
    if(lang?.contains('ru') ?? false) {
      data['title'] = 'Здарова';
    }
    return Response.ok(
      """
        <!DOCTYPE html>
<html lang="ru">

<head>
    <meta charset="UTF-8">
    <title>Авторизация</title>
</head>

<body>
<div class="container">
    <h1>$data</h1>
</div>
</body>

</html>
      """,
    )..contentType = ContentType.html;
  }
}
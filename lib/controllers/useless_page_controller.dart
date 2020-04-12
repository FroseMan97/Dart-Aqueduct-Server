import '../car_drivers.dart';

enum Lang {
  en,
  ru
}

class UselessPageController extends ResourceController {
  @Operation.get()
  Future<Response> getAllDrivers(
      {@Bind.header('Accept-Language') String lang}) async {
        var langEnum = Lang.en;
    if(lang?.contains('ru') ?? false){
      langEnum = Lang.ru;
    }
    final data = langEnum == Lang.en 
      ? {'content': 'Text in english'}
      : {'content': 'Текст на русском'};
    final htmlLang = langEnum == Lang.en 
      ? 'en'
      : 'ru';
    return Response.ok(
      """
        <!DOCTYPE html>
<html lang=$htmlLang>

<head>
    <meta charset="UTF-8">
    <title>For java</title>
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

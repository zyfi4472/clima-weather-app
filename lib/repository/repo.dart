import 'package:clima_weather_app/controller/data_controller.dart';
import 'package:clima_weather_app/model/model.dart';
import 'package:http/http.dart' as http;

class DataRepo {
  static fetchData(String cryptoCurrency, String fiatCurrency) async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://rest.coinapi.io/v1/exchangerate/$cryptoCurrency/$fiatCurrency?apikey=25D86EA3-D9F5-445A-A1C8-75C9EA531B9D#'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // DataController.modelClass =
      //     ModelClassFromJson(await response.stream.bytesToString());

      // Add the data to the list using DataController's method

      DataController.addDataToList(
          ModelClassFromJson(await response.stream.bytesToString()));

      print('Repo working fine');
      // Print the response body
      // print('API Response: ${response.stream.bytesToString()}');

      return response.statusCode;
    } else {
      print(response.reasonPhrase);
    }
  }
}

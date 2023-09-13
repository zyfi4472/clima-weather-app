import 'package:clima_weather_app/model/model.dart';

class DataController {
  static ModelClass? modelClass;

  static List<ModelClass> modelList = [];

  // Add a method to add data to the list
  static void addDataToList(ModelClass data) {
    modelList.add(data);
  }
}

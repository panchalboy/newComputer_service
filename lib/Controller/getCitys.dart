import 'package:computer_service/shared_components/comonWidget.dart';
import 'package:get/get.dart';

import '../Http/dioClient.dart';
import '../ModelClass/GetCitysModel.dart';

DioClient dioClient = new DioClient();

class CityListController extends GetxController {
  Result currentSelectedCityValue;
  List allcity = [].obs;
  final _cityloading = true.obs;
  bool get isCityLoading => this._cityloading.value;

  void changeCityLoading(bool v) => this._cityloading.value = v;

  Future loadData(cityId, form) async {
    try {
      changeCityLoading(true);
      final response = await dioClient.getRequest('cities');

      final list = (response.data['result'] as List)
          .map((data) => Result.fromJson(data))
          .toList();
      print("list----$list");

      //  ;
      allcity = list;
      if (cityId != "") {
        final cityData = allcity.where((element) => element.id == cityId);

        print("list----$cityData");
        currentSelectedCityValue = cityData.first;

        print("currentSelectedCityValue----$form");
      }

      changeCityLoading(false);
      update();
    } catch (err) {
      changeCityLoading(false);
      toastWidget("Somwthing Went Wrong");
      print("error--$err");
    }
  }
}

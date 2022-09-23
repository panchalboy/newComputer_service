import 'package:computer_service/ModelClass/ServicesModel.dart';
import 'package:computer_service/shared_components/comonWidget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // for date format

import '../Http/dioClient.dart';
import '../ModelClass/serviceDetailsModel.dart';

DioClient dioClient = new DioClient();

class ServicsController extends GetxController {
  List allProduct = [].obs;
  var serviceDetails;

  var deliveryDateS;
  var expireDates;
  final _loading = false.obs;
  final _serviceLodding = false.obs;
  bool get isLoading => this._loading.value;

  void changeLoading(bool v) => this._loading.value = v;
  bool get isSericeLodding => this._serviceLodding.value;

  void changeSericeLodding(bool v) => this._serviceLodding.value = v;

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  void loadData() async {
    try {
      changeLoading(true);
      final response = await dioClient.getRequest('service');
      print("rsicn---${response.data}");

      final list = (response.data['result'] as List)
          .map((data) => Result.fromJson(data))
          .toList();
      allProduct = list;
      print("product---$allProduct");
      changeLoading(false);
      update();
    } catch (err) {
      changeLoading(false);
      toastWidget("Somwthing Went Wrong");
      print("error--$err");
    }
  }
}

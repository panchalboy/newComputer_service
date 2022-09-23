import 'package:computer_service/ModelClass/MyservicesModel.dart';
import 'package:get/get.dart';

import '../Http/dioClient.dart';

DioClient dioClient = new DioClient();

class MyServicsController extends GetxController {
  List allProduct = [].obs;
  var serviceDetails;
  final _loading = true.obs;
  bool get isLoading => this._loading.value;

  void changeLoading(bool v) => this._loading.value = v;

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  void loadData() async {
    try {
      changeLoading(true);
      final response = await dioClient.getRequest('order/services');

      final list = (response.data['result'] as List)
          .map((data) => Result.fromJson(data))
          .toList();
      allProduct = list;
      print("product---$allProduct");
      changeLoading(false);
      update();
    } catch (err) {
      print("error--$err");
    }
  }
}

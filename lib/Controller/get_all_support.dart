import 'package:get/get.dart';

import '../Http/dioClient.dart';
import '../ModelClass/get_all_support_model.dart';

DioClient dioClient = new DioClient();

class AllSupportController extends GetxController {
  List allProduct = [].obs;
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
      final response = await dioClient.getRequest('support');

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

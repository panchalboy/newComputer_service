import 'package:computer_service/shared_components/comonWidget.dart';
import 'package:get/get.dart';

import '../Http/dioClient.dart';
import '../ModelClass/darshboard_product_Model.dart';
import '../View/productdetails/product_details_page.dart';

DioClient dioClient = new DioClient();

class DashboardController extends GetxController {
  List allProduct = [].obs;
  List serchProduct = [].obs;
  final _loading = true.obs;
  bool get isLoading => this._loading.value;
  void changeLoading(bool v) => this._loading.value = v;
  final _searchLoading = false.obs;
  bool get isSearchLoading => this._searchLoading.value;
  void changeSearchLoading(bool v) => this._searchLoading.value = v;

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  void loadData() async {
    try {
      changeLoading(true);
      final response = await dioClient.getRequest('product');

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

  onSearch(query) async {
    serchProduct.clear();
    try {
      changeSearchLoading(true);
      final response =
          await dioClient.getRequest('product/search/data?q=$query');
      final list = (response.data['result'] as List)
          .map((data) => Result.fromJson(data))
          .toList();
      serchProduct = list;
      changeSearchLoading(false);
      print("product----${serchProduct}");
      return serchProduct;
    } catch (err) {
      changeSearchLoading(false);
      toastWidget("Somwthing Went Wrong");
      print("error--$err");
    }
  }

  void onClick(item) {
    Get.to(ProductDetailScreen(
      id: item.id,
      type: "PRODUCT",
      productName: item.productName,
    ));
  }
}

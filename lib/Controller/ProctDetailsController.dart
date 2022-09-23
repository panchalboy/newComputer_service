import 'package:computer_service/ModelClass/darshboard_product_Model.dart';
import 'package:computer_service/ModelClass/serviceDetailsModel.dart';
import 'package:computer_service/shared_components/comonWidget.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart'; // for date format
import '../Http/dioClient.dart';
import '../ModelClass/productDetailsModel.dart';

DioClient dioClient = new DioClient();

class ProductDetailsController extends GetxController {
  var productDetails = ProductDetailsModel().obs;
  final _orerLoading = false.obs;
  var serviceDetails;
  var deliveryDateS;
  var expireDates;
  final _loading = true.obs;
  List productImage = [];
  int productQyt;
  var productName = "".obs;
  bool get isLoading => this._loading.value;
  bool get isOrderLoadding => this._orerLoading.value;
  void changeLoading(bool v) => this._loading.value = v;
  void changeOrderLoading(bool val) => this._orerLoading.value = val;
  void loadData(
    id,
  ) async {
    await GetStorage.init();
    try {
      changeLoading(true);
      final response = await dioClient.getRequest('product/$id');
      final data = ProductDetailsModel.fromJson(response.data);
      final storage = GetStorage();
      String role = storage.read("role");
      print("role----$role");
      productDetails.value = data;
      productQyt = role == "dealer" ? productDetails.value.result.minQty : 1;
      productName.value = productDetails.value.result.productName;
      productImage.add(productDetails.value.result.productImg);
      productDetails.value.result.productGallery.forEach((ele) {
        productImage.add(ele.img);
      });
      print("fdffgfg---$productImage");

      changeLoading(false);
      update();
    } catch (err) {
      changeLoading(false);
      toastWidget("SomeThing Went Wrong");
      print("error--$err");
    }
  }
}

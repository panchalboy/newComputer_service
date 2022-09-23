import 'package:computer_service/shared_components/comonWidget.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart'; // fo
import '../Http/dioClient.dart';
import '../ModelClass/productDetailsModel.dart';
import '../ModelClass/serviceDetailsModel.dart';

DioClient dioClient = new DioClient();

class SerivceDetailsController extends GetxController {
  var serviceDetails;
  final _orerLoading = false.obs;
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

  void getServiceDetails(id) async {
    try {
      changeLoading(true);
      final response = await dioClient.getRequest('service/$id');

      final list = ServiceDetailsModel.fromJson(response.data['result']);
      serviceDetails = list;
      print("dettals-rrr--$serviceDetails");

      changeLoading(false);
      print("hyyy---");
      update();
    } catch (err) {
      changeLoading(false);
      update();
      toastWidget("something Went Wrong");
      print("error--$err");
    }
  }

  createOrder(url, reqObj) async {
    try {
      final response = await dioClient.postRequest(url, reqObj);
      return response;
    } catch (e) {}
  }
}

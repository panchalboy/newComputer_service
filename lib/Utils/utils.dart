import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Routes/routes.dart';
import 'constants.dart';

void onLocalSetup(data) async {
  print("data---$data");
  final storage = GetStorage();
  await storage.write('user_id', data['_id']);
  await storage.write('token', data['token']);
  await storage.write('user_image', data['image']);
  await storage.write('name', '${data['name']}');
  await storage.write('email', data['email']);
  await storage.write('phone', data['phone']);
  await storage.write('role', data['role']);
  await storage.write(isLOGGEDIN, true);

  Get.offAllNamed(Routes.HOME);
}

void onClearLocalSetup() async {
  final storage = GetStorage();
  await storage.remove('user_id');
  await storage.remove('token');
  await storage.remove('user_image');
  await storage.remove('name');
  await storage.remove('email');
  await storage.remove('phone');
  await storage.remove('role');
  await storage.write(isLOGGEDIN, false);
  Get.offAllNamed(Routes.LOGIN);
}

import 'package:get/get.dart';

class SideNavigationController extends GetxController {
  var index = 0.obs;

  handleChangeIndex(int idx) {
    index.value = idx;
    update();
  }
}

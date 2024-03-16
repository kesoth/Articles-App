import 'package:articles_app/views/screens/authentication/controller/authentication_controller.dart';
import 'package:get/get.dart';


class ScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    
  }
}

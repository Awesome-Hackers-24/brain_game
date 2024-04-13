import 'package:brain_game/services/supabase_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final SupabaseService supa = Get.find<SupabaseService>();

  RxString text = 'Hello'.obs;

  @override
  onInit() async {
    super.onInit();
    supa.read();
    supa.subscribe((newText) {
      text.value = newText;
    });
  }
}

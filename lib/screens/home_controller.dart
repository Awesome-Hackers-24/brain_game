import 'package:brain_game/services/supabase_service.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class HomeController extends GetxController {
  final SupabaseService supa = Get.find<SupabaseService>();

  // RxString text = 'Hello'.obs;
  RxMap<String, dynamic> data = <String, dynamic>{'pos1': 123.45}.obs;

  @override
  onInit() async {
    super.onInit();
    // supa.read();
    supa.subscribe((newText) {
      data.value = newText;
    });
  }
}

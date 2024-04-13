import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService extends GetxService {
  final SupabaseClient supabase = Get.find<SupabaseClient>();

  void subscribe(void Function(String) callback) {
    supabase
        .channel('public:Test')
        .onPostgresChanges(
            event: PostgresChangeEvent.all,
            schema: 'public',
            table: 'Test',
            callback: (payload) {
              print('Change received: ${payload.toString()}');
              callback(payload.newRecord["test"]);
            })
        .subscribe();
  }

  Future<String> read() async {
    final data = await supabase.from('Test').select();

    return data[0]['test'];
  }
}

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService extends GetxService {
  final SupabaseClient supabase = Get.find<SupabaseClient>();

  void subscribe(void Function(Map<String, dynamic>) callback) {
    supabase
        .channel('public:sensor_data')
        .onPostgresChanges(
            event: PostgresChangeEvent.all,
            schema: 'public',
            table: 'sensor_data',
            callback: (payload) {
              print('Change received: ${payload.toString()}');
              callback(payload.newRecord);
            })
        .subscribe();
  }

  Future<String> read() async {
    final data = await supabase.from('Test').select();

    return data[0]['test'];
  }
}

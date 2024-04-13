import 'package:brain_game/screens/home_controller.dart';
import 'package:brain_game/services/supabase_service.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GetBindings {
  static Future init() async {
    Supabase supabase = await Supabase.initialize(
      url: 'https://sfesooveqwsgfzkosmxu.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNmZXNvb3ZlcXdzZ2Z6a29zbXh1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTI5OTg0MzMsImV4cCI6MjAyODU3NDQzM30.VsmHNhrmVG1Iznyva5-KPDykWAo9F58B72y2lZx_blw',
      debug: true,
    );
    SupabaseClient supaClient = Supabase.instance.client;

    Get.lazyPut(() => supaClient, fenix: true);
    Get.lazyPut(() => SupabaseService(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
  }
}

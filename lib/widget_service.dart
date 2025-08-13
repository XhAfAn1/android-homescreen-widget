import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class WidgetService {
  static const platform = MethodChannel('app_widget_channel');
  static Function(String)? onDataReceived;

  static void initialize() {
    platform.setMethodCallHandler((call) async {
      if (call.method == "onWidgetDataReceived") {
        onDataReceived?.call(call.arguments);
      }
    });
  }

  static Future<String?> getInitialData() async {
    try {
      return await platform.invokeMethod('getInitialData');
    } on PlatformException catch (e) {
      debugPrint("Failed to get initial data: ${e.message}");
      return null;
    }
  }
}
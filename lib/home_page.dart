import 'package:flutter/material.dart';
import 'widget_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _widgetData;

  @override
  void initState() {
    super.initState();
    WidgetService.initialize();
    WidgetService.onDataReceived = _handleWidgetData;
    _checkForWidgetData();
  }

  void _handleWidgetData(String data) {
    if (mounted) {
      setState(() => _widgetData = data);
      _showSnackbar('Live data from widget: $data');
    }
  }

  Future<void> _checkForWidgetData() async {
    final data = await WidgetService.getInitialData();
    if (data != null && mounted) {
      setState(() => _widgetData = data);
      _showSnackbar('Initial data from widget: $data');
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Widget Demo')),
      body: Center(
        child: _widgetData != null
            ? Text('Received: $_widgetData', style: const TextStyle(fontSize: 24))
            : const Text('No widget data received'),
      ),
    );
  }

  @override
  void dispose() {
    WidgetService.onDataReceived = null;
    super.dispose();
  }
}
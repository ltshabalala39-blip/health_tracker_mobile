import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Required to parse JSON

void main() {
  runApp(const HealthDashboardApp());
}

// 1. The Root Application
class HealthDashboardApp extends StatelessWidget {
  const HealthDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Public Health',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal)),
      home: const DashboardScreen(), // Points to our stateful screen
    );
  }
}

// 2. The Stateful Screen
// (It is "Stateful" because the UI must redraw when the data finishes loading)
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<dynamic> apiData = [];
  bool isLoading = true;

  // This built-in function fires exactly once when the screen first opens
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // 3. The HTTP Request
  Future<void> fetchData() async {
    //IP RULE:
    // If testing as a Linux Desktop app, 127.0.0.1 works.
    // If testing on an Android Emulator, you MUST change this to 10.0.2.2
    final url = Uri.parse('http://127.0.0.1:8000/api/v1/cases/western_cape');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print('RAW JSON: ${response.body}');
        setState(() {
          apiData = json.decode(response.body);
          isLoading = false; // Turn off the loading spinner
        });
      } else {
        print('Server Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Network Error: $e');
    }
  }

  // 4. The UI Builder
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mortality Data (Western Cape)'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // Shows while waiting for API
          : ListView.builder( // Loops through my JSON list
        itemCount: apiData.length,
        itemBuilder: (context, index) {
          final item = apiData[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.medical_services),
              title: Text('Week: ${item['week']}'),

              subtitle: Text('Deaths: ${item['western_cape'] ?? 'No Data'}'), // THis ?? opertaor tells Dart : If the value is null , print No data
            ),
          );
        },
      ),
    );
  }
}
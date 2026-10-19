import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const HealthDashboardApp());
}

class HealthDashboardApp extends StatelessWidget {
  const HealthDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Public Health',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal)),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<dynamic> apiData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = Uri.parse('http://127.0.0.1:8000/api/v1/cases/western_cape');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          apiData = json.decode(response.body);
          isLoading = false;
        });
      } else {
        print('Server Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Network Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mortality Data (Western Cape)'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          DataSummaryHeader(recordCount: apiData.length), // Comma added here!
          Expanded(
            child: ListView.builder(
              itemCount: apiData.length,
              itemBuilder: (context, index) {
                final item = apiData[index];
                return MortalityCard(
                  week: item['week'].toString(),
                  deaths: item['western_cape'],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isLoading = true;
          });
          fetchData();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}



class DataSummaryHeader extends StatelessWidget {
  final int recordCount;

  const DataSummaryHeader({super.key, required this.recordCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Text(
        'Showing $recordCount records',
        style: Theme.of(context).textTheme.titleMedium,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class MortalityCard extends StatelessWidget {
  final String week;
  final dynamic deaths;

  const MortalityCard({super.key, required this.week, this.deaths});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: const Icon(Icons.calendar_month),
        title: Text('Week: $week'),
        subtitle: Text('Deaths: ${deaths ?? 'No Data'}'),
      ),
    );
  }
}
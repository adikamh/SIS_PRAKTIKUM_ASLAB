import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Warung IS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ), // ThemeData
      home: SplashScreen(),
    ); // MaterialApp
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _goToNavigateToHome();
  }

  _goToNavigateToHome() async {
    await Future.delayed(Duration(seconds: 4));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ), // MaterialPageRoute
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(
          image: AssetImage('assets/cafe.png'),
          width: 150,
          height: 150,
        ), // Image
      ), // Center
    ); // Scaffold
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> foodlist = [
    'Espresso',
    'Americano',
    'Matcha Latte',
    'Chocolate Frappe',
  ];

  String searchText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Welcome'),
      ), // AppBar
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Cari Minuman',
              ), // InputDecoration
              onChanged: (value) {
                setState(() {
                  searchText = value.toLowerCase();
                });
              },
            ), // TextField
          ), // Padding
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(8.0),
              children: foodlist
                  .where((food) => food.toLowerCase().contains(searchText))
                  .map((food) {
                return Container(
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10),
                  ), // BoxDecoration
                  child: ListTile(
                    leading: Icon(Icons.food_bank_rounded),
                    title: Text(food, style: TextStyle(fontSize: 20)),
                    trailing: ElevatedButton(
                      onPressed: () {
                        _showConfirmationDialog(context, food);
                      },
                      child: Text('Pesan', style: TextStyle(fontSize: 16)),
                    ), // ElevatedButton
                  ), // ListTile
                ); // Container
              }).toList(),
            ), // ListView
          ), // Expanded
        ],
      ), // Column
    ); // Scaffold
  }

  void _showConfirmationDialog(BuildContext context, String foodName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Pesanan'),
          content: Text('Apakah Anda yakin ingin memesan $foodName?'),
          actions: [
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ), // TextButton
            TextButton(
              child: Text('Ya'),
              onPressed: () {
                Navigator.of(context).pop();
                _showSuccessDialog(context, foodName);
              },
            ), // TextButton
          ],
        ); // AlertDialog
      },
    );
  }

  void _showSuccessDialog(BuildContext context, String foodName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pesanan Berhasil'),
          content: Text('Anda telah memesan $foodName.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ), // TextButton
          ],
        ); // AlertDialog
      },
    );
  }
}

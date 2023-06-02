import 'package:flutter/material.dart';
import 'env.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String lat = "";
  String lon = "";
  String weather = "";

  TextEditingController latController = TextEditingController();
  TextEditingController lonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Weather API"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: lonController,
              decoration: InputDecoration(hintText: "Longitude"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: latController,
              decoration: InputDecoration(hintText: "Latitude"),
            ),
          ),
          SizedBox(
            child: Center(child: Text("$weather")),
            height: MediaQuery.of(context).size.height / 3,
          ),
          ElevatedButton(
              onPressed: () async {
                Uri url = Uri.parse(
                    "https://api.openweathermap.org/data/2.5/weather?lat=${latController.text}&lon=${lonController.text}&appid=$api_key");
                var response = await http.get(url);
                print(response.statusCode);
                setState(() {
                  weather = response.body;
                });
              },
              child: Text("Get Data"))
        ],
      ),
    );
  }
}

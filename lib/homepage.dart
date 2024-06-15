import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String stringResponse = ""; // Initialize with an empty string
  late Map<String, dynamic> mapResponse;
  late Map dataResponse;
  late List listResponse;

  Future<void> apicall() async {
    // Make HTTP GET request
    var url =
        Uri.parse("https://reqres.in/api/users?page=2"); // Example API endpoint
    var response = await http.get(url);

    // Check if the response is successful
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body); // Store parsed JSON response
        listResponse = mapResponse['data'];
      });
    } else {
      setState(() {
        stringResponse = "Failed to load data"; // Handle error case
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Call the API function when the widget is first created.
    apicall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 226, 145, 172),
          title: Text(
            "API Demo",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(listResponse[index]['avatar']),
                  ),
                  Text(listResponse[index]['id'].toString()),
                  Text(listResponse[index]['email'].toString()),
                  Text(listResponse[index]['first_name'].toString()),
                  Text(listResponse[index]['last_name'].toString()),
                ],
              ),
            );
          },
          itemCount: listResponse == null ? 0 : listResponse.length,
        ));
  }
}

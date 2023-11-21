import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> with TickerProviderStateMixin {
  late TabController _tabController;
  Map data = {};
  Future<Map> getData() async {
    var response = await get(
      Uri.parse("http://api.alquran.cloud/v1/surah"),
    );
    var responseData = jsonDecode(response.body);
    data.addAll(responseData);
    setState(() {});
    return responseData;
  }

  @override
  void initState() {
    getData();
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Quran",
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
          Icon(Icons.menu_book_outlined),
          Icon(Icons.search),
          Icon(Icons.menu),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Text("SURAHS"),
            Text("JUZ'"),
            Text("BOOKMARKS"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          ListView.builder(
            itemCount: 114,
            itemBuilder: (context, i) {
              return Card(
                child: ListTile(
                  leading: Text(
                    data["data"][i]["number"].toString(),
                    style: const TextStyle(fontSize: 30),
                  ),
                  title: Text(
                    data["data"][i]["englishName"],
                  ),
                  subtitle: Text(
                      "${data["data"][i]["revelationType"]} - ${data["data"][i]["numberOfAyahs"]}"),
                ),
              );
            },
          ),
          const Center(
            child: Text("It's rainy here"),
          ),
          const Center(
            child: Text("It's sunny here"),
          ),
        ],
      ),
    );
  }
}

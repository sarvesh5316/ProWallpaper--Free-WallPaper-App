// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:demolearn/pages/wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key, required this.title});
  // ignore: prefer_typing_uninitialized_variables
  final title;

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  List image = [];
  int page = 1;
  @override
  void initState() {
    fetchapi();
    super.initState();
  }

  fetchapi() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=90'),
        headers: {
          'authorization':
              'KtOaV5J3xXrtpzfpBCt1oRLbnJfsy98si1ZkXvx0NYcjUaAyvotN748I'
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        image = result['photos'];
      });
      // print(image[0]);
    });
  }

  loadmore() async {
    setState(() {
      page = page + 1;
    });
    String url = 'https://api.pexels.com/v1/curated?per_page=90&page=$page';
    await http.get(Uri.parse(url), headers: {
      'authorization':
          'KtOaV5J3xXrtpzfpBCt1oRLbnJfsy98si1ZkXvx0NYcjUaAyvotN748I'
    }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        image.addAll(result['photos']);
      });
      // print(image[0]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            loadmore();
          },
          label: Text("Load More"),
          icon: Icon(Icons.wallpaper),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text("Progremmo Wallpaper !"),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
                itemCount: image.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 3,
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 3,
                  mainAxisSpacing: 3,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Get.to(() => SetWallpaper(
                          imageUrl: image[index]['src']['large2x']));
                    },
                    child: Container(
                      // height: 90,
                      color: Colors.white,
                      child: Image.network(
                        image[index]['src']['tiny'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

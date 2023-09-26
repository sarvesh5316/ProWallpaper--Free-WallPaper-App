// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class SetWallpaper extends StatefulWidget {
  const SetWallpaper({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  State<SetWallpaper> createState() => _SetWallpaperState();
}

class _SetWallpaperState extends State<SetWallpaper> {
  Future<void> setWallpaper() async {
    int location = WallpaperManager.HOME_SCREEN;

    var file = await DefaultCacheManager().getSingleFile(widget.imageUrl);
    // ignore: unused_local_variable
    final bool result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);
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
            setWallpaper();
            showDialog(
                context: context,
                builder: (context) {
                  Future.delayed(Duration(seconds: 1), () {
                    Navigator.pop(context);
                  });
                  return AlertDialog(
                    title: SizedBox(
                        width: 250,
                        child: Text(
                          'Your Wallpaper has been saved Successfully!',
                          style: TextStyle(fontSize: 15),
                        )),
                  );
                });
          },
          label: Text("Set Wallpaper"),
          icon: Icon(Icons.wallpaper),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            // width: MediaQuery.of(context).size.width,
            child: Image.network(
              widget.imageUrl,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}

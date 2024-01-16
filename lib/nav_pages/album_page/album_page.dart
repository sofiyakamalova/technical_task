import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:techtask/nav_pages/album_page/album_model/album_model.dart';
import 'package:techtask/nav_pages/album_page/images_page.dart';

class AlbumPage extends StatefulWidget {
  const AlbumPage({super.key});

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5777A2),
        title: const Text(
          'Photos',
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 30, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
            future: ReadJsonData(),
            builder: (context, data) {
              if (data.hasError) {
                return Center(child: Text("${data.error}"));
              } else if (data.hasData) {
                var items = data.data as List<AlbumModel>;
                return ListView.separated(
                    itemCount: items == null ? 0 : items.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 5);
                    },
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(
                                Icons.image,
                                size: 30,
                                color: Colors.black,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  items[index].title.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF164F80),
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ImagesPage(),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.chevron_right,
                                    size: 30,
                                    color: Colors.black,
                                  )),
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  Future<List<AlbumModel>> ReadJsonData() async {
    final jsondata = await rootBundle.loadString('json_files/albums.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => AlbumModel.fromJson(e)).toList();
  }
}

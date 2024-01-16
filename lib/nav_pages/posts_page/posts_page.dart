import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:techtask/nav_pages/posts_page/post_details.dart';
import 'package:techtask/nav_pages/posts_page/post_model/post_model.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5777A2),
        title: const Text(
          'Posts',
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 30, color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: ReadJsonData(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(child: Text("${data.error}"));
          } else if (data.hasData) {
            var items = data.data as List<PostModel>;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.separated(
                  itemCount: items == null ? 0 : items.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 5);
                  },
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PostDetails(post: items[index]),
                            ));
                      },
                      child: Container(
                        height: 200,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  items[index].title.toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF164F80),
                                  ),
                                ),
                                Text(
                                  items[index].body.toString(),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<List<PostModel>> ReadJsonData() async {
    final jsondata = await rootBundle.loadString('json_files/posts.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => PostModel.fromJson(e)).toList();
  }
}

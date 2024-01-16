import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:techtask/nav_pages/posts_page/comment_model/comment_model.dart';
import 'package:techtask/nav_pages/posts_page/post_model/post_model.dart';

class PostDetails extends StatefulWidget {
  final PostModel post;
  PostDetails({required this.post});

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5777A2),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      widget.post.title.toString(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(height: 1, color: Color(0xFF5777A2)),
                  const SizedBox(height: 10),
                  Text(
                    widget.post.body.toString(),
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(width: 10),
                Text('Comments',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder(
                  future: ReadJsonData(),
                  builder: (context, data) {
                    if (data.hasError) {
                      return Center(child: Text("${data.error}"));
                    } else if (data.hasData) {
                      var items = data.data as List<CommentModel>;
                      return ListView.builder(
                          itemCount: items == null ? 0 : items.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.grey.shade50,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text(
                                      items[index].name.toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      items[index]
                                          .email
                                          .toString()
                                          .toLowerCase(),
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      items[index].body.toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
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
          ],
        ),
      ),
    );
  }

  Future<List<CommentModel>> ReadJsonData() async {
    final jsondata = await rootBundle.loadString('json_files/comments.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => CommentModel.fromJson(e)).toList();
  }
}

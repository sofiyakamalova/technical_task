import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:techtask/nav_pages/users_page/user_details.dart';
import 'package:techtask/nav_pages/users_page/user_model/user_model.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5777A2),
        title: const Text(
          'Users',
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
            var items = data.data as List<UserModel>;
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
                                  UserDetails(user: items[index]),
                            ));
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xFF5777A2),
                                child: Text(
                                  items[index].name![0].toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text(
                                    items[index]
                                        .username
                                        .toString()
                                        .toLowerCase(),
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF164F80),
                                    ),
                                  ),
                                  Text(
                                    items[index].name.toString(),
                                    maxLines: 3,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
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

  Future<List<UserModel>> ReadJsonData() async {
    final jsondata = await rootBundle.loadString('json_files/users.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => UserModel.fromJson(e)).toList();
  }
}

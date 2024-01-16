import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:techtask/nav_pages/to_do_page/to_do_model/to_do_model.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({Key? key}) : super(key: key);

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  List<ToDoModel> _foundItem = [];
  List<ToDoModel> _displayedItem = [];

  @override
  void initState() {
    ReadJsonData().then((data) {
      setState(() {
        _foundItem = data;
        _displayedItem = List.from(_foundItem);
      });
    });
    super.initState();
  }

  void sortItem(String enteredKeyword) {
    if (enteredKeyword.toLowerCase() == "completed") {
      _displayedItem =
          _foundItem.where((item) => item.completed == true).toList();
    } else if (enteredKeyword.toLowerCase() == "notcompleted") {
      _displayedItem =
          _foundItem.where((item) => item.completed == false).toList();
    } else if (enteredKeyword.toLowerCase() == "all") {
      _displayedItem = List.from(_foundItem);
    }

    setState(() {});
  }

  Widget buttonComp() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Theme.of(context).colorScheme.primary.withOpacity(0.5);
            }
            return null;
          },
        ),
      ),
      child: const Text('COMPLETED'),
      onPressed: () {
        sortItem("completed");
      },
    );
  }

  Widget buttonNotComp() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Theme.of(context).colorScheme.primary.withOpacity(0.5);
            }
            return null;
          },
        ),
      ),
      child: const Text('NOT COMPLETED'),
      onPressed: () {
        sortItem("notcompleted");
      },
    );
  }

  Widget ButtonAll() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Theme.of(context).colorScheme.primary.withOpacity(0.5);
            }
            return null;
          },
        ),
      ),
      child: const Text('ALL'),
      onPressed: () {
        sortItem("all");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5777A2),
        title: const Text(
          'To Do List',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        actions: [
          PopupMenuButton(
            icon: Container(
              height: 20,
              width: 20,
              child: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("COMPLETED"),
                value: "COMPLETED",
                onTap: () {
                  sortItem("completed");
                },
              ),
              PopupMenuItem(
                child: Text("NOT COMPLETED"),
                value: "NOTCOMPLETED",
                onTap: () {
                  sortItem("notcompleted");
                },
              ),
              PopupMenuItem(
                child: Text("ALL"),
                value: "ALL",
                onTap: () {
                  sortItem("all");
                },
              ),
            ],
          ),
        ],
      ),
      body: FutureBuilder(
        future: ReadJsonData(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(child: Text("${data.error}"));
          } else if (data.hasData) {
            return Builder(
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                    itemCount: _displayedItem.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 4);
                    },
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                _displayedItem[index].title ?? 'No title',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF164F80),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    _displayedItem[index].completed == true
                                        ? 'COMPLETED'
                                        : 'NOT COMPLETED',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
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

  Future<List<ToDoModel>> ReadJsonData() async {
    final jsondata = await rootBundle.loadString('json_files/todos.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => ToDoModel.fromJson(e)).toList();
  }
}

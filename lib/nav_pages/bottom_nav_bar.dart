import 'package:flutter/material.dart';
import 'package:techtask/nav_pages/album_page/album_page.dart';
import 'package:techtask/nav_pages/posts_page/posts_page.dart';
import 'package:techtask/nav_pages/to_do_page/to_do_page.dart';
import 'package:techtask/nav_pages/users_page/users_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List pages = [
    const PostsPage(),
    const AlbumPage(),
    const ToDoPage(),
    const UsersPage(),
  ];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Color(0xFF5777A2),
        unselectedItemColor: Colors.black.withOpacity(0.4),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.apps)),
          BottomNavigationBarItem(
              label: "Albums", icon: Icon(Icons.photo_library_sharp)),
          BottomNavigationBarItem(
              label: "To Do List", icon: Icon(Icons.checklist_rtl)),
          BottomNavigationBarItem(label: "Users", icon: Icon(Icons.people)),
        ],
      ),
    );
  }
}

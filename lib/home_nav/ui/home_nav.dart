import 'package:day2/home/ui/home_page.dart';
import 'package:day2/location/ui/location_flutter.dart';
import 'package:day2/profile/ui/profile_flutter.dart';
import 'package:flutter/material.dart';

class HomeNav extends StatefulWidget {
  const HomeNav({super.key});

  @override
  State<HomeNav> createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {
  int _currentIndex = 0;

  callPage() {
    switch (_currentIndex) {
      case 0:
        return HomePage();
      case 1:
        return const Center(
          child: Text("Camera"),
        );
      case 2:
        return LocationPage();
      case 3:
        return ProfilePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: callPage(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.cyan,
        selectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (val) {
          setState(() {
            _currentIndex = val;
          });
        },
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          const BottomNavigationBarItem(icon: Icon(Icons.camera), label: "Camera"),
          const BottomNavigationBarItem(icon: Icon(Icons.map), label: "Location"),
          const BottomNavigationBarItem(icon: Icon(Icons.people), label: "Profile"),
        ],
      ),
    );
  }
}

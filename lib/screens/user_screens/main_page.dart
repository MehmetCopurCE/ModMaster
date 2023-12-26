import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_project/auth/widgets/login_form.dart';
import 'package:mobile_project/screens/user_screens/example_charts.dart';
import 'package:mobile_project/screens/user_screens/profile_page.dart';
import 'package:mobile_project/screens/user_screens/settings_page.dart';
import 'package:mobile_project/screens/user_screens/home_page.dart';
import '../../utils/constants.dart';
import 'package:mobile_project/screens/user_screens/main_page.dart';

class BottomNavy extends StatefulWidget {
  const BottomNavy({Key? key}) : super(key: key);

  @override
  State<BottomNavy> createState() => _BottomNavyState();
}

class _BottomNavyState extends State<BottomNavy> {
  String title = "Main Page";
  int currentIndex = 1;

  void onTopItem(int index) {
    setState(() {
      currentIndex = index;
      if (currentIndex == 0) {
        title = "Charts";
      } else if (currentIndex == 1) {
        title = "Main Page";
      } else if (currentIndex == 2) {
        title = "Settings";
      } else {
        title = "Profile";
      }
    });
  }

  Widget? page() {
    if (currentIndex == 0) {
      return EchartsPage();
    } else if (currentIndex == 1) {
      return HomePage();
    } else if (currentIndex == 2) {
      return SettingsPage();
    } else {
      return const ProfilePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                // Handle the onTap for the InkWell if needed
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[900]
                      : Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
      body: page(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        onTap: (value) {
          setState(() {
            onTopItem(value);
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            label: "Charts",
            icon: Icon(Icons.bar_chart),
            backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          ),

          BottomNavigationBarItem(
            label: "Main Page",
            icon: Icon(Icons.home),
            backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          ),
          BottomNavigationBarItem(
            label: "Settings",
            icon: Icon(Icons.settings),
            backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.person),
            backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          ),

        ],
      ),
    );
  }
}

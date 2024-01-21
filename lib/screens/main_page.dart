import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/screens/user_screens/chart_page.dart';
import 'package:mobile_project/screens/user_screens/my_chart.dart';
import 'package:mobile_project/screens/user_screens/profile_page.dart';
import 'package:mobile_project/screens/user_screens/settings_page.dart';
import 'package:mobile_project/screens/user_screens/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomNavy extends StatefulWidget {
  const BottomNavy({Key? key}) : super(key: key);

  @override
  State<BottomNavy> createState() => _BottomNavyState();
}

class _BottomNavyState extends State<BottomNavy> {
  String title = "Home Page";
  int currentIndex = 1;
  void onTopItem(int index) {
    setState(() {
      currentIndex = index;
      if (currentIndex == 0) {
        title = AppLocalizations.of(context)?.charts ?? '';
      } else if (currentIndex == 1) {
        title = AppLocalizations.of(context)?.home ?? ''; //home page
      } else if (currentIndex == 2) {
        title = AppLocalizations.of(context)?.settings ?? ''; //settings
      } else {
        title = AppLocalizations.of(context)?.profile ?? ''; //profile
      }
    });

    // if (currentIndex == 1) {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => BottomNavy()),
    //   );
    // }
  }

  Widget? page() {
    if (currentIndex == 0) {
      title = AppLocalizations.of(context)?.charts ?? '';
      return ChartPage();
    } else if (currentIndex == 1) {
      title = AppLocalizations.of(context)?.home ?? ''; //main page?home
      return const HomePage();
    } else if (currentIndex == 2) {
      title = AppLocalizations.of(context)?.settings ?? ''; //settings
      return SettingsPage();
    } else {
      title = AppLocalizations.of(context)?.profile ?? ''; //profile
      return const ProfilePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
        // actions: [
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: InkWell(
        //     onTap: () {
        //       // Handle the onTap for the InkWell if needed
        //     },
        //     child: Container(
        //       alignment: Alignment.center,
        //       decoration: BoxDecoration(
        //         color: Theme.of(context).brightness == Brightness.dark
        //             ? Colors.grey[900]
        //             : Colors.white.withOpacity(0.9),
        //         borderRadius: BorderRadius.circular(10),
        //       ),
        //     ),
        //   ),
        // ),
        // ],
      ),
      body: page(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        onTap: (value) {
          setState(() {
            onTopItem(value);
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            label: AppLocalizations.of(context)?.charts ?? '',
            icon: const Icon(Icons.bar_chart),
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          ),
          BottomNavigationBarItem(
            label: AppLocalizations.of(context)?.home ?? '', //home page
            icon: const Icon(Icons.home),
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          ),
          BottomNavigationBarItem(
            label: AppLocalizations.of(context)?.settings ?? '', //settings
            icon: const Icon(Icons.settings),
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          ),
          BottomNavigationBarItem(
            label: AppLocalizations.of(context)?.profile ?? '', //profile
            icon: const Icon(Icons.account_circle),
            // backgroundColor:
            //     Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          ),
        ],
      ),
    );
  }
}

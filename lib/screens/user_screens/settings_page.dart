import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mobile_project/widgets/forward_button.dart';
import 'package:mobile_project/widgets/setting_item.dart';
import 'package:mobile_project/widgets/setting_switch.dart';

import '../../widgets/line_chart_widget.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Settings",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            // const Text(
            //   "Account",
            //   style: TextStyle(
            //     fontSize: 24,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
            // const SizedBox(height: 20),
            // SizedBox(
            //   width: double.infinity,
            //   child: Row(
            //     children: [
            //       const SizedBox(width: 20),
            //       const Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             "User",
            //             style: TextStyle(
            //               fontSize: 18,
            //               fontWeight: FontWeight.w500,
            //             ),
            //           ),
            //           /*SizedBox(height: 10),
            //             Text(
            //               "Youtube Channel",
            //               style: TextStyle(
            //                 fontSize: 14,
            //                 color: Colors.grey,
            //               ),
            //             )*/
            //         ],
            //       ),
            //       const Spacer(),
            //       ForwardButton(
            //         onTap: () {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) => EditAccountScreen(),
            //             ),
            //           );
            //         },
            //       )
            //     ],
            //   ),
            // ),
            //const SizedBox(height: 40),
            // const Text(
            //   "Settings",
            //   style: TextStyle(
            //     fontSize: 24,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
            //const SizedBox(height: 20),
            SettingItem(
              title: "Language",
              icon: Ionicons.earth,
              bgColor: Colors.green.shade50,
              iconColor: Colors.green,
              value: "English",
              onTap: () {},
            ),
            const SizedBox(height: 20),
            SettingItem(
              title: "Notifications",
              icon: Ionicons.notifications,
              bgColor: Colors.blue.shade50,
              iconColor: Colors.blue,
              onTap: () {},
            ),
            const SizedBox(height: 20),
            SettingSwitch(
              title: "Dark Mode",
              icon: Ionicons.moon,
              bgColor: Colors.blueGrey.shade800,
              iconColor: Colors.yellow,
              value: isDarkMode,
              onTap: (value) {
                setState(() {
                  isDarkMode = value;
                });
              },
            ),
            const SizedBox(height: 20),
            SettingItem(
              title: "Help",
              icon: Ionicons.help,
              bgColor: Colors.red.shade50,
              iconColor: Colors.red,
              onTap: () {},
            ),
            const SizedBox(height: 30),
            SettingItem(
                title: "Bağlantı ayarları",
                bgColor: Colors.blue.shade50,
                iconColor: Colors.blue,
                icon: Ionicons.wifi,
                onTap: () {})
          ],
        ),
      ),
    );
  }
}

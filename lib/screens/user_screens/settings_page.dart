import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mobile_project/provider/theme_provider.dart';
import 'package:mobile_project/screens/user_screens/connection_setting_page.dart';
import 'package:mobile_project/widgets/setting_item.dart';
import 'package:mobile_project/widgets/setting_switch.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingItem(
              title: "Bağlantı ayarları",
              bgColor: Colors.blue.shade50,
              iconColor: Colors.blue,
              icon: Ionicons.wifi,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ConnectionSettingsPage()));
              },
              isEditiable: false,
            ),
            const SizedBox(height: 20),
            SettingItem(
              title: "Language",
              icon: Ionicons.earth,
              bgColor: Colors.green.shade50,
              iconColor: Colors.green,
              value: "English",
              onTap: () {},
              isEditiable: false,
            ),
            const SizedBox(height: 20),
            // SettingItem(
            //   title: "Notifications",
            //   icon: Ionicons.notifications,
            //   bgColor: Colors.blue.shade50,
            //   iconColor: Colors.blue,
            //   onTap: () {},
            //   isEditiable: false,
            // ),
            // const SizedBox(height: 20),
            SettingSwitch(
              title: "Dark Mode",
              icon: Ionicons.moon,
              bgColor: Colors.blueGrey.shade800,
              iconColor: Colors.yellow,
              value: themeProvider.isDarkMode,
              onTap: (value) {
                final provider = Provider.of<ThemeProvider>(context, listen: false);
                provider.toggleTheme(value);
              },
            ),
            const SizedBox(height: 20),
            SettingItem(
              title: "Help",
              icon: Ionicons.help,
              bgColor: Colors.red.shade50,
              iconColor: Colors.red,
              onTap: () {},
              isEditiable: false,
            ),
          ],
        ),
      ),
    );
  }
}

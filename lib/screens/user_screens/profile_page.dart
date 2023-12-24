import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mobile_project/auth/screens/login_page.dart';
import 'package:mobile_project/auth/service/auth_service.dart';
import 'package:mobile_project/service/firestore_service.dart';
import 'package:mobile_project/widgets/edit_item.dart';
import 'package:mobile_project/widgets/info_card.dart';

import '../../widgets/line_chart_widget.dart';
import '../../widgets/setting_item.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FireStoreService fireStoreService = FireStoreService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  AuthService authService = AuthService();

  bool isEditing = false;

  Future<void> _signOut() async {
    try {
      authService.signOut();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ));
    } catch (e) {
      debugPrint('Oturum kapatma hatası: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                      radius: 40,
                      child: Icon(
                        Icons.account_box,
                        size: 40,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Account",
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              isEditing = !isEditing;
                            });
                          },
                          icon: const Icon(Icons.edit))
                    ],
                  ),
                  SizedBox(height: 1),
                  const Text(
                    "user name",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
            // Card(
            //   color: Colors.white,
            //   child: Padding(
            //     padding:
            //         const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            //     child: TextField(
            //       controller: _nameController,
            //       decoration: InputDecoration(
            //         prefixIcon: Icon(Icons.account_circle),
            //         border: InputBorder.none,
            //         suffixIcon: isEditing
            //             ? IconButton(
            //                 onPressed: () {},
            //                 icon: Icon(Icons.arrow_right_sharp),
            //               )
            //             : null,
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 16),
            InfoCard(
              title: 'Mehmet Çopur',
              controller: _nameController,
              bgColor: Colors.grey.shade100,
              iconColor: Colors.black,
              icon: Icons.account_circle,
              onTap: () {},
              isEditing: isEditing,
            ),
            const SizedBox(height: 16),
            InfoCard(
              title: 'mehmet.copur@agu.edu.tr',
              controller: _emailController,
              bgColor: Colors.grey.shade100,
              iconColor: Colors.black,
              icon: Icons.email,
              onTap: () {},
              isEditing: isEditing,
            ),
            const SizedBox(height: 16),
            const EditItem(
              title: "Name",
              widget: TextField(
                decoration:
                    InputDecoration(prefixIcon: Icon(Icons.account_circle)),
              ),
            ),
            const SizedBox(height: 30),
            const EditItem(
              widget: TextField(),
              title: "Change Email",
            ),
            const SizedBox(height: 30),
            const EditItem(
              widget: TextField(),
              title: "Change Password",
            ),
            const SizedBox(height: 30),
            const EditItem(
              widget: TextField(),
              title: "Change Phone Number",
            ),
            const SizedBox(height: 30),
            SettingItem(
              title: "Delete Account",
              icon: Icons.delete,
              bgColor: Colors.red.shade50,
              iconColor: Colors.red,
              onTap: () {},
            ),
            const SizedBox(height: 30),
            SettingItem(
              title: "log out",
              icon: Ionicons.log_out,
              bgColor: Colors.blue.shade50,
              iconColor: Colors.blue,
              onTap: _signOut,
            ),
          ],
        ),
      ),
    );
  }
}

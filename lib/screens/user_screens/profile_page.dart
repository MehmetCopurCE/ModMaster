import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mobile_project/auth/screens/forgot_password_page.dart';
import 'package:mobile_project/auth/screens/login_page.dart';
import 'package:mobile_project/auth/service/auth_service.dart';
import 'package:mobile_project/screens/auth_check.dart';
import 'package:mobile_project/service/firestore_service.dart';
import 'package:mobile_project/utils/constants.dart';
import 'package:mobile_project/widgets/edit_item.dart';
import 'package:mobile_project/widgets/info_card.dart';
import '../../widgets/setting_item.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService authService = AuthService();
  FireStoreService fireStoreService = FireStoreService();
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  // final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();
  // final TextEditingController _phoneController = TextEditingController();

  bool isEditing = false;
  Map<String, dynamic> userDetails = {}; // Move userDetails here
  // User? _currentUser; // Define _currentUser as nullable

  Future<void> showEditDialog(String fieldName, String currentValue) async {
    TextEditingController _editingController =
        TextEditingController(text: currentValue);
    try {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('${AppLocalizations.of(context)!.edit} $fieldName'),
            content: TextField(
              controller: _editingController,
              decoration: InputDecoration(
                  hintText: '${AppLocalizations.of(context)!.edit} $fieldName'),
            ),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Cancel button
                },
                child: Text(
                  AppLocalizations.of(context)?.cancel ?? '',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium!.color),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Update the field in Firestore and Firebase Authentication
                  if (fieldName == AppLocalizations.of(context)?.display) {
                    await fireStoreService.updateUserDetails(
                        userDetails['email'],
                        {'displayName': _editingController.text});
                    print('User displayName changed successfully!');
                  } else if (fieldName == AppLocalizations.of(context)?.email) {
                    // // Update email in Firestore
                    // await fireStoreService.updateUserDetails(userDetails['email'], {'email': _editingController.text});
                    // authService.signOut();
                  } else if (fieldName ==
                      AppLocalizations.of(context)?.phoneNum) {
                    await fireStoreService.updateUserDetails(
                        userDetails['email'],
                        {'phoneNumber': _editingController.text});
                    print('Phone number changed Successfully!');
                  }

                  // Refresh the UI with the updated user details
                  setState(() {
                    userDetails[fieldName] = _editingController.text;
                  });

                  Navigator.of(context).pop(); // Save button
                },
                child: Text(
                  AppLocalizations.of(context)?.save ?? '',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium!.color),
                ),
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Handle errors here, you can show a message to the user
      print('Error: $e');
      // Show a snackbar or some other user-friendly message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//Text('${AppLocalizations.of(context)!.edit} $fieldName'),
        content: Text('${AppLocalizations.of(context)!.errMsg} $e'),
      ));
    }
  }

  Future<Map<String, dynamic>> getUserDetails() async {
    final email = await secureStorage.read(key: Constants.userEmail) ?? '';
    final user = await fireStoreService.getUserDetailsByEmail(email);
    return user;
  }

  Future<void> _signOut() async {
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              AppLocalizations.of(context)?.logOut ?? '',
              textAlign: TextAlign.center,
            ),
            content: Text(
              AppLocalizations.of(context)?.logoutConfirmation ?? '',
              textAlign: TextAlign.center,
            ),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  AppLocalizations.of(context)?.cancel ?? '',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium!.color),
                ),
              ),
              //TODO ekleme işlemleri burada yapılacak
              ElevatedButton(
                onPressed: () {
                  authService.signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const AuthCheck()));
                },
                child:
                    //TODO buraya çıkış yap yazılacak

                    Text(
                  AppLocalizations.of(context)?.logOut ?? ' ',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium!.color),
                ),
              ),
            ],
          );
        },
      );
    } catch (e) {
      debugPrint('Oturum kapatma hatası: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: getUserDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Veri yüklenene kadar gösterilecek widget
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Hata durumunda gösterilecek widget
          return Center(
            child: Text(AppLocalizations.of(context)?.errMsg ??
                'Error occurred: ${snapshot.error}'),
          );
        } else {
          userDetails = snapshot.data ?? {}; // Update userDetails here
          // _currentUser = FirebaseAuth.instance.currentUser; // Get the current user

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 60,
                    foregroundImage:
                        AssetImage('assets/images/img_user_woman.png'),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    userDetails['email'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  // const SizedBox(height: 16),
                  // const Text(
                  //   "User Information",
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  //   textAlign: TextAlign.center,
                  // ),
                  const SizedBox(height: 30),
                  SettingItem(
                    title: userDetails['displayName'],
                    icon: Icons.account_circle,
                    bgColor: Colors.blue.shade50,
                    iconColor: Colors.blue,
                    onTap: () {
                      showEditDialog(
                          'Display Name', userDetails['displayName']);
                    },
                    isEditiable: true,
                  ),
                  // const SizedBox(height: 30),
                  // SettingItem(
                  //   title: userDetails['email'],
                  //   icon: Icons.email,
                  //   bgColor: Colors.blue.shade50,
                  //   iconColor: Colors.blue,
                  //   onTap: () {
                  //     //showEditDialog('email', userDetails['email']);
                  //   },
                  //   //isEditiable: true,
                  //   isEditiable: true,
                  // ),
                  // const SizedBox(height: 30),
                  // SettingItem(
                  //   title: userDetails['password'],
                  //   icon: Icons.password_rounded,
                  //   bgColor: Colors.blue.shade50,
                  //   iconColor: Colors.blue,
                  //   onTap: () {},
                  //   isEditiable: true,
                  // ),
                  const SizedBox(height: 30),
                  SettingItem(
                    title: userDetails['phoneNumber'],
                    icon: Icons.phone,
                    bgColor: Colors.blue.shade50,
                    iconColor: Colors.blue,
                    onTap: () {
                      showEditDialog(
                          'Phone Number', userDetails['phoneNumber']);
                    },
                    isEditiable: true,
                  ),
                  const SizedBox(height: 30),
                  SettingItem(
                    title: AppLocalizations.of(context)?.changePass ?? ' ',
                    icon: Icons.password_sharp,
                    bgColor: Colors.blue.shade50,
                    iconColor: Colors.blue,
                    onTap: () {
                      // showPasswordChangeDialog();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ForgotPasswordPage()));
                    },
                    isEditiable: false,
                  ),
                  const SizedBox(height: 30),
                  SettingItem(
                    title: AppLocalizations.of(context)?.delAccSure ?? ' ',
                    icon: Icons.delete,
                    bgColor: Colors.red.shade50,
                    iconColor: Colors.red,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              AppLocalizations.of(context)?.delAccSure ?? '',
                              textAlign: TextAlign.center,
                            ),
                            content: Text(
                                AppLocalizations.of(context)?.deleteAccount ??
                                    ''),
                            //Text('Do you want to delete your account?'),
                            actionsAlignment: MainAxisAlignment.spaceBetween,
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  AppLocalizations.of(context)?.cancel ??
                                      'Cancel',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .color),
                                ),
                              ),
                              //TODO ekleme işlemleri burada yapılacak
                              ElevatedButton(
                                onPressed: () {
                                  authService.deleteUser(userDetails['email']);
                                  authService.signOut();
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) => AuthCheck(),
                                  ));
                                },
                                child: Text(
                                  AppLocalizations.of(context)?.deleteStr ??
                                      ' ',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .color),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    isEditiable: false,
                  ),
                  const SizedBox(height: 30),
                  SettingItem(
                      isEditiable: false,
                      title: AppLocalizations.of(context)?.logOut ?? ' ',
                      icon: Ionicons.log_out,
                      bgColor: Colors.blue.shade50,
                      iconColor: Colors.blue,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                AppLocalizations.of(context)?.logOut ?? '',
                                textAlign: TextAlign.center,
                              ),
                              content: Text(AppLocalizations.of(context)
                                      ?.logoutConfirmation ??
                                  ''),
                              actionsAlignment: MainAxisAlignment.spaceBetween,
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)?.cancel ??
                                        'Cancel',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .color),
                                  ),
                                ),
                                //TODO ekleme işlemleri burada yapılacak
                                ElevatedButton(
                                  onPressed: () {
                                    //authService.deleteUser(userDetails['email']);
                                    authService.signOut();
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (context) => AuthCheck(),
                                    ));
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)?.logOut ?? ' ',

                                    //TODO buraya sil yazılacak

                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .color),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                        //   onTap: _signOut,
                        //   isEditiable: false,
                      }),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

//TODO password yenileme işlemleri yapılacak
  // Future<void> showPasswordChangeDialog() async {
  //   TextEditingController _passwordController = TextEditingController();

  //   await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Change Password'),
  //         content: TextField(
  //           controller: _passwordController,
  //           obscureText: true,
  //           decoration: const InputDecoration(
  //             hintText: 'Enter new password',
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop(); // Cancel button
  //             },
  //             child: Text('Cancel'),
  //           ),
  //           TextButton(
  //             onPressed: () async {
  //               // Güncelleme işlemini başlat
  //               //await authService.updatePassword(_passwordController.text);
  //               // await authService.resetPassword(_passwordController.text);
  //               // Kullanıcıya başarı mesajı göster
  //               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //                 content: Text('Password changed successfully!'),
  //               ));

  //               Navigator.of(context).pop(); // Save button
  //             },
  //             child: Text('Save'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

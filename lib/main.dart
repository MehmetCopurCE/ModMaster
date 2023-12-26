import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/data/register_list.dart';
import 'package:mobile_project/service/database_service.dart';
import 'package:mobile_project/screens/auth_check.dart';
import 'package:mobile_project/service/firestore_service.dart';
import 'package:mobile_project/service/register_service.dart';
import 'firebase_options.dart';
import 'screens/main_page.dart';
import 'screens/user_screens/home_page.dart';

//DatabaseService databaseService = DatabaseService();
FireStoreService fireStoreService = FireStoreService();
RegisterService registerService = RegisterService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  //databaseService.syncData();
  //fireStoreService.addRegistersToFirestore(registerList);
  registerService.getRegisterNames(registerList);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AuthCheck(),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_project/models/write_register.dart';
import 'package:mobile_project/provider/register_provider.dart';
import 'package:mobile_project/screens/user_screens/register_detail_page.dart';
import 'package:mobile_project/service/register_service.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

List<WriteRegister> writeRegisters = [];

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final TextEditingController _newValueController = TextEditingController();
  Uuid uuid = const Uuid();

  void writeNewValue(
      String registerAddress, TextEditingController controller) async {
    String id = uuid.v4();
    int enteredValue = int.parse(controller.text);
    int index = int.parse(registerAddress) - 400000;
    print('Register Address : $index');
    final newWrite =
        WriteRegister(id: id, registerAddress: index, newValue: enteredValue);
    setState(() {
      writeRegisters.add(newWrite);
      print('WriteRegisters a eklendi. ');
    });
    FocusScope.of(context).unfocus();
    Timer(Duration(seconds: 1), () {
      controller.text = "";
    });
  }

  @override
  void dispose() {
    _newValueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    
    final registerValues = ref.watch(registerProvider);

    if (registerValues.isEmpty)
      return Center(
        child: CircularProgressIndicator(),
      );

    return ListView.builder(
      itemCount: registerList.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 5,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: const BorderSide(
              color: Colors.black,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            // tileColor: Colors.white,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RegisterDetailPage(
                  registerName: registerList[index].registerName,
                ),
              ));
            },
            title: Row(
              children: [
                Text(
                  registerList[index].registerName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                // const SizedBox(width: 8), // Küçük bir boşluk ekledik
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    registerValues[index].toString(),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ],
            ),
            trailing: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      // TO DO
                      // title:
                      //  title: Text(AppLocalizations.of(context)!.helloWorld),
                      //Text(
                      // '${AppLocalizations.of(context)!.newValMsg} ${registerList[index].registerName}',),
//

                      title: Text(
                        '${registerList[index].registerName} ${AppLocalizations.of(context)!.newValMsg}'

                      ),

                      content: TextField(
                        controller: _newValueController,
                        decoration: InputDecoration(
                          suffixText:
                              AppLocalizations.of(context)?.enterNewVal ?? '',
                        ),
                        // onChanged: (value) {},
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(AppLocalizations.of(context)?.cancel ?? '')
                        ),
                        //TODO ekleme işlemleri burada yapılacak
                        TextButton(
                          onPressed: () {
                            writeNewValue(registerList[index].registerAddress,
                                _newValueController);
                          },
                          child: Text(AppLocalizations.of(context)?.add ?? ''),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).brightness == Brightness.light
                    ? const Color(0xFF9B59B6)
                    : const Color(0xFF9B59B6).withOpacity(0.5),
              ),
              child: Text(AppLocalizations.of(context)?.add ?? '',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        );
      },
    );
    // return ListView.builder(
    //   itemCount: registerList.length,
    //   itemBuilder: (context, index) {
    //     return Card(
    //       elevation: 5, // Set the elevation for a card effect
    //       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    //       color: Colors.grey[200],
    //       child: ListTile(
    //         title: Text(
    //           registerList[index].registerName,
    //           style: TextStyle(
    //             fontWeight: FontWeight.bold,
    //             fontSize: 16,
    //           ),
    //         ),
    //         trailing: Text(
    //           registerValues[index].toString(),
    //           style: TextStyle(
    //             fontWeight: FontWeight.bold,
    //             fontSize: 16,
    //           ),
    //         ),
    //         onTap: () {
    //           Navigator.of(context).push(MaterialPageRoute(
    //             builder: (context) => RegisterDetailPage(
    //               registerName: registerList[index].registerName,
    //             ),
    //           ));
    //         },
    //       ),
    //     );
    //   },
    // );
  }
}

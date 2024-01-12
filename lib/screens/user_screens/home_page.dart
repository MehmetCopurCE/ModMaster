import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_project/provider/register_provider.dart';
import 'package:mobile_project/screens/user_screens/register_detail_page.dart';
import 'package:mobile_project/service/register_service.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerValues = ref.watch(registerProvider);

    if (registerValues.isEmpty)
      return Center(
        child: CircularProgressIndicator(),
      );
    return ListView.builder(
      itemCount: registerList.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 5, // Set the elevation for a card effect
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Colors.grey[200],
          child: ListTile(
            title: Text(
              registerList[index].registerName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            trailing: Text(
              registerValues[index].toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RegisterDetailPage(
                  registerName: registerList[index].registerName,
                ),
              ));
            },
          ),
        );
      },
    );
  }
}

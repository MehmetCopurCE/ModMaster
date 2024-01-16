import 'package:flutter/material.dart';
import 'package:mobile_project/screens/user_screens/my_chart.dart';
import 'package:mobile_project/service/register_service.dart';

class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  // List<String> nameList = ['John', 'Jane', 'Doe', 'Alice', 'Bob'];
  Map<String, bool> isOpenMap = {};
  //   onTap: () {
  //   setState(() {
  //     isOpenMap[registerList[index].registerName] = !(isOpenMap[registerList[index].registerName] ?? false);
  //   });
  // },

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: registerList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      side: const BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            registerList[index].registerName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          trailing: Icon(
                            isOpenMap[registerList[index].registerName] ?? false ? Icons.arrow_drop_up_sharp : Icons.arrow_drop_down_sharp,
                            size: 30,
                          ),
                          onTap: () {
                            setState(() {
                              isOpenMap[registerList[index].registerName] = !(isOpenMap[registerList[index].registerName] ?? false);
                            });
                          },
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 0),
                          height: isOpenMap[registerList[index].registerName] ?? false ? 350 : 0,
                          //color: Colors.blue,
                          // child: Center(
                          //   child: Text(
                          //     registerList[index].registerName,
                          //     style: TextStyle(color: Colors.white, fontSize: 18),
                          //   ),
                          // ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MyChart(registerName: registerList[index].registerName),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // AnimatedContainer(
                  //   duration: Duration(milliseconds: 0),
                  //   height: isOpenMap[registerList[index].registerName] ?? false ? 400 : 0,
                  //   //color: Colors.blue,
                  //   // child: Center(
                  //   //   child: Text(
                  //   //     registerList[index].registerName,
                  //   //     style: TextStyle(color: Colors.white, fontSize: 18),
                  //   //   ),
                  //   // ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Card(elevation: 2, child: MyChart(registerName: registerList[index].registerName)),
                  //   ),
                  // ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

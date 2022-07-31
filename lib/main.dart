import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sqflite_app/UI/theme.dart';
import 'package:sqflite_app/Widget/textFomrfield.dart';
import 'package:sqflite_app/conne.dart';
import 'package:sqflite_app/list_user.dart';
import 'package:sqflite_app/userdata.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      themeMode: ThemeMode.light,
      darkTheme: Themes.dark,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  TextEditingController controllerTire = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  final _fromkey = GlobalKey<FormState>();
  //late String_base65Image;
  //File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Center(
            child: Text(
          'SQFLITE DATABASE',
          style: TextStyle(color: Colors.black),
        )),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //logo
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey,
            ),

            textFormfield(
              Namecontroller: controllerTire,
              title: 'Input Tire:',
              hint: 'Tire',
            ),
            textFormfield(
                Namecontroller: controllerPrice,
                title: 'Input Price:',
                hint: 'Price'),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        if (_fromkey.currentState!.validate()) {
                          await ConnectionDB()
                              .insertUser(User(
                                  id: Random().nextInt(100),
                                  tire: controllerTire.text.trim(),
                                  price: controllerPrice.text.trim()))
                              .whenComplete(
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ListUserPage(),
                                  ),
                                ),
                              );
                          print('insert success');
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Processing Data Insert'),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Processing Data Insert'),
                          ));
                        }
                      },
                      child: const Text('Save')),
                  const SizedBox(width: 20),
                  ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ListUserPage()))
                            .whenComplete(() => this);
                      },
                      child: const Text('Show Data')),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     margin: const EdgeInsets.only(left: 10, right: 10),
            //     height: 300,
            //     width: double.infinity,
            //     color: Colors.grey,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

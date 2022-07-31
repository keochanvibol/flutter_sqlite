import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sqflite_app/UpdatePage.dart';
import 'package:sqflite_app/userdata.dart';
import 'package:sqflite_app/list_user.dart';
import 'conne.dart';

class ListUserPage extends StatefulWidget {
  const ListUserPage({Key? key}) : super(key: key);

  @override
  State<ListUserPage> createState() => _ListUserPageState();
}

class _ListUserPageState extends State<ListUserPage> {
  late ConnectionDB db;
  late Future<List<User>> _list;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onRefresh();
    db = ConnectionDB();
    db.initializeDB().whenComplete(() async {
      setState(() {
        _list = db.getUser();
      });
    });
  }

  Future<void> _onRefresh() async {
    setState(() {
      _list = getList();
      Future.delayed(const Duration(seconds: 5));
    });
  }

  Future<List<User>> getList() async {
    return await db.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List User'),
      ),
      body: FutureBuilder<List<User>>(
        future: _list,
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Icon(
                Icons.info,
                color: Colors.red,
              ),
            );
          } else {
            final items = snapshot.data ?? <User>[];
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                      ),
                      key: ValueKey<int>(items[index].id),
                      onDismissed: (DismissDirection direc) async {
                        await ConnectionDB().deleteUser(items[index].id);
                      },
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UpdatePage()),
                            );
                          });
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(items[index].tire),
                          ),
                        ),
                      ),
                    );
                  }),
            );
          }
        },
      ),
    );
  }
}

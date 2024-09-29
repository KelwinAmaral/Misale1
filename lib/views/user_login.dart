import 'package:misale/components/user_tile.dart';
import 'package:misale/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:misale/provider/users.dart';

class UserLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Loguin'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.user_list);
                },
                icon: const Icon(Icons.add)),
          ],
        )
    );



  }
}



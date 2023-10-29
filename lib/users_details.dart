import 'package:flutter/material.dart';
import 'package:httpreq/users_model.dart';

class UserDetail extends StatelessWidget {
  final Data userData;

  UserDetail({required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail User ${userData.id}'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 25),
            Image.network(userData.avatar!),
            Text('Name: ${userData.firstName} ${userData.lastName}'),
            Text('Email: ${userData.email}'),
          ],
        ),
      ),
    );
  }
}

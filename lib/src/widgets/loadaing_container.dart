import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  Widget build(context) {
    return Column(
      children: [
        ListTile(
          title: buildContainer(),
          subtitle: buildsubs(),
        ),
        Divider(height: 8.0),
      ],
    );
  }

  Widget buildContainer() {
    return Container(
      color: Colors.grey[200],
      height: 24.0,
      width:150.0,
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0)
    );
  }
  Widget buildsubs() {
    return Container(
      color: Colors.grey[200],
      height: 24.0,
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 300.0)
    );
  }
}
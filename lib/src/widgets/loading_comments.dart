import 'package:flutter/material.dart';

class LoadingComments extends StatelessWidget {
  Widget build(context) {
    return Column(
      children: [
        ListTile(
          title: buildContainer(),
          subtitle: buildAuthor(),
        ),
        Divider(height: 8.0),
      ],
    );
  }

  Widget buildContainer() {
    return Container(
      color: Colors.grey[200],
      height: 60.0,
      width:150.0,
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0)
    );
  }
  Widget buildAuthor() {
    return Container(
      color: Colors.grey[200],
      height: 10.0,
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 300.0)
    );
  }
}
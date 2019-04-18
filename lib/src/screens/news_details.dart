import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import '../blocs/comments_provider.dart';
import '../models/item_model.dart';
import '../widgets/comment.dart';

class NewsDetails extends StatelessWidget {
  final int itemId;

  NewsDetails({this.itemId});

  Widget build(context) {
    final bloc = CommentsProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        backgroundColor: Colors.deepOrange,
      ),
      body: buildBody(bloc),
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          print('${snapshot.data[itemId]}');
          return Text('');
        }

        final itemFuture = snapshot.data[itemId];

        return FutureBuilder(
            future: itemFuture,
            builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
              if (!itemSnapshot.hasData) {
                return Text('');
              }

              return buildList(itemSnapshot.data, snapshot.data);
            });
      },
    );
  }

  Widget buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    final children = <Widget>[];
    children.add(buildTitle(item));
    children.add(urlSite(item));
    children.add(buildText());
    final commentList = item.kids.map((kidId) {
      return Comment(itemId: kidId, itemMap: itemMap, depth: 0);
    }).toList();
    children.addAll(commentList);

    return ListView(
      children: children,
    );
  }

  launcher(ItemModel item) async {
    final itemUrl = item.url;
    if (await canLaunch(itemUrl)) {
      launch(itemUrl);
    } else {
      throw 'Could not launch $itemUrl';
    }
  }

  Widget buildTitle(ItemModel item) {
    return Container(
      margin: EdgeInsets.all(10.0),
      alignment: Alignment.topCenter,
      child: Text(
        item.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildText() {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Text(
        'Comments',
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget urlSite(ItemModel item) {
    return ListTile(
      onTap: () {
        launcher(item);
      },
      title: Text(
        'Visit story url',
        style: TextStyle(
            fontSize: 15.0, color: Colors.red, fontWeight: FontWeight.bold),
      ),
    );
  }
}

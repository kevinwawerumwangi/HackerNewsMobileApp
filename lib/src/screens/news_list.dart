import 'package:flutter/material.dart';
import 'dart:async';
import '../blocs/stories_provider.dart';
import '../widgets/new_list_tile.dart';
import '../widgets/refresh.dart';


class NewsList extends StatelessWidget {
  Widget build(context) {
    final bloc = StoriesProvider.of(context);
    return  Scaffold(
      appBar: AppBar(
        title: Text('Hackers News'),
        backgroundColor: Colors.deepOrange,

      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.deepOrange,
            ),
          );
        }

    return Refresh(
      child: ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (context, int index) {
          bloc.fetchItem(snapshot.data[index]);
          
          return NewsListTile(
            itemId: snapshot.data[index]
            );
          },
        ),
    );     
    
      },
    );
  }
 
}

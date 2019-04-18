import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'blocs/stories_provider.dart';
import 'screens/news_details.dart';
import 'blocs/comments_provider.dart';

class App extends StatelessWidget {
  
  Widget build(context) {
    return CommentsProvider(
      child: StoriesProvider (
        child: MaterialApp(
          onGenerateRoute: routes,
        ),
      ),
    );
  }
  Route routes(RouteSettings settings) {

    if(settings.name == '/') {
      return MaterialPageRoute(
      builder: (context) {
        final bloc = StoriesProvider.of(context);   

        bloc.fetchTopIds();    
        return NewsList();
      }
    );
    } else {
       return MaterialPageRoute(
        builder: (context) {
          final commentsBloc = CommentsProvider.of(context);
          final itemId = int.parse(settings.name.replaceFirst('/', ''));

          commentsBloc.fetchItemWithComments(itemId);
          
          return NewsDetails(
            itemId: itemId,
          );
        }
       ); 
    }
    


  }
}
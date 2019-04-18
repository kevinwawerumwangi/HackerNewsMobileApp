import 'package:news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  
  //setup of test case
  test('FetchTopIds returns a list of ids', () async {
    NewsApiProvider newsApi = new NewsApiProvider();
    
    newsApi.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });

  //expectations
    final ids = await newsApi.fetchTopIds();

    expect(ids, [1, 2, 3, 4]);

  });

  //setup of test case  
  test('FetchItem return a item model', () async{
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      final jsonMap = {'id':123};
      return Response(json.encode(jsonMap), 200);
  
    });
  //expectations
    final item = await newsApi.fetchItem(999);

    expect(item.id, 123);
  });
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/search_api.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News App"),
      ),
      body: FutureBuilder<ArticleDataModel?>(
          future: getArticleData(),
          builder: (_,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }else if(snapshot.hasError){
              return Center(child: Text("Error: ${snapshot.error.toString()}"),);
            }else if(snapshot.hasData){
              return snapshot.data != null ?
              snapshot.data!.articles!.isNotEmpty ?
              ListView.builder(
                  itemCount: snapshot.data!.articles!.length,
                  itemBuilder: (_,index){
                    return ListTile(
                      title: Text(snapshot.data!.articles![index].title!),

                    );
                  }) :
              Center(child: Text('No News Yet!!'),) :
                  Center(child: Container(),);
            }
            return Container();
      }

      ),
    );
  }
}


Future<ArticleDataModel?> getArticleData() async {

  String url = "https://newsapi.org/v2/everything?q=bitcoin&apiKey=4b3dc62b14414a58b793058199e563e5";
  Uri uri = Uri.parse(url);
  http.Response res = await http.get(uri);

  if(res.statusCode == 200){
    print("Response body = ${res.body}");
    var resData =  jsonDecode(res.body);
    return ArticleDataModel.fromJson(resData);
  }else{
    return null;
  }

}
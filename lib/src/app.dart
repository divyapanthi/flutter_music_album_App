import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:music_album/widgets/music_list_widget.dart';
import 'models/music_response_model.dart';
import 'package:fluttertoast/fluttertoast.dart';



class App extends StatefulWidget{
  @override
  AppState createState() {
    return AppState();
  }
}


class AppState extends State<App>{

  int counter = 0;
  List<MusicResponseModel> musicList = [];

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),

      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Albums"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            fetchAlbum();
          },
          child: Icon(Icons.add),
        ),
        body: MusicListWidget(musicList),
      ),
    );
  }

  void fetchAlbum() async {
    counter++;
    var uri = Uri.parse("https://api.fresco-meat.com/api/albums/$counter");
    var response = await get(uri);
    var body = response.body;
    var parsedMap = jsonDecode(body);

    var albumModel = MusicResponseModel.fromMap(parsedMap);

    if (counter<=5){
      setState(() {
        musicList.add(albumModel);// todo force UI rebuild
      });
    }
    else{
      Fluttertoast.showToast(
          msg: "No more Albums.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.deepOrange,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

  }


}
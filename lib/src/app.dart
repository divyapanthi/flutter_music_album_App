import 'dart:convert';

import 'package:flutter/cupertino.dart';
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
        primarySwatch: Colors.teal,
      ),

      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Music Albums"),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            fetchAlbum();
          },
          label: const Text("Add New Album"),
          icon: Icon(Icons.music_note),
          // backgroundColor: Colors.green,
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
          backgroundColor: Colors.amber,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

  }


}
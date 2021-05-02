import 'package:flutter/material.dart';
import 'package:music_album/src/models/music_response_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';


class MusicListWidget extends StatelessWidget {
  final List<MusicResponseModel> musicList;

  MusicListWidget(this.musicList);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (BuildContext context, int index){
          return buildEachItem(musicList[index]);
        },
      itemCount: musicList.length,
    );
  }


  Widget buildEachItem(MusicResponseModel musicResponseModel){
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                child: Container(
                  margin: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Image.network(musicResponseModel.thumbnail!,
                        width: 60,
                        height: 60,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 12),
                        child: Column(
                          children: [
                            Text(
                                musicResponseModel.title!,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:8),
                              child: Text(musicResponseModel.artist!),
                            ),
                          ]
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Card(child: Image.network(musicResponseModel.image!)),

              Card(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (){
                      checkConnectivity(musicResponseModel.url!);
                    },
                    child: Text("Buy Now"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(16),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),


      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 3,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
      );
  }

  void checkConnectivity(String url) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.mobile)  {
        launchURL(url);
    }
    else {
      Fluttertoast.showToast(
          msg: "Please make sure you have a internet connection.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
   void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
    else {
      throw 'Could not launch $url';
    }
  }






}
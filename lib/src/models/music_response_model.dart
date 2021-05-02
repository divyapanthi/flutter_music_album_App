class MusicResponseModel{
  int? id;
  String? thumbnail;
  String? title;
  String? artist;
  String? image;
  String? url;

  MusicResponseModel(this.id, this.thumbnail, this.title, this.artist,this.image, this.url);

  MusicResponseModel.fromMap(Map<String, dynamic>parsedMap){
    id = parsedMap["id"];
    thumbnail = parsedMap["thumbnail"];
    title = parsedMap["title"];
    artist = parsedMap["artist"];
    image = parsedMap["image"];
    url = parsedMap["url"];
  }
}
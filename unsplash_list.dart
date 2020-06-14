import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:unsplash001/unsplash_data.dart';
import 'package:unsplash001/image_page.dart';

class UnsplashList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UnsplashListState();
  }
}

class UnsplashListState extends State<UnsplashList> {
  List<UnsplashData> data = [];
  String url = 'https://api.unsplash.com/photos/?client_id=cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0';

  //Основной экран
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unsplash viewer'),
      ),
      body: Container(
        child: ListView(
          children: _buildList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () => _loadUnsplash(),
      ),
    );
  }

  //GET запрос и обработка ответа
  _loadUnsplash() async {
    final response = await http.get(url);
    if(response.statusCode == 200){
      //print(response.body);
      final responseData = json.decode(response.body);
      var ccDataList = List<UnsplashData>();
      for(var i=0; i < responseData.length; i++){
        //print(responseData[i]);
        var element = responseData[i];
        print(element);
        var record = UnsplashData(
            author: _nameCheck(element['user']['username']),
            name: _nameCheck(element['description']),
            imgSmall: element['urls']['thumb'],
            imgBig: element['urls']['full']
        );
        ccDataList.add(record);
      }
      setState(() {
        data = ccDataList;
      });
    }
    else {
      print('Response status code != 200');
    }
  }

  //Проверка названия и имени пользователя
  String _nameCheck(name) {
    if (name != null && name.runtimeType == String && name.length > 0){
      if(name.length < 32){
        return name;
      }
      else {
        return name.substring(0, 31) + '...';
      }
    }
    else {
      return 'No name';
    }
  }

  //Список виджетов
  List<Widget> _buildList() {
    return data.map((UnsplashData f) => ListTile(
      subtitle: Text(
        f.author,
        style: TextStyle(
          fontSize: 12.0,
          color: Colors.grey[500],
        ),
      ),
      title: Text(f.name),
      leading: CircleAvatar(backgroundImage: NetworkImage(f.imgSmall)),
      onTap: () {
        //print(f.imgBig);
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ImagePage(
            imgBig: f.imgBig,
            name: f.name,
          )),
        );
      },
    )).toList();
  }

  //Загрузка списка при старте приложения
  @override
  void initState() {
    super.initState();
    _loadUnsplash();
  }
}
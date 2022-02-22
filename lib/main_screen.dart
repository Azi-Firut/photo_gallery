import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:photo_gallery/constant.dart';
import 'package:photo_gallery/image_screen.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageView> {
  late List data;
  List imagesUrl = [];
  @override
  void initState() {
    fetchDataFromApi();
    super.initState();

    //imagesUrl[3] = 'null';
    log(imagesUrl.toString());
  }

  Future<String> fetchDataFromApi() async {
    var jsonData = await http.get(Uri.parse(
        'https://s3-us-west-2.amazonaws.com/appsdeveloperblog.com/tutorials/files/cats.json'));
    //'https://jsonplaceholder.typicode.com/photos'));

    var fetchData = jsonDecode(jsonData.body);
    setState(() {
      data = fetchData;
      for (var element in data) {
        imagesUrl.add(element['url']);
        //log(imagesUrl.toString());
      }
      // log(imagesUrl.toString());
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorGray,
      body: SafeArea(
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            SliverGrid(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ImageScreen(img: imagesUrl[index]),
                        ),
                      );
                    },
                    child: CachedNetworkImage(
                      width: double.infinity,
                      fit: BoxFit.cover,
                      imageUrl: // imagesUrl[index],
                          ((imagesUrl[index]) == null)
                              ? ('https://fonarevka.ua/home/core_themes/item_1/noimage/no_img_600x600.png')
                              : imagesUrl[index],
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: CircularProgressIndicator(
                            strokeWidth: 10,
                            color: Colors.deepOrange,
                            value: downloadProgress.progress),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/images/noimg.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }, childCount: imagesUrl.length),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  childAspectRatio: 1),
            ),
            SliverFixedExtentList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return const Center(
                    child: Text(
                      'end of story :(',
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        color: Colors.deepOrange,
                      ),
                    ),
                  );
                }, childCount: 1),
                itemExtent: 60),
          ],
        ),
      ),
    );
  }
}

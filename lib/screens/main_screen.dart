import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:photo_gallery/constants/constant.dart';
import 'package:photo_gallery/screens/image_screen.dart';

import '../widgets/nav_bar_widget.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageView> {
  late List data;
  List imagesUrl = [];
  late int num = 0;
  final ScrollController _controller = ScrollController();

  void _onScrollEvent() {
    final extentAfter = _controller.position.extentAfter;

    if (extentAfter == 0.0) {
      num = num + 9;
      num = (num > data.length) ? num = data.length : num;
    }
    setState(() {
      num;
    });
  }

  @override
  void initState() {
    fetchDataFromApi();
    _controller.addListener(_onScrollEvent);
    super.initState();
  }

  Future<String> fetchDataFromApi() async {
    var jsonData = await http.get(Uri.parse(kFetchUrl));

    var fetchData = jsonDecode(jsonData.body);

    setState(() {
      data = fetchData;
      if ((data.length < 100)) {
        data = data;
      } else {
        data.removeRange(100, data.length);
      }
      num = (data.length < 18) ? num = data.length : num = 18;
      for (var element in data) {
        imagesUrl.add(element['url']);
      }
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(),
      body: Container(
        decoration: BoxDecoration(gradient: kBgGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 3, right: 3),
            child: CustomScrollView(
              controller: _controller,
              scrollDirection: Axis.vertical,
              slivers: <Widget>[
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: GestureDetector(
                        onTap: () {
                          if ((imagesUrl[index]) == null) {
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ImageScreen(img: imagesUrl[index]),
                              ),
                            );
                          }
                        },
                        child: CachedNetworkImage(
                          width: double.infinity,
                          fit: BoxFit.cover,
                          imageUrl: imagesUrl[index] ?? kNoImageUrl,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: CircularProgressIndicator(
                                strokeWidth: 10,
                                color: kColorOther,
                                value: downloadProgress.progress),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/no_image.png',
                            fit: BoxFit.cover,
                          ),
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: kBoxShadowColor,
                                    offset: Offset(
                                      0.0,
                                      4.0,
                                    ),
                                    blurRadius: 4.0,
                                    spreadRadius: 0.1,
                                  ), //BoxShadow
                                ],
                                image: DecorationImage(
                                    fit: BoxFit.cover, image: imageProvider),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                    );
                  }, childCount: num),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      childAspectRatio: 1),
                ),
                SliverFixedExtentList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return Center(
                        child: Text(
                          kTextEndOfStory.toUpperCase(),
                          textScaleFactor: 1.2,
                          style: const TextStyle(
                            color: kColorOther,
                          ),
                        ),
                      );
                    }, childCount: 1),
                    itemExtent: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

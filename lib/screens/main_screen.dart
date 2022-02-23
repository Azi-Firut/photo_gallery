import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:photo_gallery/constants/constant.dart';
import 'package:photo_gallery/widgets/image_screen.dart';

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
    var jsonData = await http.get(Uri.parse(fetchUrl));

    var fetchData = jsonDecode(jsonData.body);

    setState(() {
      data = fetchData;
      num = (data.length < 15) ? num = data.length : num = 15;

      for (var element in data) {
        imagesUrl.add(element['url']);
      }
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorGray,
      body: SafeArea(
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
                        imageUrl: // imagesUrl[index],
                            ((imagesUrl[index]) == null)
                                ? (noImageUrl)
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
                          'assets/images/no_image.png',
                          fit: BoxFit.cover,
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
      ),
    );
  }
}

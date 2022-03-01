import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:photo_gallery/constants/constant.dart';
import 'package:photo_gallery/widgets/end_of_story_widget.dart';
import 'package:photo_gallery/widgets/picture_widget.dart';
import '../widgets/app_bar_widget.dart';
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
        imagesUrl.add(element[url]);
      }
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        toolbarHeight: -10,
        flexibleSpace: const CustomAppBar(),
      ),
      bottomNavigationBar: const BottomNavBar(),
      body: Container(
        decoration: BoxDecoration(gradient: kBgGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 0),
            child: CustomScrollView(
              controller: _controller,
              scrollDirection: Axis.vertical,
              slivers: <Widget>[
                SliverFixedExtentList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return const SizedBox(height: 15); //5
                    }, childCount: 1),
                    itemExtent: 15),
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return PictureGrid(index: index, imagesUrl: imagesUrl);
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
                      return const EndOfStory();
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

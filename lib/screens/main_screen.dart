import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:photo_gallery/constants/constant.dart';
import 'package:photo_gallery/widgets/end_of_story_widget.dart';
import 'package:photo_gallery/widgets/picture_widget.dart';
//import '../data/fetch_api.dart';
//import '../domain/scroll_event.dart';
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
      backgroundColor: kAllBarColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.red,
          elevation: 0,
          toolbarHeight: 0,
          flexibleSpace: const CustomAppBar(),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.only(
          left: 6,
          right: 6,
          top: 0,
        ),
        decoration: BoxDecoration(gradient: kBgGradient),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          controller: _controller,
          scrollDirection: Axis.vertical,
          children: [
            const SizedBox(height: 5),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: num,
              shrinkWrap: true, // false, infinite size error
              itemBuilder: (BuildContext context, int index) {
                return PictureGrid(
                  imagesUrl: imagesUrl[index],
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
            ),
            const EndOfStory(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(34);
}

import 'package:flutter/material.dart';

//   Text
const kTextEndOfStory = 'end of story';
//  Colors
const kNavBarColor = Color(0xFF242424);
const kButtonColor = Color(0xFF242424);
const kBoxShadowColor = Color(0xFF000000);
const kColorOther = Color(0xFFD0D0D0);
var kBgGradient = const LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: [
    0.0,
    0.4,
    0.8,
    1.0,
  ],
  colors: [
    Color(0xFF242424),
    Color(0xFF181818),
    Color(0xFF242424),
    Color(0xFF242424),
  ],
);
//  Fetch Url
const kFetchUrl =
    // 'https://s3-us-west-2.amazonaws.com/appsdeveloperblog.com/tutorials/files/cats.json';
    'https://jsonplaceholder.typicode.com/photos';
// Image
const kNoImageUrl =
    'https://fonarevka.ua/home/core_themes/item_1/noimage/no_img_600x600.png';

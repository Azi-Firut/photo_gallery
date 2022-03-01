import 'package:flutter/material.dart';

//   Text
const kTextEndOfStory = 'end of story';
//  Colors
const kAllBarColor = Color(0xFF313F49); //0xFF263139
const kButtonColor = Color(0xFF313F49);
const kBoxShadowColor = Color(0x8B000000);
const kColorOther = Color(0xFFD0D0D0);
var kBgGradient = const LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: [
    0.25,
    0.5,
    0.75,
    1.0,
  ],
  colors: [
    Color(0xFF313F49),
    Color(0xFF20292F),
    Color(0xFF20292F),
    Color(0xFF313F49),
  ],
);
//  Fetch Url
const url = 'download_url'; // url // download_url // use this key
const kFetchUrl =
    // 'https://raw.githubusercontent.com/Zifirut/photo_gallery/master/photo.json'; // OWN Json
    'https://picsum.photos/v2/list?page=2&limit=100'; //  use url = 'download_url';
//'https://s3-us-west-2.amazonaws.com/appsdeveloperblog.com/tutorials/files/cats.json'; // cats
//'https://jsonplaceholder.typicode.com/photos'; // 1000 img
// Image
const kNoImageUrl =
    'https://fonarevka.ua/home/core_themes/item_1/noimage/no_img_600x600.png';

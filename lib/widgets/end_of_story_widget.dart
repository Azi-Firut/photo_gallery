import '../constants/constant.dart';
import 'package:flutter/material.dart';

class EndOfStory extends StatelessWidget {
  const EndOfStory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 15, top: 5),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            minimumSize: const Size(double.infinity - 6, 40),
            elevation: 7,
            primary: kButtonColor,
          ),
          onPressed: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                kTextEndOfStory.toUpperCase(),
                textScaleFactor: 1.2,
                style: const TextStyle(
                  color: kColorOther,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              const Icon(
                Icons.yard_outlined,
                size: 24.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

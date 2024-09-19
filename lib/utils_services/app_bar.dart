import 'package:flutter/material.dart';
import 'app_font.dart';
class AppBarCustom extends StatelessWidget {
  AppBarCustom({this.title,this.leading,this.trailing});

  final String? title;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: const BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.only(
          //   bottomLeft: Radius.circular(20),
          //   bottomRight: Radius.circular(20),
          // )
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
         // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50,
              child: leading,
            ),
            Align(
                alignment: Alignment.center,
                child: Text(
                  title!,
                  style: TextStyle(
                //fontFamily: AppFonts.segoeui,
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                )),
            Container(
              child: trailing,
            ),
            //Icon(Icons.more_vert),
          ],
        ),
      ),
    );
  }
}
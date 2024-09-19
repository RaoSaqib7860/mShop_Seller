import 'package:cached_network_image/cached_network_image.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ViewReceivedImage extends StatefulWidget {
  String? image;
  ViewReceivedImage({Key? key, this.image}) : super(key: key);

  @override
  State<ViewReceivedImage> createState() => _ViewReceivedImageState();
}

class _ViewReceivedImageState extends State<ViewReceivedImage> {
  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      onDismissed: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ))),
        body: Container(
          height: 100.h,
          width: 100.w,
          child: Center(
              child: Container(
            height: 30.h,
            child: CachedNetworkImage(
              imageUrl: "${widget.image}",
              placeholder: (context, url) => Container(
                color: Colors.grey,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.contain,
            ),
          )),
        ),
      ),
    );
  }
}

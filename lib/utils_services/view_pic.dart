import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/cupertino.dart';

import '../view/global_widgets/AppSize.dart';

class ViewPic extends StatefulWidget {
  List<Attachment>? attachment;
  final int? position;

  ViewPic({Key? key, @required this.attachment, this.position = 0})
      : super(key: key);

  @override
  _ViewPicState createState() => _ViewPicState();
}

class _ViewPicState extends State<ViewPic> {
  int? index = 0;
  @override
  void initState() {
    index = widget.position!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: CarouselSlider(
              options: CarouselOptions(
                  height: height,
                  viewportFraction: 1.0,
                  initialPage: widget.position!,
                  enlargeCenterPage: false,
                  enableInfiniteScroll: false,
                  onPageChanged: (i, dd) {
                    setState(() {
                      index = i;
                    });
                  }),
              items: widget.attachment!.map((item) {
                return PhotoView(
                  initialScale: PhotoViewComputedScale.contained * 0.8,
                  backgroundDecoration: BoxDecoration(color: Colors.white),
                  imageProvider: NetworkImage("${item.attachment}"),
                );
              }).toList(),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '${index! + 1} / ' + '${widget.attachment!.length}',
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}

class Attachment {
  dynamic photoId;
  String? attachment;
  String? type;

  Attachment({this.photoId, this.attachment, this.type});

  Attachment.fromJson(Map<String, dynamic> json) {
    photoId = json['photo_id'];
    attachment = json['attachment'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['photo_id'] = this.photoId;
    data['attachment'] = this.attachment;
    data['type'] = this.type;
    return data;
  }
}

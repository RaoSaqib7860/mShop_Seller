import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageView extends StatefulWidget {
  List<String>? imageV;
  int? slectedIndex;

  ImageView({Key? key, this.imageV, this.slectedIndex}) : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  late PageController controller;
  @override
  void initState() {
    int? index = widget.slectedIndex;
    controller = PageController(initialPage: index!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      onDismissed: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Stack(
            children: [
              PageView.builder(
                itemCount: widget.imageV!.length,
                controller: controller,
                itemBuilder: (BuildContext context, int itemIndex) {
                  return PhotoView(
                    minScale: PhotoViewComputedScale.contained * 0.8,
                    maxScale: PhotoViewComputedScale.covered * 2,
                    imageProvider: NetworkImage('${widget.imageV![itemIndex]}'),
                  );
                },
              ),
              Positioned(
                  top: 30,
                  left: 30,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

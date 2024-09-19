import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

show_cupertino_alert({required BuildContext? context, String? title, Function()? ok}) {
  showDialog(
      context: context!,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Column(
            children: <Widget>[
              Text("Alert".tr),
              SizedBox(height: 5,)
            ],
          ),
          content: new Text("$title"),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text("OK".tr),
              onPressed: () {
                ok!.call();
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text("CANCEL".tr),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}

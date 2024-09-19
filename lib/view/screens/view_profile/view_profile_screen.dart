import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../api_repo/basepath.dart';
import '../../../utils_services/colors_util.dart';
import '../../global_widgets/app_font.dart';
import 'change_password/change_password_screen.dart';

class ViewProfile extends StatefulWidget {
  String? image;
  String? name;
  String? phone;
  String? email;

  ViewProfile({Key? key, this.phone, this.email, this.name, this.image})
      : super(key: key);

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(CupertinoIcons.back, color: Colors.black)),
        title: Text(
          'Personal Information'.tr,
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, right: 8),
            child: Text(
              'Edit'.tr,
              style: TextStyle(color: blueGrey, fontSize: 16),
            ),
          ),
        ],
      ),
      body: Container(
        height: height,
        width: width,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 3.0.h,
              ),
              CircularProfileAvatar(
                '',
                child: CachedNetworkImage(
                  imageUrl: "${widget.image}",
                  placeholder: (context, url) => Container(
                    color: Colors.blue,
                  ),
                  errorWidget: (context, url, error) => Image.network(
                      '${imageUrl}assets/img/placeholder.jpg',
                      fit: BoxFit.fill),
                ),
                radius: 70,
              ),
              SizedBox(
                height: 3.0.h,
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Name'.tr,
                      style: TextStyle(
                          fontFamily: AppFonts.segoeui, fontSize: 13)),
                ),
                subtitle: Container(
                  height: 7.h,
                  width: 90.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color(0xffffffff),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: '   ${widget.name}',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        labelStyle: TextStyle(
                            fontFamily: AppFonts.segoeui,
                            fontSize: 16,
                            color: Colors.black),
                        enabled: false),
                  ),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Email'.tr,
                      style: TextStyle(
                          fontFamily: AppFonts.segoeui, fontSize: 13)),
                ),
                subtitle: Container(
                  height: 7.h,
                  width: 90.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color(0xffffffff),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        //color: const Color(0x290bab0d),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: '   ${widget.email}',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        labelStyle: TextStyle(
                            fontFamily: AppFonts.segoeui,
                            fontSize: 16,
                            color: Colors.black),
                        enabled: false),
                  ),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Mobile'.tr,
                      style: TextStyle(
                          fontFamily: AppFonts.segoeui, fontSize: 13)),
                ),
                subtitle: Container(
                  height: 7.h,
                  width: 90.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color(0xffffffff),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        //color: const Color(0x290bab0d),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: '   ${widget.phone}',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        labelStyle: TextStyle(
                            fontFamily: AppFonts.segoeui,
                            fontSize: 16,
                            color: Colors.black),
                        enabled: false),
                  ),
                ),
              ),
              SizedBox(
                height: 5.0.h,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangePassword(),
                      ));
                },
                child: Container(
                  height: 5.h,
                  width: 70.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.deepPurple,
                  ),
                  child: Center(
                    child: Text('Change Password'.tr,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontFamily: AppFonts.segoeui)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

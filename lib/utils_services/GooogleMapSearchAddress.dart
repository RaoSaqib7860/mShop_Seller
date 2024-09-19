import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as locator;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../view/global_widgets/static_varaible.dart';

openGoogleDailog(
    {BuildContext? context,
    Function(String?)? address,
    Function(double?)? latitude,
    Function(double?)? longitude}) async {
  showGeneralDialog(
      context: context!,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return LayoutBuilder(builder: (c, size) {
          var height = size.maxHeight;
          var width = size.maxWidth;
          return SafeArea(
            child: Listener(
              onPointerDown: (PointerDownEvent event) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              child: Scaffold(
                appBar: PreferredSize(
                    child: Container(
                      height: height * 0.070,
                      width: width,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.arrow_back_ios_rounded,
                                size: 20,
                                color: Colors.blue,
                              )),
                          Padding(
                            padding: EdgeInsets.only(right: width * 0.080),
                            child: Text(
                              'Select your address',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox()
                        ],
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Colors.blue.withOpacity(0.20),
                            offset: Offset(0, 3),
                            blurRadius: 5),
                      ], color: Colors.white),
                    ),
                    preferredSize: Size.fromHeight(height * 0.070)),
                body: Container(
                  width: Get.width,
                  height: Get.height,
                  color: Colors.white,
                  child: PlacePicker(
                    apiKey: googleKey,
                    initialPosition: LatLng(lat!, lng!),
                    useCurrentLocation: true,
                    initialMapType: MapType.terrain,
                    autocompleteLanguage: 'en_US',
                    searchingText: 'Search place here',
                    onMapCreated: (GoogleMapController controller) {},
                    selectInitialPosition: true,
                    enableMapTypeButton: true,
                    hidePlaceDetailsWhenDraggingPin: false,
                    usePlaceDetailSearch: true,
                    automaticallyImplyAppBarLeading: false,
                    //enableMyLocationButton: true,
                    onPlacePicked: (result) async {
                      var place_result = result;
                      latitude!.call(place_result.geometry?.location.lat);
                      longitude!.call(place_result.geometry?.location.lng);
                      address!.call(place_result.url);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ),
          );
        });
      });
}

double? lat;
double? lng;

Future getLocation() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
  ].request();
  locator.Position? position = await locator.Geolocator.getCurrentPosition(
      desiredAccuracy: locator.LocationAccuracy.high);
  if (position != null) {
    lat = position.latitude;
    lng = position.longitude;
  } else {
    locator.Position position = await locator.Geolocator.getCurrentPosition(
        desiredAccuracy: locator.LocationAccuracy.high);
    lat = position.latitude;
    lng = position.longitude;
  }
}

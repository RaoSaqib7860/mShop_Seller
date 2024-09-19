import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../utils_services/colors_util.dart';
import '../CommossionHistoryClass/commission_history_screen.dart';
import '../DashBoared/DashBoaredMainScreen.dart';
import '../Home/home_screen/home_screen.dart';
import '../orders/order_screen.dart';
import '../profile/profile_menu.dart';

PersistentTabController? persistentcontroller;
bool selectHome = true;
var hideNavbar = false.obs;

class BottomSheetCustom extends StatefulWidget {
  final int? index;

  const BottomSheetCustom({Key? key, this.index = 0}) : super(key: key);

  @override
  _BottomSheetCustomState createState() => _BottomSheetCustomState();
}

class _BottomSheetCustomState extends State<BottomSheetCustom> {
  @override
  void initState() {
    persistentcontroller = PersistentTabController(initialIndex: widget.index!);
    super.initState();
  }

  bool? reel_active = false;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PersistentTabView(
        context,
        screens: _buildScreens(),
        items: _navBarsItems(reel_active: reel_active!),
        controller: persistentcontroller,
        confineInSafeArea: true,
        navBarHeight: 46,
        hideNavigationBar: hideNavbar.value,
        // backgroundColor: reel_active! ? Colors.black : Colors.white,
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.grey.shade800,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        onItemSelected: (index) {},
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.simple,
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      DashBoardMainScreen(),
      HomeScreen(),
      OrderScreen(),
      CommissionHistoryScreen(),
      //CommissiionScreen(),
      ProfileMenu(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems({bool? reel_active}) {
    return [
      PersistentBottomNavBarItem(
          icon: SvgPicture.asset(
            'assets/svgs/Home.svg',
            height: 24,
            color: blueGrey,
          ),
          inactiveIcon: SvgPicture.asset(
            'assets/svgs/Home.svg',
            height: 24,
            color: reel_active! ? Colors.white : Colors.black,
          ),
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.black),
      PersistentBottomNavBarItem(
          icon: SvgPicture.asset(
            'assets/svgs/product.svg',
            height: 22,
            color: blueGrey,
          ),
          inactiveIcon: SvgPicture.asset(
            'assets/svgs/product.svg',
            height: 22,
            color: reel_active ? Colors.white : Colors.black,
          ),
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.black),
      PersistentBottomNavBarItem(
          icon: SvgPicture.asset(
            'assets/svgs/Cart.svg',
            height: 24,
            color: blueGrey,
          ),
          inactiveIcon: SvgPicture.asset(
            'assets/svgs/Cart.svg',
            height: 24,
            color: Colors.black,
          ),
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.black),
      PersistentBottomNavBarItem(
          icon: SvgPicture.asset(
            'assets/svgs/money.svg',
            height: 22,
            color: blueGrey,
          ),
          inactiveIcon: SvgPicture.asset(
            'assets/svgs/money.svg',
            height: 22,
            color: reel_active ? Colors.white : Colors.black,
          ),
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.black),
      PersistentBottomNavBarItem(
          icon: SvgPicture.asset(
            'assets/svgs/Profile.svg',
            height: 24,
            color: blueGrey,
          ),
          inactiveIcon: SvgPicture.asset(
            'assets/svgs/Profile.svg',
            height: 24,
            color: reel_active ? Colors.white : Colors.black,
          ),
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.black),
    ];
  }
}

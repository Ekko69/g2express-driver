import 'dart:async';
import 'dart:io';

import 'package:awesome_drawer_bar/awesome_drawer_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fuodz/constants/app_upgrade_settings.dart';
import 'package:fuodz/utils/utils.dart';
import 'package:fuodz/views/pages/order/assigned_orders.page.dart';
import 'package:fuodz/view_models/home.vm.dart';
import 'package:fuodz/views/pages/shared/widgets/app_menu.dart';
import 'package:fuodz/views/pages/taxi/taxi_order.page.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:stacked/stacked.dart';
import 'package:upgrader/upgrader.dart';
import 'package:velocity_x/velocity_x.dart';

import 'widgets/home_menu.view.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final awesomeDrawerBarController = AwesomeDrawerBarController();

  bool canCloseApp = false;
  //
  @override
  Widget build(BuildContext context) {
    final menuWidth = MediaQuery.of(context).size.width * 0.80;

    return WillPopScope(
      onWillPop: () async {
        //
        if (awesomeDrawerBarController != null &&
            awesomeDrawerBarController.isOpen()) {
          awesomeDrawerBarController.close();
          return false;
        }
        //
        if (!canCloseApp) {
          canCloseApp = true;
          Timer(Duration(seconds: 1), () {
            canCloseApp = false;
          });
          //
          Fluttertoast.showToast(
            msg: "Press back again to close".tr(),
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 2,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: const Color(0xAA000000),
            textColor: Colors.white,
            fontSize: 14.0,
          );
          return false;
        }
        return true;
      },
      child: ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(context),
        onModelReady: (vm) {
          vm.initialise();
        },
        builder: (context, vm, child) {
          return AwesomeDrawerBar(
            type: StyleState.stack,
            controller: awesomeDrawerBarController,
            showShadow: true,
            borderRadius: 24.0,
            // angle: -12.0,
            backgroundColor: Colors.grey[300],
            slideWidth: menuWidth,
            slideHeight: context.percentHeight * 100,
            openCurve: Curves.fastOutSlowIn,
            closeCurve: Curves.bounceIn,
            isRTL: Utils.isArabic,
            menuScreen: HomeMenuView().w(menuWidth),
            mainScreen: Scaffold(
              body: UpgradeAlert(
                upgrader: Upgrader(
                  showIgnore: !AppUpgradeSettings.forceUpgrade(),
                  shouldPopScope: () => !AppUpgradeSettings.forceUpgrade(),
                  dialogStyle: Platform.isIOS
                      ? UpgradeDialogStyle.cupertino
                      : UpgradeDialogStyle.material,
                ),
                child: Stack(
                  children: [
                    //home view
                    vm.currentUser == null
                        ? BusyIndicator().centered()
                        : !vm.currentUser.isTaxiDriver
                            ? AssignedOrdersPage()
                            : TaxiOrderPage(),

                    //
                    AppHamburgerMenu(ontap: () {
                      awesomeDrawerBarController.toggle();
                    }),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

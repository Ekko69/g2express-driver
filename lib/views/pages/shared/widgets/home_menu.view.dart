import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_ui_settings.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/profile.vm.dart';
import 'package:fuodz/views/pages/order/orders.page.dart';
import 'package:fuodz/views/pages/profile/finance.page.dart';
import 'package:fuodz/views/pages/profile/legal.page.dart';
import 'package:fuodz/views/pages/profile/support.page.dart';
import 'package:fuodz/views/pages/profile/widget/driver_type.switch.dart';
import 'package:fuodz/views/pages/vehicle/vehicles.page.dart';
import 'package:fuodz/widgets/cards/profile.card.dart';
import 'package:fuodz/widgets/menu_item.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeMenuView extends StatelessWidget {
  const HomeMenuView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        bottom: false,
        child: ViewModelBuilder<ProfileViewModel>.reactive(
          viewModelBuilder: () => ProfileViewModel(context),
          onModelReady: (model) => model.initialise(),
          builder: (context, model, child) {
            return VStack(
              [
                //profile card
                ProfileCard(model).py12(),

                //if driver switch is enabled
                DriverTypeSwitch(),
                Visibility(
                  visible: AppUISettings.enableDriverTypeSwitch ||
                      model.currentUser.isTaxiDriver,
                  child: MenuItem(
                    title: "Vehicle Details".tr(),
                    onPressed: () {
                      context.nextPage(VehiclesPage());
                    },
                    topDivider: true,
                  ),
                ),
                //
                // orders
                MenuItem(
                  title: "Orders".tr(),
                  onPressed: () {
                    context.nextPage(OrdersPage());
                  },
                ),

                MenuItem(
                  title: "Finance".tr(),
                  onPressed: () {
                    context.nextPage(FinancePage());
                  },
                ),

                //menu
                VStack(
                  [
                    //
                    MenuItem(
                      title: "Notifications".tr(),
                      onPressed: model.openNotification,
                    ),

                    //
                    MenuItem(
                      title: "Rate & Review".tr(),
                      onPressed: model.openReviewApp,
                    ),

                    //
                    MenuItem(
                      title: "Legal".tr(),
                      onPressed: () {
                        context.nextPage(LegalPage());
                      },
                    ),
                    MenuItem(
                      title: "Support".tr(),
                      onPressed: () {
                        context.nextPage(SupportPage());
                      },
                    ),

                    //
                    MenuItem(
                      title: "Language".tr(),
                      divider: false,
                      suffix: Icon(
                        FlutterIcons.language_ent,
                      ),
                      onPressed: model.changeLanguage,
                    ),
                  ],
                ),

                //
                MenuItem(
                  child: "Logout".tr().text.red500.make(),
                  onPressed: model.logoutPressed,
                  divider: false,
                  suffix: Icon(
                    FlutterIcons.logout_ant,
                    size: 16,
                  ),
                ),

                UiSpacer.vSpace(15),

                //
                ("Version".tr() + " - ${model.appVersionInfo}")
                    .text
                    .center
                    .sm
                    .makeCentered()
                    .py20(),
              ],
            ).p20().scrollVertical();
          },
        ),
      ),
    ).hFull(context);
  }
}

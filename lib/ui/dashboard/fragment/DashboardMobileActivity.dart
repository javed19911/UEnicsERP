import 'package:UEnicsERP/ui/dashboard/vmDashboard.dart';
import 'package:UEnicsERP/utils/clock.dart';
import 'package:UEnicsERP/utils/customWidget/customText.dart';
import 'package:UEnicsERP/utils/myAppBar.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../base/BaseActivity.dart';

class DashboardMobileActivity extends StatefulWidget {
  @override
  _DashboardMobileActivityState createState() =>
      _DashboardMobileActivityState();
}

class _DashboardMobileActivityState
    extends BaseActivity<DashboardMobileActivity, vmDashboard> {
  @override
  void onCreate() {
    // TODO: implement onCreate
    var vm = getViewModel();

    if (vm != null) {
      Future.delayed(const Duration(milliseconds: 100), () {
        vm.getUser();
        vm.getMenus();
      });
    }

    super.onCreate();
  }

  @override
  Widget getWidget(BuildContext context, vmDashboard? view_model) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BoldText(
              "UEnics Pvt. Ltd.",
              fontSize: 30,
            ),
            SizedBox(
              height: 20,
            ),
            BoldText(
              "Hi ${view_model?.userName},",
              fontSize: 20,
            ),
            SizedBox(
              height: 10,
            ),
            Clock(),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * (2 / 3),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.6,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  shrinkWrap: true,
                  itemCount: view_model?.menus.length,
                  itemBuilder: (BuildContext context, int index) {
                    var menu = view_model!.menus[index];
                    return Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      child: MaterialButton(
                        elevation: 10,
                        focusElevation: 20,
                        focusColor: HexColor.fromHex("3C1F45"),
                        color: Colors.white, //HexColor.fromHex("3C1F45"),
                        highlightColor: Colors.lightGreen,
                        highlightElevation: 20,
                        hoverElevation: 20,
                        hoverColor: Colors.white,
                        splashColor: Colors.lightGreen,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              flex: 3,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                child: Image(
                                  image: AssetImage(menu.image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(menu.name),
                            SizedBox(
                              height: 3,
                            )
                          ],
                        ),
                        /* CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: channel.thumbnail,
                          placeholder:
                              (BuildContext context, String url) {
                            return Center(
                                child: CircularProgressIndicator());
                          },
                        ),*/
                        onPressed: () async {
                          print("clicked");
                          if (menu.action == "account") {
                            startNamedActivity("/accounts", args: menu);
                          } else if (menu.action == "country") {
                            startNamedActivity("/country");
                          }
                        },
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:UEnicsERP/res/color.dart';
import 'package:UEnicsERP/ui/base/BaseActivity.dart';
import 'package:UEnicsERP/ui/country/vmCountry.dart';
import 'package:UEnicsERP/utils/customWidget/customText.dart';
import 'package:UEnicsERP/utils/customWidget/editText.dart';
import 'package:UEnicsERP/utils/customWidget/searchableTextField.dart';
import 'package:UEnicsERP/utils/myAppBar.dart';
import 'package:flutter/material.dart';

class CountryMobileActivity extends StatefulWidget {
  const CountryMobileActivity({Key? key}) : super(key: key);

  @override
  _CountryMobileActivityState createState() => _CountryMobileActivityState();
}

class _CountryMobileActivityState
    extends BaseActivity<CountryMobileActivity, vmCountry> {
  @override
  Widget getWidget(BuildContext context, vmCountry? viewModel) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        // color: CustomColors.activityBg(),
        padding: new EdgeInsets.all(20.0),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BoarderRoundTextView(
                    placeHolder: "Enter Name",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BoarderRoundTextView(
                    placeHolder: "Enter Code",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SearchableTextField(
                    placeHolder: "Enter Name",
                  )
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 250,
                        padding: EdgeInsets.all(5),
                        color: CustomColors.title(),
                        alignment: Alignment.center,
                        child: BoldText(
                          "Companies",
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BoldText(
                              "Single Company",
                              fontSize: 14,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SimpleText(
                                    "Create",
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SimpleText(
                                    "Display",
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SimpleText(
                                    "Alter",
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BoldText(
                              "Multiple Company",
                              fontSize: 14,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SimpleText(
                                    "Create",
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SimpleText(
                                    "Display",
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SimpleText(
                                    "Alter",
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

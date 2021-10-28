import 'package:UEnicsERP/data/models/mMenu.dart';
import 'package:UEnicsERP/res/color.dart';
import 'package:UEnicsERP/utils/customWidget/customText.dart';
import 'package:UEnicsERP/utils/customWidget/editText.dart';
import 'package:UEnicsERP/utils/myAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../base/BaseActivity.dart';
import '../account_vm.dart';

class AccountWebActivity extends StatefulWidget {
  late Menu menu;

  AccountWebActivity({required this.menu});

  @override
  _AccountWebActivityState createState() => _AccountWebActivityState();
}

class _AccountWebActivityState
    extends BaseActivity<AccountWebActivity, AccountVM> {
  @override
  Widget getWidget(BuildContext context, AccountVM? viewModel) {
    return Scaffold(
      // appBar: MyAppBar(),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(2),
            child: BoldText(
              "Ledger Creation",
              color: Colors.white,
            ),
            color: CustomColors.title(),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WebSimpleTextView(
                        placeHolder: "Name",
                        placeHolderRatio: 1 / 6,
                        order: 1,
                      ),
                      WebSimpleTextView(
                        placeHolder: "alias",
                        fontStyle: FontStyle.italic,
                        placeHolderRatio: 1 / 6,
                        order: 2,
                      )
                    ],
                  ),
                )),
                Container(
                  padding: EdgeInsets.all(3),
                  margin: EdgeInsets.only(right: 2),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: CustomColors.graySofi(), width: 1.0)),
                  child: Column(
                    children: [
                      UnderLineText(
                        "Total Opening Balance",
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      BoldText(
                        "2,00,000.00 Dr",
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      BoldItalicText(
                        "Difference",
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      BoldText(
                        "2,00,000.00 Dr",
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WebSimpleTextView(
                      placeHolder: "Under",
                      order: 3,
                    ),
                    WebSimpleTextView(
                      placeHolder: "Set OD limit",
                      order: 4,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    UnderLineText(
                      "Bank Account Details",
                      fontSize: 15,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    WebSimpleTextView(
                      placeHolder: "A/C holder's name",
                      order: 5,
                    ),
                    WebSimpleTextView(
                      placeHolder: "A/C no",
                      order: 6,
                      keyboardType: TextInputType.number,
                      inputFormatters:
                          CustomInputFormatter.NON_NEGATIVE_DECIMAL_NUMBER,
                    ),
                    WebSimpleTextView(
                      placeHolder: "IFS code",
                      order: 7,
                      keyboardType: TextInputType.number,
                      inputFormatters: CustomInputFormatter.ALPHANUMERIC,
                    ),
                    WebSimpleTextView(
                      placeHolder: "Bank name",
                      order: 8,
                    ),
                    WebSimpleTextView(
                      placeHolder: "Branch",
                      order: 9,
                    ),
                    WebSimpleTextView(
                      placeHolder: "BSR code",
                      order: 10,
                      keyboardType: TextInputType.number,
                      inputFormatters:
                          CustomInputFormatter.ALPHANUMERIC_UNDERSCORE,
                    ),
                  ],
                ),
              )),
              Container(
                width: 1,
                color: Colors.black,
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WebSimpleTextView(
                      placeHolder: "Name",
                      order: 11,
                    ),
                    WebSimpleTextView(
                      placeHolder: "alias",
                      order: 12,
                      textInputAction: TextInputAction.done,
                    )
                  ],
                ),
              )),
            ],
          )
        ],
      ),
    );
  }
}

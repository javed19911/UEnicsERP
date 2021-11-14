import 'package:UEnicsERP/ui/base/BaseActivity.dart';
import 'package:UEnicsERP/ui/ledger/ledger_view.dart';
import 'package:UEnicsERP/ui/ledger/leger_vm.dart';
import 'package:UEnicsERP/utils/customWidget/customText.dart';
import 'package:UEnicsERP/utils/customWidget/editText.dart';
import 'package:UEnicsERP/utils/customWidget/searchableTextField.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LedgerActivity extends StatefulWidget {
  const LedgerActivity({Key? key}) : super(key: key);

  @override
  _LedgerActivityState createState() => _LedgerActivityState();
}

class _LedgerActivityState extends BaseActivity<LedgerActivity, LedgerVM>
    implements LedgerView {
  @override
  Widget getWidget(BuildContext context, LedgerVM? viewModel) {
    return ScreenTypeLayout(
      mobile: getMobileWidget(),
      tablet: getWebWidget(),
      desktop: getWebWidget(),
    );
  }

  Widget getMobileWidget() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BoarderRoundTextView(
              placeHolder: "Name",
            ),
            SizedBox(
              height: 10,
            ),
            BoarderRoundTextView(
              placeHolder: "Code",
              enabled: false,
            ),
            SizedBox(
              height: 10,
            ),
            SearchableTextField(
              placeHolder: "Category",
              listener: ((searchQry) {
                print('Debounce Searchable text: ${searchQry}');
              }),
            ),
            SizedBox(
              height: 10,
            ),
            SearchableTextField(
              placeHolder: "Contact Person",
            ),
            SizedBox(
              height: 10,
            ),
            SearchableTextField(
              placeHolder: "Headquarter",
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          color: Colors.blue,
                          padding: EdgeInsets.all(5),
                          child: SimpleText(
                            "Details",
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BoarderRoundTextView(
                                placeHolder: "Office No.",
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              BoarderRoundTextView(
                                placeHolder: "Mobile No.",
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              BoarderRoundTextView(
                                placeHolder: "Email",
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              BoarderRoundTextView(
                                placeHolder: "Aadhaar No.",
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              BoarderRoundTextView(
                                placeHolder: "PAN No.",
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              BoarderRoundTextView(
                                placeHolder: "GST No.",
                              ),
                              SizedBox(
                                height: 3,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          color: Colors.blue,
                          padding: EdgeInsets.all(5),
                          child: SimpleText(
                            "Address",
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BoarderRoundTextView(
                                placeHolder: "Lane 1",
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              BoarderRoundTextView(
                                placeHolder: "Lane 2",
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              BoarderRoundTextView(
                                placeHolder: "Lane 3",
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              BoarderRoundTextView(
                                placeHolder: "City",
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SearchableTextField(
                                placeHolder: "State",
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              BoarderRoundTextView(
                                placeHolder: " Pincode",
                                keyboardType: TextInputType.number,
                                inputFormatters:
                                    CustomInputFormatter.NON_NEGATIVE_INTEGER,
                              ),
                              SizedBox(
                                height: 3,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                ListTile(
                  title: Text('Syria'),
                  onTap: () {
                    print('Syria Tapped');
                  },
                ),
                ListTile(
                  title: Text('Lebanon'),
                  onTap: () {
                    print('Lebanon Tapped');
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getWebWidget() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BoarderRoundTextView(
              placeHolder: "Name",
            ),
            SizedBox(
              height: 10,
            ),
            BoarderRoundTextView(
              placeHolder: "Code",
              enabled: false,
            ),
            SizedBox(
              height: 10,
            ),
            SearchableTextField(
              placeHolder: "Category",
              listener: ((searchQry) {
                print('Debounce Searchable text: ${searchQry}');
              }),
            ),
            SizedBox(
              height: 10,
            ),
            SearchableTextField(
              placeHolder: "Contact Person",
            ),
            SizedBox(
              height: 10,
            ),
            SearchableTextField(
              placeHolder: "Headquarter",
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            color: Colors.blue,
                            padding: EdgeInsets.all(5),
                            child: SimpleText(
                              "Details",
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BoarderRoundTextView(
                                  placeHolder: "Office No.",
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                BoarderRoundTextView(
                                  placeHolder: "Mobile No.",
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                BoarderRoundTextView(
                                  placeHolder: "Email",
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                BoarderRoundTextView(
                                  placeHolder: "Aadhaar No.",
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                BoarderRoundTextView(
                                  placeHolder: "PAN No.",
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                BoarderRoundTextView(
                                  placeHolder: "GST No.",
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            color: Colors.blue,
                            padding: EdgeInsets.all(5),
                            child: SimpleText(
                              "Address",
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BoarderRoundTextView(
                                  placeHolder: "Lane 1",
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                BoarderRoundTextView(
                                  placeHolder: "Lane 2",
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                BoarderRoundTextView(
                                  placeHolder: "Lane 3",
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                BoarderRoundTextView(
                                  placeHolder: "City",
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SearchableTextField(
                                  placeHolder: "State",
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                BoarderRoundTextView(
                                  placeHolder: " Pincode",
                                  keyboardType: TextInputType.number,
                                  inputFormatters:
                                      CustomInputFormatter.NON_NEGATIVE_INTEGER,
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                ListTile(
                  title: Text('Syria'),
                  onTap: () {
                    print('Syria Tapped');
                  },
                ),
                ListTile(
                  title: Text('Lebanon'),
                  onTap: () {
                    print('Lebanon Tapped');
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

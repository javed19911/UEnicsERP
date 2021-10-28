import 'package:UEnicsERP/res/color.dart';
import 'package:UEnicsERP/ui/base/BaseActivity.dart';
import 'package:UEnicsERP/ui/ledger/ledger_view.dart';
import 'package:UEnicsERP/ui/ledger/leger_vm.dart';
import 'package:UEnicsERP/utils/customWidget/customText.dart';
import 'package:UEnicsERP/utils/customWidget/editText.dart';
import 'package:UEnicsERP/utils/customWidget/searchableTextField.dart';
import 'package:flutter/material.dart';

class LedgerWebSampleActivity extends StatefulWidget {
  const LedgerWebSampleActivity({Key? key}) : super(key: key);

  @override
  _LedgerWebSampleActivityState createState() =>
      _LedgerWebSampleActivityState();
}

class _LedgerWebSampleActivityState
    extends BaseActivity<LedgerWebSampleActivity, LedgerVM>
    implements LedgerView {
  @override
  Widget getWidget(BuildContext context, LedgerVM? viewModel) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    WebSimpleTextView(
                      placeHolder: "Name",
                      placeHolderRatio: 1 / 6,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    WebSimpleTextView(
                      placeHolder: "Code",
                      enabled: false,
                      placeHolderRatio: 1 / 6,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    WebSimpleTextView(
                      placeHolder: "Category",
                      placeHolderRatio: 1 / 6,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    WebSimpleTextView(
                      placeHolder: "Contact Person",
                      placeHolderRatio: 1 / 6,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    WebSimpleTextView(
                      placeHolder: "Headquarter",
                      placeHolderRatio: 1 / 6,
                    ),
                    SizedBox(
                      height: 5,
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
                                    color: CustomColors.grayLightest(),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        WebSimpleTextView(
                                          placeHolder: "Office No.",
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        WebSimpleTextView(
                                          placeHolder: "Mobile No.",
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        WebSimpleTextView(
                                          placeHolder: "Email",
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        WebSimpleTextView(
                                          placeHolder: "Aadhaar No.",
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        WebSimpleTextView(
                                          placeHolder: "PAN No.",
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        WebSimpleTextView(
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
                                    color: CustomColors.grayLightest(),
                                    padding: EdgeInsets.all(5),
                                    child: SimpleText(
                                      "Address",
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        WebSimpleTextView(
                                          placeHolder: "Lane 1",
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        WebSimpleTextView(
                                          placeHolder: "Lane 2",
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        WebSimpleTextView(
                                          placeHolder: "Lane 3",
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        WebSimpleTextView(
                                          placeHolder: "City",
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        WebSimpleTextView(
                                          placeHolder: "State",
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        WebSimpleTextView(
                                          placeHolder: " Pincode",
                                          keyboardType: TextInputType.number,
                                          inputFormatters: CustomInputFormatter
                                              .NON_NEGATIVE_INTEGER,
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

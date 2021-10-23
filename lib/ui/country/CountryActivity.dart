import 'package:UEnicsERP/ui/base/BaseActivity.dart';
import 'package:UEnicsERP/ui/country/vmCountry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'fragment/CountryMobileActivity.dart';
import 'fragment/CountryWebActivity.dart';

class CountryActivity extends StatefulWidget {
  const CountryActivity({Key? key}) : super(key: key);

  @override
  _CountryActivityState createState() => _CountryActivityState();
}

class _CountryActivityState extends BaseActivity<CountryActivity, vmCountry> {
  @override
  Widget getWidget(BuildContext context, vmCountry? view_model) {
    return Scaffold(
        body: ScreenTypeLayout(
      mobile: CountryMobileActivity(),
      tablet: CountryWebActivity(),
    ));
  }
}

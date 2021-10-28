import 'package:flutter/material.dart';

import 'fragment/DashboardMobileActivity.dart';
import 'fragment/DashboardWebActivity.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DashboardActivity extends StatefulWidget {
  @override
  _DashboardActivityState createState() => _DashboardActivityState();
}

class _DashboardActivityState extends State<DashboardActivity> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: DashboardMobileActivity(),
      tablet: DashboardWebActivity(
        crossAxisCount: 3,
      ),
      desktop: DashboardWebActivity(),
    );
  }
}

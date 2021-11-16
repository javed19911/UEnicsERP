import 'package:UEnicsERP/res/color.dart';
import 'package:UEnicsERP/utils/customWidget/customText.dart';
import 'package:UEnicsERP/utils/customWidget/editText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../master_vm.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      // elevation: 10,
      child: Container(
        height: 45,
        alignment: Alignment.center,
        color: CustomColors.primaryColor,
        child: Stack(children: [
          Image.asset(
            "lib/res/drawable/header_bg.png",
            fit: BoxFit.fitHeight,
          ),
          ScreenTypeLayout(
            mobile: getMobileWidget(context),
            tablet: getDesktopWidget(context, true),
            desktop: getDesktopWidget(context, false),
          ),
        ]),
      ),
    );
  }

  Widget getDesktopWidget(BuildContext context, bool isTablet) {
    return Row(
      children: [
        if (isTablet)
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: context.read<MasterVM>().controlMenu,
          ),
        SizedBox(
          width: 5,
        ),
        BoldText(
          "UEnics Pvt. Ltd.",
          color: Colors.white,
          fontSize: 20,
        ),
        Spacer(flex: isTablet ? 1 : 2),
        Expanded(child: SearchField()),
        ProfileCard()
      ],
    );
  }

  Widget getMobileWidget(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: context.read<MasterVM>().controlMenu,
        ),
        Expanded(child: SearchField()),
        ProfileCard()
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: getMobileWidget(),
      tablet: getDesktopWidget(),
      desktop: getDesktopWidget(),
    );
  }

  Widget getDesktopWidget() {
    return Container(
      margin: EdgeInsets.only(
        left: 16,
        right: 4,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: CustomColors.secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Image.asset(
            "lib/res/drawable/call_Icon.png",
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text("Angelina Jolie"),
          ),
          Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }

  Widget getMobileWidget() {
    return Container(
      margin: EdgeInsets.only(
        left: 16,
        right: 4,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: CustomColors.secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Image.asset(
            "lib/res/drawable/call_Icon.png",
            height: 20,
          ),
          Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 2, bottom: 2),
      child: SimpleEditText(
        hintText: "Search",
        fillColor: CustomColors.secondaryColor,
        prefixIcon: Icon(Icons.search_rounded),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }
}

import 'package:UEnicsERP/data/models/mMenu.dart';
import 'package:UEnicsERP/res/color.dart';
import 'package:UEnicsERP/utils/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends StatefulWidget {
  final ValueChanged<Menu>? listener;
  final double? elevation;
  final List<Menu> menus;
  Menu? selectedMenu;

  SideMenu(
      {Key? key,
      required this.menus,
      this.listener,
      this.elevation,
      this.selectedMenu})
      : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    // if (widget.selectedMenu != null) {
    //   print(widget.selectedMenu!.toJson());
    // }
    return Drawer(
      elevation: widget.elevation,
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            child: Container(
              padding: EdgeInsets.all(30),
              child: Image(
                image: AssetImage("lib/res/drawable/logo.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListView.builder(
              itemCount: widget.menus.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, int index) {
                Menu menu = widget.menus[index];

                return DrawerListTile(
                  title: menu.name,
                  icon: menu.image,
                  isSelected: (widget.selectedMenu != null &&
                      (menu.code == widget.selectedMenu!.code)),
                  press: () {
                    setState(() {
                      widget.selectedMenu = menu;
                    });
                    if (widget.listener != null) widget.listener!(menu);
                  },
                );
              }),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile(
      {Key? key,
      // For selecting those three line once press "Command+D"
      required this.title,
      required this.icon,
      required this.press,
      this.isSelected = false})
      : super(key: key);

  final String title, icon;
  final VoidCallback press;
  final bool isSelected;

  showMenus(BuildContext context) async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 100, 100),
      items: [
        PopupMenuItem(
          child: Text("View"),
        ),
        PopupMenuItem(
          child: Text("Edit"),
        ),
        PopupMenuItem(
          child: Text("Delete"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
      color: isSelected ? Colors.black12 : Colors.transparent,
      child: ListTile(
        onTap: press,
        horizontalTitleGap: 0.0,
        selectedColor: CustomColors.logoBgColor,
        leading: icon.contains("lib/res") && icon.endsWith(".svg")
            ? SvgPicture.asset(
                icon,
                color: CustomColors.darkGray(),
                // color: Colors.white,
                height: 20,
              )
            : Image.asset(
                icon,
                color: CustomColors.darkGray(),
                // color: Colors.white,
                height: 20,
              ),
        title: Text(
          title,
          style: TextStyle(color: CustomColors.darkGray()),
        ),
      ),
    );
  }
}

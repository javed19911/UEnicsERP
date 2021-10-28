import 'package:UEnicsERP/data/models/mMenu.dart';
import 'package:UEnicsERP/res/color.dart';
import 'package:UEnicsERP/utils/customWidget/customButton.dart';
import 'package:UEnicsERP/utils/customWidget/customText.dart';
import 'package:flutter/material.dart';

class TopMenu extends StatelessWidget {
  final Menu menu;
  final Menu? selectedMenu;
  final double elevation;
  final Color color;
  final IconData? selectedIcon;
  final double iconSize;
  final ValueChanged<Menu>? listener;
  const TopMenu(this.menu,
      {Key? key,
      this.listener,
      this.selectedMenu,
      this.color = Colors.white,
      this.elevation = 10,
      this.selectedIcon = Icons.arrow_drop_up,
      this.iconSize = 25})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (menu.subMenus == null ||
        (menu.subMenus != null && menu.subMenus!.length == 0)) {
      return Container();
    }
    return Material(
      elevation: elevation,
      child: Container(
        height: 40,
        color: color,
        alignment: Alignment.centerLeft,
        child: ListView.builder(
          itemCount: menu.subMenus?.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, int index) {
            Menu subMenu = menu.subMenus![index];
            return SimpleButton(
              text: subMenu.name,
              focusColor: CustomColors.logoBgColor,
              hoverColor: CustomColors.grayLightest(),
              splashColor: Colors.lightGreen,
              onPressed: () async {
                if (listener != null) {
                  listener!(subMenu);
                }
              },
              child: Stack(
                children: [
                  SimpleText(subMenu.name),
                  Positioned.fill(
                      top: 10,
                      child: Icon(
                        selectedIcon,
                        size: iconSize,
                        color: subMenu.code == selectedMenu?.code
                            ? Colors.blue
                            : Colors.transparent,
                      ))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

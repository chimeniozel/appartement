import 'package:flutter/material.dart';

import '../theme/color.dart';

class AuthTab extends StatelessWidget {
  final String active;
  final Function setActive;
  const AuthTab({super.key, required this.active, required this.setActive});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.0,
      child: Row(
        children: [
          getTabItem("S'INSCRIRE", active == "register", "register", setActive),
          getTabItem("SE CONNECTER", active == "login", "login", setActive),
        ],
      ),
    );
  }
}

Widget getTabItem(String title, bool isActive, String key, Function setActive) {
  return Expanded(
    child: GestureDetector(
      onTap: () {
        setActive(key);
      },
      child: Container(
        alignment: Alignment.center,
        height: 52,
        decoration: BoxDecoration(
          color:
              isActive ? const Color.fromRGBO(47, 105, 248, 0.1) : Colors.transparent,
          border: isActive
              ? const Border(
                  bottom: BorderSide(
                    color: primaryColor,
                    width: 3.0,
                  ),
                )
              : null,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive
                ? blackColor
                : const Color.fromRGBO(172, 174, 181, 1),
          ),
        ),
      ),
    ),
  );
}

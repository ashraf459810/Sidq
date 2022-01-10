import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sidq/App/app.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtomNavBar extends StatefulWidget {
  final int? index;
  final List<NavBarItem>? navitems;
  final List<Widget>? routes;
  const ButtomNavBar({Key? key, this.navitems, this.routes, this.index})
      : super(key: key);

  @override
  _ButtomNavBarState createState() => _ButtomNavBarState();
}

class _ButtomNavBarState extends State<ButtomNavBar> {
  int? selectedIndex;

  @override
  void initState() {
    selectedIndex = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widget.routes?.elementAt(selectedIndex!),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 14.sp,
        unselectedFontSize: 14.sp,
        items: navbarlist(widget.navitems!),
        currentIndex: selectedIndex!,
        selectedIconTheme:
            const IconThemeData(color: Colors.grey, opacity: 0.2),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<BottomNavigationBarItem> navbarlist(List<NavBarItem> items) {
    List<BottomNavigationBarItem> navlist = [];
    for (var i = 0; i < items.length; i++) {
      navlist.add(BottomNavigationBarItem(
        icon: SvgPicture.asset(
          items[i].image,
          alignment: Alignment.center,
          color: selectedIndex == i ? Colors.blue : Colors.grey,
          height: h(30),
          width: w(30),
        ),
        label: items[i].name,
      ));
    }
    return navlist;
  }
}

class NavBarItem {
  String name;
  String image;
  NavBarItem(this.image, this.name);
}

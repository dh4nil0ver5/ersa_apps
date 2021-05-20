import 'package:flutter/material.dart';

class BottomNavigationTabBarView extends StatelessWidget {
  var _currentIndex = 0;
  Function onTabChange;

  BottomNavigationTabBarView(this._currentIndex, {this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return bottomNavigationTabBarView();
  }

  BottomNavigationBar bottomNavigationTabBarView() {
    const iconSize = 25.0;
    return BottomNavigationBar(
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      currentIndex: _currentIndex,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      onTap: onTabTapped,
      items: [
        BottomNavigationBarItem(
          title: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text("Home"),
          ),
          icon:Icon(Icons.map, color: Colors.grey,),
          activeIcon: Icon(Icons.map, color: Colors.black),
        ),
        BottomNavigationBarItem(
          title: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text("Legalitas"),
            // child: Text("Home", style: AppTheme.bottomBarTextStyle()),
          ),
          icon:Icon(Icons.copyright, color: Colors.grey,),
          activeIcon: Icon(Icons.copyright, color: Colors.black),
        ),
        BottomNavigationBarItem(
          title: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text("Order"),
            // child: Text("Second tab", style: AppTheme.bottomBarTextStyle()),
          ),
          icon:Icon(Icons.list, color: Colors.grey,),
          activeIcon: Icon(Icons.list, color: Colors.black),
        ),
        BottomNavigationBarItem(
          title: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            // child: Text("Third tab", style: AppTheme.bottomBarTextStyle()),
            child: Text("Rekaman"),
          ),
          icon:Icon(Icons.map, color: Colors.grey,),
          activeIcon: Icon(Icons.map, color: Colors.black),
        ),
      ],
    );
  }

  void onTabTapped(int index) {
    _currentIndex = index;
    onTabChange(index);
  }
}

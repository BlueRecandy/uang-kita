import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:heroicons/heroicons.dart';

class NavbarWidget extends StatefulWidget {
  const NavbarWidget({super.key});

  @override
  State<NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {
  final routes = <Map<String, dynamic>>[
    {'route': '/', 'data': {}},
    {'route': '/dummy', 'data': {}},
    {'route': '/tambah', 'data': {}},
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (value) {
        Navigator.of(context).popUntil((route) => route.isFirst);
        setState(() {
          _currentIndex = value;
          final routeData = routes[value];

          Navigator.pushNamed(context, routeData['route'],
              arguments: routeData['data']);
        });
      },
      items: const [
        BottomNavigationBarItem(
            icon: HeroIcon(HeroIcons.home),
            label: 'Beranda',
            activeIcon: HeroIcon(
              HeroIcons.home,
              style: HeroIconStyle.solid,
            )),
        BottomNavigationBarItem(
            icon: HeroIcon(HeroIcons.newspaper),
            label: 'Tagihan',
            activeIcon: HeroIcon(
              HeroIcons.newspaper,
              style: HeroIconStyle.solid,
            )),
        BottomNavigationBarItem(
            icon: HeroIcon(HeroIcons.plus),
            label: 'Tambah',
            activeIcon: HeroIcon(
              HeroIcons.plus,
              style: HeroIconStyle.solid,
            )),
      ],
    );
  }
}

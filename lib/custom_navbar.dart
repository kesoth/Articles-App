import 'package:articles_app/utils/app_colors.dart';
import 'package:articles_app/views/screens/account/account_screen.dart';
import 'package:articles_app/views/screens/home/home_screen.dart';
import 'package:articles_app/views/screens/p1/p1_screen.dart';
import 'package:articles_app/views/screens/p2/p2_screen.dart';
import 'package:articles_app/views/screens/p3/p3_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomNavBar extends StatefulWidget {
  static const String id = 'MyNavBar';
  // ignore: library_private_types_in_public_api
  static final GlobalKey<_CustomNavBarState> navBarKey =
      GlobalKey<_CustomNavBarState>();

  const CustomNavBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  List<Widget> screens = [
    const HomeScreen(),
    const P1Screen(),
    const P2Screen(),
    const P3Screen(),
    const AccountScreen(),
  ];

  int currentIndex = 0;
  late List<bool> isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = List.generate(5, (index) => index == currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: CustomNavBar.navBarKey,
      backgroundColor: const Color.fromARGB(255, 116, 73, 73),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: [
          _buildNavBarItem(
            index: 0,
            icon: Icons.home,
            label: 'Home',
          ),
          _buildNavBarItem(
            index: 1,
            icon: Icons.mood,
            label: 'P1',
          ),
          _buildNavBarItem(
            index: 2,
            icon: Icons.mood_bad,
            label: 'P2',
          ),
          _buildNavBarItem(
            index: 3,
            icon: Icons.file_copy_rounded,
            label: 'P3',
          ),
          _buildNavBarItem(
            index: 4,
            icon: Icons.person_2,
            label: 'Account',
          ),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
            isSelected = List.generate(5, (i) => i == index);
          });
        },
      ),
    );
  }

  BottomNavigationBarItem _buildNavBarItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected[index] ? kPrimaryMainColor : Colors.white,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Icon(
            icon,
            color: isSelected[index] ? Colors.white : kHintTextColor,
          ),
        ),
      ),
      label: isSelected[index] ? '' : label,
      backgroundColor: Colors.white,
    );
  }
}

// import 'package:flutter/material.dart';

// class BottomNaviBar extends StatefulWidget {
//   int selectedIndex = 2;

//   const BottomNaviBar({
//     super.key,
//   });

//   @override
//   State<BottomNaviBar> createState() => _BottomNaviBarState();
// }

// class _BottomNaviBarState extends State<BottomNaviBar> {
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: widget.selectedIndex, // Current selected index
//       onTap: onItemTapped, // Function to handle item taps
//       type: BottomNavigationBarType.fixed, // Fixed type for icons to be always visible
//       items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Feed',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.explore),
//           label: 'Map',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.directions_run),
//           label: 'Record',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.person),
//           label: 'Profile',
//         ),
//       ],
//     );
//   }
// }

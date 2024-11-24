import 'package:flutter/material.dart';
import 'package:running_app/navigation_top_panel/navigation_indicators.dart';

class NavigationInformationsPanel extends StatefulWidget {
  final Function(int index) onItemTap;
  const NavigationInformationsPanel({super.key, required this.onItemTap});

  @override
  NavigationInformationsPanelState createState() => NavigationInformationsPanelState();
}

class NavigationInformationsPanelState extends State<NavigationInformationsPanel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: 5,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              if (index == 0) return NavigationInformationFirstPage(onItemTap: widget.onItemTap);
              if (index == 1) return NavigationInformationSecondPage(onItemTap: widget.onItemTap);
              if (index == 2) return NavigationInformationThirdPage(onItemTap: widget.onItemTap);
              if (index == 3) return NavigationInformationFourthPage(onItemTap: widget.onItemTap);
              return NavigationInformationFifthPage(onItemTap: widget.onItemTap);
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    width: 8.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                      color: _currentPage == index ? Theme.of(context).colorScheme.primary : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationInformationFirstPage extends StatelessWidget {
  final Function(int index) onItemTap;
  const NavigationInformationFirstPage({super.key, required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(onTap: () => onItemTap(0), child: const CurrentSpeedIndicator()),
        //GestureDetector(onTap: () => onItemTap(1), child: const AverageSpeedIndicator()),
      ],
    );
  }
}

class NavigationInformationSecondPage extends StatelessWidget {
  final Function(int index) onItemTap;
  const NavigationInformationSecondPage({super.key, required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(onTap: () => onItemTap(2), child: const TraveledDistanceIndicator()),
        GestureDetector(onTap: () => onItemTap(3), child: const DistanceToNextWaypointIndicator()),
      ],
    );
  }
}

class NavigationInformationThirdPage extends StatelessWidget {
  final Function(int index) onItemTap;
  const NavigationInformationThirdPage({super.key, required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(onTap: () => onItemTap(4), child: const TraveledDistanceIndicator()),
        GestureDetector(onTap: () => onItemTap(5), child: const RemainingDistanceIndicator()),
      ],
    );
  }
}

class NavigationInformationFourthPage extends StatelessWidget {
  final Function(int index) onItemTap;
  const NavigationInformationFourthPage({super.key, required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //GestureDetector(onTap: () => onItemTap(6), child: const MotionIndicator()),
        GestureDetector(onTap: () => onItemTap(7), child: const RemainingDurationIndicator()),
      ],
    );
  }
}

class NavigationInformationFifthPage extends StatelessWidget {
  final Function(int index) onItemTap;
  const NavigationInformationFifthPage({super.key, required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //GestureDetector(onTap: () => onItemTap(8), child: const TerrainProfileIndicator()),
        //GestureDetector(onTap: () => onItemTap(9), child: const CurrentElevationIndicator()),
      ],
    );
  }
}

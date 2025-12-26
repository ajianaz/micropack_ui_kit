import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class NavigationRailDemoPage extends StatefulWidget {
  const NavigationRailDemoPage({super.key});

  @override
  State<NavigationRailDemoPage> createState() => _NavigationRailDemoPageState();
}

class _NavigationRailDemoPageState extends State<NavigationRailDemoPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: MPText.head(
          'Navigation Rail Demo',
          style: TextStyle(color: context.mp.textColor),
          fontSize: 20,
        ),
        backgroundColor: context.mp.adaptiveBackgroundColor,
        elevation: 0,
      ),
      body: Row(
        children: [
          MPNavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: [
              MPNavigationRailDestination(
                icon: Icons.home,
                label: 'Home',
              ),
              MPNavigationRailDestination(
                icon: Icons.search,
                label: 'Search',
              ),
              MPNavigationRailDestination(
                icon: Icons.notifications,
                label: 'Notifications',
                badge: MPBadge(label: '3'),
              ),
              MPNavigationRailDestination(
                icon: Icons.message,
                label: 'Messages',
              ),
              MPNavigationRailDestination(
                icon: Icons.bookmark,
                label: 'Bookmarks',
              ),
              MPNavigationRailDestination(
                icon: Icons.settings,
                label: 'Settings',
              ),
            ],
          ),
          Expanded(
            child: _buildContent(context),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      padding: MPResponsivePadding.card(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSizes(context),
          SizedBox(height: MPResponsivePadding.getLg(context)),
          _buildLabelTypes(context),
        ],
      ),
    );
  }

  Widget _buildSizes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Navigation Rail Sizes',
          fontSize: 18,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        Wrap(
          spacing: MPResponsivePadding.getSm(context),
          runSpacing: MPResponsivePadding.getSm(context),
          children: [
            _SizeButton(
              label: 'Compact',
              onPressed: () => _showCompact(context),
            ),
            _SizeButton(
              label: 'Medium',
              onPressed: () => _showMedium(context),
            ),
            _SizeButton(
              label: 'Expanded',
              onPressed: () => _showExpanded(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLabelTypes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Label Types',
          fontSize: 18,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        Wrap(
          spacing: MPResponsivePadding.getSm(context),
          runSpacing: MPResponsivePadding.getSm(context),
          children: [
            _SizeButton(
              label: 'None (Icons Only)',
              onPressed: () => _showNoneLabels(context),
            ),
            _SizeButton(
              label: 'Selected Only',
              onPressed: () => _showSelectedLabels(context),
            ),
            _SizeButton(
              label: 'All Labels',
              onPressed: () => _showAllLabels(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget _SizeButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return MPButton(
      text: label,
      onPressed: onPressed,
      variant: MPButtonVariant.outlined,
    );
  }

  void _showCompact(BuildContext context) {
    MPBottomSheet.show<void>(
      context: context,
      title: 'Compact Navigation Rail',
      variant: MPBottomSheetVariant.rounded,
      actions: [
        MPBottomSheetAction(
          label: 'Close',
          style: MPBottomSheetActionStyle.secondary,
          onPressed: () => Navigator.pop(context),
        ),
      ],
      child: Row(
        children: [
          MPNavigationRail(
            selectedIndex: _selectedIndex,
            size: MPNavigationRailSize.compact,
            labelType: MPNavigationRailLabelType.none,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: [
              MPNavigationRailDestination(
                icon: Icons.home,
                label: 'Home',
              ),
              MPNavigationRailDestination(
                icon: Icons.settings,
                label: 'Settings',
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: MPText.head('Compact - Icons Only'),
            ),
          ),
        ],
      ),
    );
  }

  void _showMedium(BuildContext context) {
    MPBottomSheet.show<void>(
      context: context,
      title: 'Medium Navigation Rail',
      variant: MPBottomSheetVariant.rounded,
      actions: [
        MPBottomSheetAction(
          label: 'Close',
          style: MPBottomSheetActionStyle.secondary,
          onPressed: () => Navigator.pop(context),
        ),
      ],
      child: Row(
        children: [
          MPNavigationRail(
            selectedIndex: _selectedIndex,
            size: MPNavigationRailSize.medium,
            labelType: MPNavigationRailLabelType.all,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: [
              MPNavigationRailDestination(
                icon: Icons.home,
                label: 'Home',
              ),
              MPNavigationRailDestination(
                icon: Icons.settings,
                label: 'Settings',
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: MPText.head('Medium Size'),
            ),
          ),
        ],
      ),
    );
  }

  void _showExpanded(BuildContext context) {
    MPBottomSheet.show<void>(
      context: context,
      title: 'Expanded Navigation Rail',
      variant: MPBottomSheetVariant.rounded,
      actions: [
        MPBottomSheetAction(
          label: 'Close',
          style: MPBottomSheetActionStyle.secondary,
          onPressed: () => Navigator.pop(context),
        ),
      ],
      child: Row(
        children: [
          MPNavigationRail(
            selectedIndex: _selectedIndex,
            size: MPNavigationRailSize.expanded,
            labelType: MPNavigationRailLabelType.all,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: [
              MPNavigationRailDestination(
                icon: Icons.home,
                label: 'Home',
              ),
              MPNavigationRailDestination(
                icon: Icons.settings,
                label: 'Settings',
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: MPText.head('Expanded Size'),
            ),
          ),
        ],
      ),
    );
  }

  void _showNoneLabels(BuildContext context) {
    MPBottomSheet.show<void>(
      context: context,
      title: 'No Labels',
      variant: MPBottomSheetVariant.rounded,
      actions: [
        MPBottomSheetAction(
          label: 'Close',
          style: MPBottomSheetActionStyle.secondary,
          onPressed: () => Navigator.pop(context),
        ),
      ],
      child: Row(
        children: [
          MPNavigationRail(
            selectedIndex: _selectedIndex,
            labelType: MPNavigationRailLabelType.none,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: [
              MPNavigationRailDestination(
                icon: Icons.home,
                label: 'Home',
              ),
              MPNavigationRailDestination(
                icon: Icons.settings,
                label: 'Settings',
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: MPText.head('Icons Only'),
            ),
          ),
        ],
      ),
    );
  }

  void _showSelectedLabels(BuildContext context) {
    MPBottomSheet.show<void>(
      context: context,
      title: 'Selected Labels Only',
      variant: MPBottomSheetVariant.rounded,
      actions: [
        MPBottomSheetAction(
          label: 'Close',
          style: MPBottomSheetActionStyle.secondary,
          onPressed: () => Navigator.pop(context),
        ),
      ],
      child: Row(
        children: [
          MPNavigationRail(
            selectedIndex: _selectedIndex,
            labelType: MPNavigationRailLabelType.selected,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: [
              MPNavigationRailDestination(
                icon: Icons.home,
                label: 'Home',
              ),
              MPNavigationRailDestination(
                icon: Icons.settings,
                label: 'Settings',
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: MPText.head('Selected Item Shows Label'),
            ),
          ),
        ],
      ),
    );
  }

  void _showAllLabels(BuildContext context) {
    MPBottomSheet.show<void>(
      context: context,
      title: 'All Labels',
      variant: MPBottomSheetVariant.rounded,
      actions: [
        MPBottomSheetAction(
          label: 'Close',
          style: MPBottomSheetActionStyle.secondary,
          onPressed: () => Navigator.pop(context),
        ),
      ],
      child: Row(
        children: [
          MPNavigationRail(
            selectedIndex: _selectedIndex,
            labelType: MPNavigationRailLabelType.all,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: [
              MPNavigationRailDestination(
                icon: Icons.home,
                label: 'Home',
              ),
              MPNavigationRailDestination(
                icon: Icons.settings,
                label: 'Settings',
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: MPText.head('All Items Show Labels'),
            ),
          ),
        ],
      ),
    );
  }
}

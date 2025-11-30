import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class TabPage extends StatefulWidget {
  const TabPage({super.key});

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Tab Components',
          style: TextStyle(color: context.mp.textColor),
        ),
        backgroundColor: context.mp.adaptiveBackgroundColor,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: context.mp.primary,
          labelColor: context.mp.primary,
          unselectedLabelColor: context.mp.subtitleColor,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          tabs: const [
            Tab(text: 'Standard'),
            Tab(text: 'Outlined'),
            Tab(text: 'Filled'),
            Tab(text: 'With Icons'),
            Tab(text: 'With Badges'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Standard Tabs
          Column(
            children: [
              MPText.head('Standard Tabs'),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: MPTabRounded(
                      title: 'Home',
                      tabLocation: 'left',
                      isActiveTab: _selectedIndex == 0,
                      onTab: () => _selectTab(0),
                    ),
                  ),
                  Expanded(
                    child: MPTabRounded(
                      title: 'Feed',
                      tabLocation: 'center',
                      isActiveTab: _selectedIndex == 1,
                      onTab: () => _selectTab(1),
                    ),
                  ),
                  Expanded(
                    child: MPTabRounded(
                      title: 'Profile',
                      tabLocation: 'right',
                      isActiveTab: _selectedIndex == 2,
                      onTab: () => _selectTab(2),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: MPTabRounded(
                      title: 'Settings',
                      tabLocation: 'left',
                      isActiveTab: _selectedIndex == 3,
                      onTab: () => _selectTab(3),
                      size: MPTabRoundedSize.small,
                    ),
                  ),
                  Expanded(
                    child: MPTabRounded(
                      title: 'Help',
                      tabLocation: 'right',
                      isActiveTab: _selectedIndex == 4,
                      onTab: () => _selectTab(4),
                      size: MPTabRoundedSize.small,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              // Disabled Tabs Demo
              MPText.head('Disabled Tabs'),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: MPTabRounded(
                      title: 'Disabled',
                      tabLocation: 'left',
                      isDisabled: true,
                      onTab: () => _selectTab(0),
                    ),
                  ),
                  Expanded(
                    child: MPTabRounded(
                      title: 'Active',
                      tabLocation: 'center',
                      isActiveTab: _selectedIndex == 1,
                      onTab: () => _selectTab(1),
                    ),
                  ),
                  Expanded(
                    child: MPTabRounded(
                      title: 'Disabled',
                      tabLocation: 'right',
                      isDisabled: true,
                      onTab: () => _selectTab(2),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Outlined Tabs
          Column(
            children: [
              MPText.head('Outlined Tabs'),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: MPTabRounded(
                      title: 'Dashboard',
                      tabLocation: 'left',
                      isActiveTab: _selectedIndex == 0,
                      onTab: () => _selectTab(0),
                      variant: MPTabRoundedVariant.outlined,
                    ),
                  ),
                  Expanded(
                    child: MPTabRounded(
                      title: 'Analytics',
                      tabLocation: 'center',
                      isActiveTab: _selectedIndex == 1,
                      onTab: () => _selectTab(1),
                      variant: MPTabRoundedVariant.outlined,
                    ),
                  ),
                  Expanded(
                    child: MPTabRounded(
                      title: 'Reports',
                      tabLocation: 'right',
                      isActiveTab: _selectedIndex == 2,
                      onTab: () => _selectTab(2),
                      variant: MPTabRoundedVariant.outlined,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Filled Tabs
          Column(
            children: [
              MPText.head('Filled Tabs'),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: MPTabRounded(
                      title: 'Overview',
                      tabLocation: 'left',
                      isActiveTab: _selectedIndex == 0,
                      onTab: () => _selectTab(0),
                      variant: MPTabRoundedVariant.filled,
                      tabColorActive: context.mp.primary,
                      tabColor: context.mp.primarySurface,
                    ),
                  ),
                  Expanded(
                    child: MPTabRounded(
                      title: 'Statistics',
                      tabLocation: 'center',
                      isActiveTab: _selectedIndex == 1,
                      onTab: () => _selectTab(1),
                      variant: MPTabRoundedVariant.filled,
                      tabColorActive: context.mp.successColor,
                      tabColor: context.mp.successColor.withValues(alpha: 0.1),
                    ),
                  ),
                  Expanded(
                    child: MPTabRounded(
                      title: 'Activity',
                      tabLocation: 'right',
                      isActiveTab: _selectedIndex == 2,
                      onTab: () => _selectTab(2),
                      variant: MPTabRoundedVariant.filled,
                      tabColorActive: context.mp.warningColor,
                      tabColor: context.mp.warningColor.withValues(alpha: 0.1),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Tabs with Icons
          Column(
            children: [
              MPText.head('Tabs with Icons'),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: MPTabRounded(
                      title: 'Inbox',
                      icon: Icons.inbox,
                      isActiveTab: _selectedIndex == 0,
                      onTab: () => _selectTab(0),
                      size: MPTabRoundedSize.large,
                    ),
                  ),
                  Expanded(
                    child: MPTabRounded(
                      title: 'Starred',
                      icon: Icons.star,
                      isActiveTab: _selectedIndex == 1,
                      onTab: () => _selectTab(1),
                      size: MPTabRoundedSize.large,
                    ),
                  ),
                  Expanded(
                    child: MPTabRounded(
                      title: 'Sent',
                      icon: Icons.send,
                      isActiveTab: _selectedIndex == 2,
                      onTab: () => _selectTab(2),
                      size: MPTabRoundedSize.large,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Tabs with Badges
          Column(
            children: [
              MPText.head('Tabs with Badges'),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: MPTabRounded(
                      title: 'Messages',
                      badge: '12',
                      isActiveTab: _selectedIndex == 0,
                      onTab: () => _selectTab(0),
                      badgeColor: context.mp.errorColor,
                    ),
                  ),
                  Expanded(
                    child: MPTabRounded(
                      title: 'Notifications',
                      badge: '99+',
                      isActiveTab: _selectedIndex == 1,
                      onTab: () => _selectTab(1),
                      badgeColor: context.mp.warningColor,
                    ),
                  ),
                  Expanded(
                    child: MPTabRounded(
                      title: 'Tasks',
                      badge: '5',
                      isActiveTab: _selectedIndex == 2,
                      onTab: () => _selectTab(2),
                      badgeColor: context.mp.successColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: MPTabRounded(
                      title: 'Updates',
                      badge: '3',
                      isActiveTab: _selectedIndex == 3,
                      onTab: () => _selectTab(3),
                      badgeColor: context.mp.infoColor,
                      badgeTextColor: context.mp.neutral100,
                    ),
                  ),
                  Expanded(
                    child: MPTabRounded(
                      title: 'Alerts',
                      badge: '!',
                      isActiveTab: _selectedIndex == 4,
                      onTab: () => _selectTab(4),
                      badgeColor: context.mp.errorColor,
                      badgeTextColor: context.mp.neutral100,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _selectTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _showSnackBar(context, 'Tab ${index + 1} selected');
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: MPText(message),
        backgroundColor: context.mp.neutral90,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

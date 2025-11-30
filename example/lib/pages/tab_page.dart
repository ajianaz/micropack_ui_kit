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
      appBar: AppBar(
        title: const Text('Tab Components'),
        bottom: TabBar(
          controller: _tabController,
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
                      tabColorActive: Colors.blue.shade700,
                      tabColor: Colors.blue.shade100,
                    ),
                  ),
                  Expanded(
                    child: MPTabRounded(
                      title: 'Statistics',
                      tabLocation: 'center',
                      isActiveTab: _selectedIndex == 1,
                      onTab: () => _selectTab(1),
                      variant: MPTabRoundedVariant.filled,
                      tabColorActive: Colors.green.shade700,
                      tabColor: Colors.green.shade100,
                    ),
                  ),
                  Expanded(
                    child: MPTabRounded(
                      title: 'Activity',
                      tabLocation: 'right',
                      isActiveTab: _selectedIndex == 2,
                      onTab: () => _selectTab(2),
                      variant: MPTabRoundedVariant.filled,
                      tabColorActive: Colors.orange.shade700,
                      tabColor: Colors.orange.shade100,
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
                      badgeColor: Colors.red,
                    ),
                  ),
                  Expanded(
                    child: MPTabRounded(
                      title: 'Notifications',
                      badge: '99+',
                      isActiveTab: _selectedIndex == 1,
                      onTab: () => _selectTab(1),
                      badgeColor: Colors.orange,
                    ),
                  ),
                  Expanded(
                    child: MPTabRounded(
                      title: 'Tasks',
                      badge: '5',
                      isActiveTab: _selectedIndex == 2,
                      onTab: () => _selectTab(2),
                      badgeColor: Colors.green,
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
                      badgeColor: Colors.blue,
                      badgeTextColor: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: MPTabRounded(
                      title: 'Alerts',
                      badge: '!',
                      isActiveTab: _selectedIndex == 4,
                      onTab: () => _selectTab(4),
                      badgeColor: Colors.red,
                      badgeTextColor: Colors.white,
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
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

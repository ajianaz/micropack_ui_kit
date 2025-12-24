import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class DropdownDemoPage extends StatefulWidget {
  const DropdownDemoPage({super.key});

  @override
  State<DropdownDemoPage> createState() => _DropdownDemoPageState();
}

class _DropdownDemoPageState extends State<DropdownDemoPage> {
  String? _selectedCountry;
  String? _selectedCity;
  String? _selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: MPText.head(
          'Dropdown Demo',
          style: TextStyle(color: context.mp.textColor),
          fontSize: 20,
        ),
        backgroundColor: context.mp.adaptiveBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: MPResponsivePadding.card(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBasicDropdowns(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildWithSearch(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildMultiSelect(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildExamples(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicDropdowns(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Basic Dropdowns',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _DropdownCard(
          title: 'Single Select',
          description: 'Standard dropdown selection',
          child: MPDropdown<String>(
            hint: 'Select country',
            value: _selectedCountry,
            items: const [
              MPDropdownItem(value: 'US', label: 'United States'),
              MPDropdownItem(value: 'UK', label: 'United Kingdom'),
              MPDropdownItem(value: 'CA', label: 'Canada'),
              MPDropdownItem(value: 'AU', label: 'Australia'),
            ],
            onChanged: (value) {
              setState(() {
                _selectedCountry = value;
              });
            },
          ),
        ),
        SizedBox(height: 16),
        _DropdownCard(
          title: 'With Placeholder',
          description: 'Dropdown with custom placeholder',
          child: MPDropdown<String>(
            hint: 'Choose an option',
            value: _selectedCity,
            items: const [
              MPDropdownItem(value: 'NYC', label: 'New York'),
              MPDropdownItem(value: 'LAX', label: 'Los Angeles'),
              MPDropdownItem(value: 'CHI', label: 'Chicago'),
            ],
            onChanged: (value) {
              setState(() {
                _selectedCity = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWithSearch(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Dropdown with Search',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _DropdownCard(
          title: 'Searchable Dropdown',
          description: 'Dropdown with search functionality',
          child: MPDropdown<String>(
            hint: 'Search and select',
            value: _selectedRole,
            items: const [
              MPDropdownItem(value: 'admin', label: 'Administrator'),
              MPDropdownItem(value: 'editor', label: 'Editor'),
              MPDropdownItem(value: 'viewer', label: 'Viewer'),
              MPDropdownItem(value: 'guest', label: 'Guest'),
            ],
            onChanged: (value) {
              setState(() {
                _selectedRole = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMultiSelect(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Multi Select',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _DropdownCard(
          title: 'Multiple Selection',
          description: 'Dropdown with multiple items',
          child: MPDropdown<String>(
            hint: 'Select categories',
            items: const [
              MPDropdownItem(value: 'tech', label: 'Technology'),
              MPDropdownItem(value: 'business', label: 'Business'),
              MPDropdownItem(value: 'design', label: 'Design'),
              MPDropdownItem(value: 'marketing', label: 'Marketing'),
            ],
            onChanged: (values) {
              // Handle multi-select
            },
          ),
        ),
      ],
    );
  }

  Widget _buildExamples(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Practical Examples',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _ExampleCard(
          title: 'User Settings',
          description: 'User preferences form',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MPText.label('Language'),
              SizedBox(height: 8),
              MPDropdown<String>(
                hint: 'Select language',
                items: const [
                  MPDropdownItem(value: 'en', label: 'English'),
                  MPDropdownItem(value: 'es', label: 'Spanish'),
                  MPDropdownItem(value: 'fr', label: 'French'),
                  MPDropdownItem(value: 'de', label: 'German'),
                ],
                onChanged: (value) {},
              ),
              SizedBox(height: 20),
              MPText.label('Timezone'),
              SizedBox(height: 8),
              MPDropdown<String>(
                hint: 'Select timezone',
                items: const [
                  MPDropdownItem(value: 'utc', label: 'UTC'),
                  MPDropdownItem(value: 'est', label: 'EST'),
                  MPDropdownItem(value: 'pst', label: 'PST'),
                  MPDropdownItem(value: 'cst', label: 'CST'),
                ],
                onChanged: (value) {},
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _ExampleCard(
          title: 'Filter Options',
          description: 'Dropdown in filter context',
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MPText.label('Category'),
                    SizedBox(height: 8),
                    MPDropdown<String>(
                      hint: 'All',
                      items: const [
                        MPDropdownItem(value: 'all', label: 'All'),
                        MPDropdownItem(value: 'active', label: 'Active'),
                        MPDropdownItem(value: 'archived', label: 'Archived'),
                      ],
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MPText.label('Sort By'),
                    SizedBox(height: 8),
                    MPDropdown<String>(
                      hint: 'Date',
                      items: const [
                        MPDropdownItem(value: 'date', label: 'Date'),
                        MPDropdownItem(value: 'name', label: 'Name'),
                        MPDropdownItem(value: 'size', label: 'Size'),
                      ],
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _ExampleCard(
          title: 'Team Assignment',
          description: 'Assign team member to task',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.task, color: context.mp.primary),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MPText.head('Task Assignment'),
                        SizedBox(height: 4),
                        MPText.label(
                          'Assign task to team member',
                          style: TextStyle(
                            color: context.mp.subtitleColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              MPDropdown<String>(
                hint: 'Select team member',
                items: const [
                  MPDropdownItem(
                    value: 'john',
                    label: 'John Doe',
                    leading: Icon(Icons.person, color: Color(0xFF6B7280)),
                  ),
                  MPDropdownItem(
                    value: 'jane',
                    label: 'Jane Smith',
                    leading: Icon(Icons.person, color: Color(0xFF6B7280)),
                  ),
                  MPDropdownItem(
                    value: 'bob',
                    label: 'Bob Wilson',
                    leading: Icon(Icons.person, color: Color(0xFF6B7280)),
                  ),
                ],
                onChanged: (value) {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _DropdownCard({
    required String title,
    required String description,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.mp.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.mp.borderColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MPText.head(
            title,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 4),
          MPText.label(
            description,
            style: TextStyle(
              color: context.mp.subtitleColor,
            ),
          ),
          SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _ExampleCard({
    required String title,
    required String description,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: context.mp.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.mp.borderColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            // Theme-aware shadow for proper visibility in both modes
            color: context.mp.adaptiveShadowColor.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MPText.head(
                  title,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 4),
                MPText.label(
                  description,
                  style: TextStyle(
                    color: context.mp.subtitleColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: child,
          ),
        ],
      ),
    );
  }
}

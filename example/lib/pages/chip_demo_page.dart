import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class ChipDemoPage extends StatefulWidget {
  const ChipDemoPage({super.key});

  @override
  State<ChipDemoPage> createState() => _ChipDemoPageState();
}

class _ChipDemoPageState extends State<ChipDemoPage> {
  final List<String> _selectedTags = ['Flutter', 'Dart'];
  final List<String> _allTags = [
    'Flutter',
    'Dart',
    'UI',
    'Mobile',
    'Web',
    'Desktop',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: MPText.head(
          'Chip Demo',
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
            _buildVariants(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildWithAvatars(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildClosableChips(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildExamples(context),
          ],
        ),
      ),
    );
  }

  Widget _buildVariants(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Chip Variants',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _ChipCard(
          title: 'Default',
          description: 'Standard chip style',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              MPChip(label: 'Flutter'),
              MPChip(label: 'Dart'),
              MPChip(label: 'UI Kit'),
            ],
          ),
        ),
        SizedBox(height: 16),
        _ChipCard(
          title: 'Primary',
          description: 'Primary colored chip',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              MPChip(label: 'Active', variant: MPChipVariant.primary),
              MPChip(label: 'Selected', variant: MPChipVariant.primary),
            ],
          ),
        ),
        SizedBox(height: 16),
        _ChipCard(
          title: 'Outlined',
          description: 'Outlined chip style',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              MPChip(label: 'Tag 1', variant: MPChipVariant.outlined),
              MPChip(label: 'Tag 2', variant: MPChipVariant.outlined),
            ],
          ),
        ),
        SizedBox(height: 16),
        _ChipCard(
          title: 'Filter',
          description: 'Filter chip style',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              MPChip(
                label: 'All',
                selected: true,
                variant: MPChipVariant.outlined,
                onPressed: () {},
              ),
              MPChip(
                label: 'Unread',
                variant: MPChipVariant.outlined,
                onPressed: () {},
              ),
              MPChip(
                label: 'Favorites',
                variant: MPChipVariant.outlined,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWithAvatars(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Chips with Avatars',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _ChipCard(
          title: 'User Chips',
          description: 'Chips showing user avatars',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              MPChip(
                label: 'John Doe',
                avatar: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text('JD'),
                ),
                onPressed: () {},
              ),
              MPChip(
                label: 'Jane Smith',
                avatar: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text('JS'),
                ),
                onPressed: () {},
              ),
              MPChip(
                label: 'Bob Wilson',
                avatar: CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Text('BW'),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _ChipCard(
          title: 'Icon Chips',
          description: 'Chips with leading icons',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              MPChip(
                label: 'Work',
                leading: Icon(Icons.work),
                onPressed: () {},
              ),
              MPChip(
                label: 'Personal',
                leading: Icon(Icons.person),
                onPressed: () {},
              ),
              MPChip(
                label: 'Family',
                leading: Icon(Icons.family_restroom),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildClosableChips(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Closable Chips',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _ChipCard(
          title: 'Removable Tags',
          description: 'Chips that can be removed',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              MPChip(
                label: 'Flutter',
                onDeleted: () {},
              ),
              MPChip(
                label: 'Dart',
                onDeleted: () {},
              ),
              MPChip(
                label: 'Mobile',
                onDeleted: () {},
              ),
              MPChip(
                label: 'Web',
                variant: MPChipVariant.primary,
                onDeleted: () {},
              ),
            ],
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
          title: 'Tag Selector',
          description: 'Multi-select tags',
          child: Container(
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
                MPText.head('Select Tags'),
                SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _allTags.map((tag) {
                    final isSelected = _selectedTags.contains(tag);
                    return MPChip(
                      label: tag,
                      selected: isSelected,
                      variant: isSelected
                          ? MPChipVariant.primary
                          : MPChipVariant.outlined,
                      onPressed: () {
                        setState(() {
                          if (isSelected) {
                            _selectedTags.remove(tag);
                          } else {
                            _selectedTags.add(tag);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),
                MPText.label(
                  'Selected: ${_selectedTags.join(", ")}',
                  style: TextStyle(
                    color: context.mp.subtitleColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
        _ExampleCard(
          title: 'Topic Suggestions',
          description: 'Suggested topics to follow',
          child: Container(
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
                MPText.head('Suggested Topics'),
                SizedBox(height: 16),
                _SuggestionChip('Flutter Development', Icons.code),
                _SuggestionChip('UI/UX Design', Icons.palette),
                _SuggestionChip('Mobile App', Icons.phone_android),
                _SuggestionChip('Web Development', Icons.web),
                _SuggestionChip('Firebase', Icons.cloud),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
        _ExampleCard(
          title: 'Team Members',
          description: 'Team member chips with avatars',
          child: Container(
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
                MPText.head('Team Members'),
                SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    MPChip(
                      label: 'Alice',
                      avatar: CircleAvatar(
                        backgroundColor: Colors.purple,
                        child: Text('A'),
                      ),
                      onPressed: () {},
                    ),
                    MPChip(
                      label: 'Bob',
                      avatar: CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text('B'),
                      ),
                      onPressed: () {},
                    ),
                    MPChip(
                      label: 'Carol',
                      avatar: CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Text('C'),
                      ),
                      onPressed: () {},
                    ),
                    MPChip(
                      label: 'Dave',
                      avatar: CircleAvatar(
                        backgroundColor: Colors.orange,
                        child: Text('D'),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: 16),
                MPButton(
                  text: 'Add Member',
                  variant: MPButtonVariant.outlined,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _ChipCard({
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
            color: Colors.black.withValues(alpha: 0.05),
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
          child,
        ],
      ),
    );
  }

  Widget _SuggestionChip(String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: MPChip(
        label: label,
        leading: Icon(icon),
        variant: MPChipVariant.outlined,
        onPressed: () {},
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class CheckboxDemoPage extends StatefulWidget {
  const CheckboxDemoPage({super.key});

  @override
  State<CheckboxDemoPage> createState() => _CheckboxDemoPageState();
}

class _CheckboxDemoPageState extends State<CheckboxDemoPage> {
  bool _checked1 = false;
  bool _checked2 = true;
  bool _checked3 = false;
  bool _checked4 = true;
  bool _indeterminate = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: MPText.head(
          'Checkbox Demo',
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
            _buildSizes(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildStates(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildWithLabels(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildExamples(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSizes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Checkbox Sizes',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _CheckboxCard(
          title: 'Small',
          description: 'Compact checkbox',
          child: MPCheckbox(
            value: _checked1,
            size: MPCheckboxSize.small,
            onChanged: (value) => setState(() => _checked1 = value ?? false),
          ),
        ),
        SizedBox(height: 16),
        _CheckboxCard(
          title: 'Medium',
          description: 'Default medium size',
          child: MPCheckbox(
            value: _checked2,
            size: MPCheckboxSize.medium,
            onChanged: (value) => setState(() => _checked2 = value ?? false),
          ),
        ),
        SizedBox(height: 16),
        _CheckboxCard(
          title: 'Large',
          description: 'Prominent large checkbox',
          child: MPCheckbox(
            value: _checked3,
            size: MPCheckboxSize.large,
            onChanged: (value) => setState(() => _checked3 = value ?? false),
          ),
        ),
      ],
    );
  }

  Widget _buildStates(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Checkbox States',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _CheckboxCard(
          title: 'Checked',
          description: 'Selected checkbox',
          child: MPCheckbox(
            value: true,
            onChanged: (value) {},
          ),
        ),
        SizedBox(height: 16),
        _CheckboxCard(
          title: 'Unchecked',
          description: 'Unselected checkbox',
          child: MPCheckbox(
            value: false,
            onChanged: (value) {},
          ),
        ),
        SizedBox(height: 16),
        _CheckboxCard(
          title: 'Indeterminate',
          description: 'Partially selected state',
          child: MPCheckbox(
            value: _indeterminate,
            checkState: MPCheckboxCheckState.indeterminate,
            onChanged: (value) => setState(() => _indeterminate = value ?? false),
          ),
        ),
      ],
    );
  }

  Widget _buildWithLabels(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Checkboxes with Labels',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _CheckboxCard(
          title: 'With Text Label',
          description: 'Checkbox with label text',
          child: Row(
            children: [
              MPCheckbox(
                value: _checked4,
                onChanged: (value) => setState(() => _checked4 = value ?? false),
              ),
              SizedBox(width: 12),
              Expanded(
                child: MPText.head('I agree to the terms and conditions'),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _CheckboxCard(
          title: 'With Icon',
          description: 'Checkbox with icon and label',
          child: Row(
            children: [
              Icon(Icons.lock, color: context.mp.primary),
              SizedBox(width: 12),
              MPCheckbox(
                value: false,
                onChanged: (value) {},
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MPText.head('Secure Connection'),
                    SizedBox(height: 4),
                    MPText.label(
                      'End-to-end encryption enabled',
                      style: TextStyle(
                        color: context.mp.subtitleColor,
                      ),
                    ),
                  ],
                ),
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
          title: 'Settings Toggles',
          description: 'Multiple settings checkboxes',
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
              children: [
                _SettingRow(
                  icon: Icons.notifications,
                  title: 'Push Notifications',
                  description: 'Receive push notifications',
                  value: true,
                  onChanged: (value) {},
                ),
                Divider(height: 1, color: context.mp.dividerColor),
                _SettingRow(
                  icon: Icons.email,
                  title: 'Email Notifications',
                  description: 'Receive email updates',
                  value: false,
                  onChanged: (value) {},
                ),
                Divider(height: 1, color: context.mp.dividerColor),
                _SettingRow(
                  icon: Icons.message,
                  title: 'SMS Notifications',
                  description: 'Receive SMS alerts',
                  value: true,
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
        _ExampleCard(
          title: 'Permissions',
          description: 'App permission checkboxes',
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
              children: [
                _PermissionRow(
                  icon: Icons.camera_alt,
                  title: 'Camera Access',
                  value: true,
                  onChanged: (value) {},
                ),
                SizedBox(height: 12),
                _PermissionRow(
                  icon: Icons.mic,
                  title: 'Microphone Access',
                  value: false,
                  onChanged: (value) {},
                ),
                SizedBox(height: 12),
                _PermissionRow(
                  icon: Icons.location_on,
                  title: 'Location Access',
                  value: true,
                  onChanged: (value) {},
                ),
                SizedBox(height: 12),
                _PermissionRow(
                  icon: Icons.folder,
                  title: 'File Access',
                  value: false,
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
        _ExampleCard(
          title: 'Select All',
          description: 'Checkbox group with select all',
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
              children: [
                Row(
                  children: [
                    MPCheckbox(
                      value: _indeterminate,
                      checkState: MPCheckboxCheckState.indeterminate,
                      onChanged: (value) => setState(() => _indeterminate = value ?? false),
                    ),
                    SizedBox(width: 12),
                    MPText.head('Select All Items'),
                  ],
                ),
                SizedBox(height: 16),
                Divider(height: 1, color: context.mp.dividerColor),
                SizedBox(height: 16),
                ...List.generate(4, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        MPCheckbox(
                          value: index < 2,
                          onChanged: (value) {},
                        ),
                        SizedBox(width: 12),
                        MPText.head('Item ${index + 1}'),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _CheckboxCard({
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

  Widget _SettingRow({
    required IconData icon,
    required String title,
    required String description,
    required bool value,
    required ValueChanged<bool?>? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: context.mp.primary),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MPText.head(title, fontSize: 14),
                SizedBox(height: 2),
                MPText.label(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: context.mp.subtitleColor,
                  ),
                ),
              ],
            ),
          ),
          MPCheckbox(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _PermissionRow({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool?>? onChanged,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: context.mp.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: context.mp.primary, size: 20),
        ),
        SizedBox(width: 16),
        Expanded(
          child: MPText.head(title, fontSize: 14),
        ),
        MPCheckbox(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

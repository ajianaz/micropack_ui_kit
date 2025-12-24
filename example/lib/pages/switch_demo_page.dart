import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class SwitchDemoPage extends StatefulWidget {
  const SwitchDemoPage({super.key});

  @override
  State<SwitchDemoPage> createState() => _SwitchDemoPageState();
}

class _SwitchDemoPageState extends State<SwitchDemoPage> {
  bool _switch1 = false;
  bool _switch2 = true;
  bool _switch3 = false;
  bool _switch4 = false;
  bool _switch5 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: MPText.head(
          'Switch Demo',
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
            _buildWithLabels(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildStates(context),
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
          'Switch Sizes',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _SwitchCard(
          title: 'Small',
          description: 'Compact size switch',
          child: MPSwitch(
            value: _switch1,
            width: 40.0,
            height: 24.0,
            toggleSize: 20.0,
            onToggle: (value) => setState(() => _switch1 = value),
          ),
        ),
        SizedBox(height: 16),
        _SwitchCard(
          title: 'Medium',
          description: 'Default medium size',
          child: MPSwitch(
            value: _switch2,
            onToggle: (value) => setState(() => _switch2 = value),
          ),
        ),
        SizedBox(height: 16),
        _SwitchCard(
          title: 'Large',
          description: 'Prominent large size',
          child: MPSwitch(
            value: _switch3,
            width: 60.0,
            height: 32.0,
            toggleSize: 28.0,
            onToggle: (value) => setState(() => _switch3 = value),
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
          'Switches with Labels',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _SwitchCard(
          title: 'With Label',
          description: 'Switch with text label',
          child: Row(
            children: [
              Expanded(
                child: MPText.head('Dark Mode'),
              ),
              MPSwitch(
                value: _switch4,
                onToggle: (value) => setState(() => _switch4 = value),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _SwitchCard(
          title: 'With Icon',
          description: 'Switch with icon and label',
          child: Row(
            children: [
              Icon(Icons.notifications, color: context.mp.primary),
              SizedBox(width: 12),
              Expanded(
                child: MPText.head('Notifications'),
              ),
              MPSwitch(
                value: _switch5,
                onToggle: (value) => setState(() => _switch5 = value),
              ),
            ],
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
          'Switch States',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _SwitchCard(
          title: 'Enabled',
          description: 'Active switch',
          child: MPSwitch(
            value: true,
            onToggle: (value) {},
          ),
        ),
        SizedBox(height: 16),
        _SwitchCard(
          title: 'Disabled',
          description: 'Disabled switch',
          child: MPSwitch(
            value: true,
            disabled: true,
            onToggle: (value) {},
          ),
        ),
        SizedBox(height: 16),
        _SwitchCard(
          title: 'Disabled Off',
          description: 'Disabled switch in off state',
          child: MPSwitch(
            value: false,
            disabled: true,
            onToggle: (value) {},
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
          title: 'Settings Toggle',
          description: 'Settings menu switch',
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
            child: Row(
              children: [
                Icon(Icons.settings, color: context.mp.primary),
                SizedBox(width: 16),
                Expanded(
                  child: MPText.head('Notifications'),
                ),
                MPSwitch(
                  value: true,
                  onToggle: (value) {},
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
        _ExampleCard(
          title: 'Feature Toggle',
          description: 'Feature enable/disable',
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
                Row(
                  children: [
                    Icon(Icons.wifi, color: context.mp.primary),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MPText.head('Wi-Fi', fontSize: 16),
                          MPText.label(
                            'Connected to "Home Network"',
                            style: TextStyle(
                              color: context.mp.subtitleColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MPSwitch(
                      value: true,
                      onToggle: (value) {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
        _ExampleCard(
          title: 'Privacy Controls',
          description: 'Multiple privacy settings',
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
                _PrivacyRow(
                  icon: Icons.location_on,
                  title: 'Location',
                  description: 'Allow apps to access location',
                  value: true,
                  onToggle: (value) {},
                ),
                Divider(height: 1, color: context.mp.dividerColor),
                _PrivacyRow(
                  icon: Icons.camera_alt,
                  title: 'Camera',
                  description: 'Allow apps to use camera',
                  value: false,
                  onToggle: (value) {},
                ),
                Divider(height: 1, color: context.mp.dividerColor),
                _PrivacyRow(
                  icon: Icons.mic,
                  title: 'Microphone',
                  description: 'Allow apps to record audio',
                  value: true,
                  onToggle: (value) {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _SwitchCard({
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
          child,
        ],
      ),
    );
  }

  Widget _PrivacyRow({
    required IconData icon,
    required String title,
    required String description,
    required bool value,
    required ValueChanged<bool>? onToggle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
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
          MPSwitch(
            value: value,
            onToggle: onToggle,
          ),
        ],
      ),
    );
  }
}

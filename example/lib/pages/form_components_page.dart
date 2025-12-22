import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class FormComponentsPage extends StatefulWidget {
  const FormComponentsPage({super.key});

  @override
  State<FormComponentsPage> createState() => _FormComponentsPageState();
}

class _FormComponentsPageState extends State<FormComponentsPage> {
  // Checkbox states
  bool _checkbox1 = false;
  bool _checkbox2 = true;
  bool _checkboxIndeterminate = false;

  // Switch states
  bool _switch1 = false;
  bool _switch2 = true;
  bool _switchDisabled = false;

  // Chip selection states
  int? _selectedChip;

  // Dropdown value
  int? _selectedDropdown;

  // Progress values
  double _linearProgress = 0.3;
  double _circularProgress = 0.7;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: MPText.head(
          'Form Components',
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
            _buildCheckboxSection(),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildSwitchSection(),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildBadgeSection(),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildChipSection(),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildTooltipSection(),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildProgressSection(),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildDropdownSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckboxSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head('Checkbox'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        MPText.label('Basic Checkboxes'),
        SizedBox(height: MPResponsivePadding.getXs(context)),
        Wrap(
          spacing: MPResponsivePadding.getSm(context),
          runSpacing: MPResponsivePadding.getXs(context),
          children: [
            MPCheckbox(
              value: _checkbox1,
              onChanged: (value) => setState(() => _checkbox1 = value ?? false),
            ),
            MPCheckbox(
              value: _checkbox2,
              onChanged: (value) => setState(() => _checkbox2 = value ?? false),
            ),
            MPCheckbox(
              value: false,
              onChanged: null,
              enabled: false,
            ),
          ],
        ),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        MPText.label('Checkbox Sizes'),
        SizedBox(height: MPResponsivePadding.getXs(context)),
        Wrap(
          spacing: MPResponsivePadding.getSm(context),
          children: [
            MPCheckbox(
              value: true,
              size: MPCheckboxSize.small,
              onChanged: (value) {},
            ),
            MPCheckbox(
              value: true,
              size: MPCheckboxSize.medium,
              onChanged: (value) {},
            ),
            MPCheckbox(
              value: true,
              size: MPCheckboxSize.large,
              onChanged: (value) {},
            ),
          ],
        ),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        MPText.label('Indeterminate Checkbox'),
        SizedBox(height: MPResponsivePadding.getXs(context)),
        MPCheckbox(
          checkState: MPCheckboxCheckState.indeterminate,
          value: false,
          onChanged: (value) => setState(() {
                _checkboxIndeterminate = value ?? false;
              }),
        ),
      ],
    );
  }

  Widget _buildSwitchSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head('Switch'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        MPText.label('Basic Switches'),
        SizedBox(height: MPResponsivePadding.getXs(context)),
        Wrap(
          spacing: MPResponsivePadding.getSm(context),
          children: [
            MPSwitch(
              value: _switch1,
              onToggle: (value) => setState(() => _switch1 = value),
            ),
            MPSwitch(
              value: _switch2,
              onToggle: (value) => setState(() => _switch2 = value),
            ),
            MPSwitch(
              value: _switchDisabled,
              onToggle: null,
              disabled: true,
            ),
          ],
        ),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        MPText.label('Switch Sizes'),
        SizedBox(height: MPResponsivePadding.getXs(context)),
        Wrap(
          spacing: MPResponsivePadding.getSm(context),
          children: [
            MPSwitch(
              value: true,
              width: 36,
              height: 20,
              onToggle: (value) {},
            ),
            MPSwitch(
              value: true,
              width: 44,
              height: 24,
              onToggle: (value) {},
            ),
            MPSwitch(
              value: true,
              width: 52,
              height: 28,
              onToggle: (value) {},
            ),
          ],
        ),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        MPText.label('Switch with ON/OFF Labels'),
        SizedBox(height: MPResponsivePadding.getXs(context)),
        MPSwitch(
          value: _switch1,
          onToggle: (value) => setState(() => _switch1 = value),
          showOnOff: true,
        ),
      ],
    );
  }

  Widget _buildBadgeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head('Badge'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        MPText.label('Badge Variants'),
        SizedBox(height: MPResponsivePadding.getXs(context)),
        Wrap(
          spacing: MPResponsivePadding.getXs(context),
          runSpacing: MPResponsivePadding.getXs(context),
          children: [
            MPBadge(label: 'Primary', variant: MPBadgeVariant.primary),
            MPBadge(label: 'Secondary', variant: MPBadgeVariant.secondary),
            MPBadge(label: 'Success', variant: MPBadgeVariant.success),
            MPBadge(label: 'Warning', variant: MPBadgeVariant.warning),
            MPBadge(label: 'Error', variant: MPBadgeVariant.error),
            MPBadge(label: 'Info', variant: MPBadgeVariant.info),
          ],
        ),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        MPText.label('Badge Sizes'),
        SizedBox(height: MPResponsivePadding.getXs(context)),
        Wrap(
          spacing: MPResponsivePadding.getXs(context),
          runSpacing: MPResponsivePadding.getXs(context),
          children: [
            MPBadge(label: 'Small', size: MPBadgeSize.small),
            MPBadge(label: 'Medium', size: MPBadgeSize.medium),
            MPBadge(label: 'Large', size: MPBadgeSize.large),
          ],
        ),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        MPText.label('Badges with Icons'),
        SizedBox(height: MPResponsivePadding.getXs(context)),
        Wrap(
          spacing: MPResponsivePadding.getXs(context),
          runSpacing: MPResponsivePadding.getXs(context),
          children: [
            MPBadge(
              label: 'New',
              leading: Icon(Icons.star, size: 12),
              variant: MPBadgeVariant.primary,
            ),
            MPBadge(
              label: 'Alert',
              leading: Icon(Icons.warning, size: 12),
              variant: MPBadgeVariant.warning,
            ),
            MPBadge(
              label: 'Done',
              trailing: Icon(Icons.check, size: 12),
              variant: MPBadgeVariant.success,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChipSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head('Chip'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        MPText.label('Basic Chips'),
        SizedBox(height: MPResponsivePadding.getXs(context)),
        Wrap(
          spacing: MPResponsivePadding.getXs(context),
          runSpacing: MPResponsivePadding.getXs(context),
          children: [
            MPChip(label: 'Primary', variant: MPChipVariant.primary),
            MPChip(label: 'Secondary', variant: MPChipVariant.secondary),
            MPChip(label: 'Success', variant: MPChipVariant.success),
            MPChip(label: 'Warning', variant: MPChipVariant.warning),
            MPChip(label: 'Error', variant: MPChipVariant.error),
            MPChip(label: 'Info', variant: MPChipVariant.info),
          ],
        ),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        MPText.label('Selectable Chips'),
        SizedBox(height: MPResponsivePadding.getXs(context)),
        Wrap(
          spacing: MPResponsivePadding.getXs(context),
          runSpacing: MPResponsivePadding.getXs(context),
          children: [1, 2, 3, 4].map((value) {
            return MPChip(
              label: 'Option $value',
              selected: _selectedChip == value,
              onPressed: () => setState(() => _selectedChip = value),
              variant: MPChipVariant.primary,
            );
          }).toList(),
        ),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        MPText.label('Dismissible Chips'),
        SizedBox(height: MPResponsivePadding.getXs(context)),
        Wrap(
          spacing: MPResponsivePadding.getXs(context),
          runSpacing: MPResponsivePadding.getXs(context),
          children: [
            MPChip(
              label: 'Remove Me',
              onDeleted: () => MPSnackbar.show(context,
                  message: 'Chip deleted', fontSize: 12),
              variant: MPChipVariant.secondary,
            ),
            MPChip(
              label: 'Delete This',
              onDeleted: () => MPSnackbar.show(context,
                  message: 'Chip deleted', fontSize: 12),
              variant: MPChipVariant.error,
            ),
          ],
        ),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        MPText.label('Chips with Avatars'),
        SizedBox(height: MPResponsivePadding.getXs(context)),
        Wrap(
          spacing: MPResponsivePadding.getXs(context),
          runSpacing: MPResponsivePadding.getXs(context),
          children: [
            MPChip(
              label: 'User 1',
              avatar: FlutterLogo(size: 24),
              variant: MPChipVariant.primary,
            ),
            MPChip(
              label: 'User 2',
              avatar: Icon(Icons.person, size: 20),
              variant: MPChipVariant.secondary,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTooltipSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head('Tooltip'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        MPText.label('Tooltips with Different Variants'),
        SizedBox(height: MPResponsivePadding.getXs(context)),
        Wrap(
          spacing: MPResponsivePadding.getSm(context),
          children: [
            MPTooltip(
              message: 'Primary tooltip',
              variant: MPTooltipVariant.primary,
              child: Icon(Icons.info, color: context.mp.primary),
            ),
            MPTooltip(
              message: 'Success tooltip',
              variant: MPTooltipVariant.success,
              child: Icon(Icons.check_circle, color: context.mp.successColor),
            ),
            MPTooltip(
              message: 'Warning tooltip',
              variant: MPTooltipVariant.warning,
              child: Icon(Icons.warning, color: context.mp.warningColor),
            ),
            MPTooltip(
              message: 'Error tooltip',
              variant: MPTooltipVariant.error,
              child: Icon(Icons.error, color: context.mp.errorColor),
            ),
            MPTooltip(
              message: 'Info tooltip',
              variant: MPTooltipVariant.info,
              child: Icon(Icons.info_outline, color: context.mp.infoColor),
            ),
          ],
        ),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        MPText.label('Long Press to See Tooltips'),
        SizedBox(height: MPResponsivePadding.getXs(context)),
        Row(
          children: [
            MPTooltip(
              message: 'This is a helpful tooltip for the button',
              child: MPButton(
                text: 'Hover Me',
                onPressed: () {},
                size: MPButtonSize.regular,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProgressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head('Progress Bar'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        MPText.label('Linear Progress'),
        SizedBox(height: MPResponsivePadding.getXs(context)),
        Column(
          children: [
            MPProgressBar.linear(
              value: _linearProgress,
              variant: MPProgressBarVariant.primary,
            ),
            SizedBox(height: MPResponsivePadding.getXs(context)),
            Slider(
              value: _linearProgress,
              onChanged: (value) => setState(() => _linearProgress = value),
              activeColor: context.mp.primary,
            ),
          ],
        ),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        MPText.label('Circular Progress'),
        SizedBox(height: MPResponsivePadding.getXs(context)),
        Wrap(
          spacing: MPResponsivePadding.getSm(context),
          children: [
            MPProgressBar.circular(
              value: _circularProgress,
              variant: MPProgressBarVariant.primary,
            ),
            MPProgressBar.circular(
              value: _circularProgress,
              variant: MPProgressBarVariant.success,
            ),
            MPProgressBar.circular(
              value: _circularProgress,
              variant: MPProgressBarVariant.warning,
            ),
          ],
        ),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        MPText.label('Progress Bar Sizes'),
        SizedBox(height: MPResponsivePadding.getXs(context)),
        Column(
          children: [
            MPProgressBar.linear(
              value: 0.5,
              size: MPProgressBarSize.small,
              variant: MPProgressBarVariant.primary,
            ),
            SizedBox(height: MPResponsivePadding.getXs(context)),
            MPProgressBar.linear(
              value: 0.5,
              size: MPProgressBarSize.medium,
              variant: MPProgressBarVariant.primary,
            ),
            SizedBox(height: MPResponsivePadding.getXs(context)),
            MPProgressBar.linear(
              value: 0.5,
              size: MPProgressBarSize.large,
              variant: MPProgressBarVariant.primary,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDropdownSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head('Dropdown'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        MPText.label('Basic Dropdowns'),
        SizedBox(height: MPResponsivePadding.getXs(context)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MPDropdown<int>(
              hint: 'Select an option',
              value: _selectedDropdown,
              items: const [
                MPDropdownItem(value: 1, label: 'Option 1'),
                MPDropdownItem(value: 2, label: 'Option 2'),
                MPDropdownItem(value: 3, label: 'Option 3'),
              ],
              onChanged: (value) => setState(() => _selectedDropdown = value),
              size: MPDropdownSize.medium,
            ),
            SizedBox(height: MPResponsivePadding.getSm(context)),
            if (_selectedDropdown != null)
              MPText.label('Selected: Option $_selectedDropdown'),
          ],
        ),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        MPText.label('Dropdown with Icons'),
        SizedBox(height: MPResponsivePadding.getXs(context)),
        MPDropdown<int>(
          hint: 'Select with icon',
          items: const [
            MPDropdownItem(
              value: 1,
              label: 'Home',
              leading: Icon(Icons.home),
            ),
            MPDropdownItem(
              value: 2,
              label: 'Settings',
              leading: Icon(Icons.settings),
            ),
            MPDropdownItem(
              value: 3,
              label: 'Profile',
              leading: Icon(Icons.person),
            ),
          ],
          onChanged: (value) {},
        ),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        MPText.label('Dropdown Sizes'),
        SizedBox(height: MPResponsivePadding.getXs(context)),
        Column(
          children: [
            MPDropdown<int>(
              hint: 'Small dropdown',
              size: MPDropdownSize.small,
              items: const [
                MPDropdownItem(value: 1, label: 'A'),
                MPDropdownItem(value: 2, label: 'B'),
              ],
              onChanged: (value) {},
            ),
            SizedBox(height: MPResponsivePadding.getXs(context)),
            MPDropdown<int>(
              hint: 'Large dropdown',
              size: MPDropdownSize.large,
              items: const [
                MPDropdownItem(value: 1, label: 'A'),
                MPDropdownItem(value: 2, label: 'B'),
              ],
              onChanged: (value) {},
            ),
          ],
        ),
      ],
    );
  }
}

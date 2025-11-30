import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class ButtonPage extends StatefulWidget {
  const ButtonPage({super.key});

  @override
  State<ButtonPage> createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  bool _isLoading1 = false;
  bool _isLoading2 = false;
  bool _isLoading3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Button'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MPText.head('Button Variants'),
            SizedBox(height: 16.h),

            // Primary Buttons
            MPText.label('Primary Buttons'),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                MPButton(
                  text: 'Small',
                  onPressed: () =>
                      _showSnackBar(context, 'Small button clicked'),
                  size: MPButtonSize.small,
                ),
                MPButton(
                  text: 'Regular',
                  onPressed: () =>
                      _showSnackBar(context, 'Regular button clicked'),
                  size: MPButtonSize.regular,
                ),
                MPButton(
                  text: 'Medium',
                  onPressed: () =>
                      _showSnackBar(context, 'Medium button clicked'),
                  size: MPButtonSize.medium,
                ),
                MPButton(
                  text: 'Large',
                  onPressed: () =>
                      _showSnackBar(context, 'Large button clicked'),
                  size: MPButtonSize.large,
                ),
                MPButton(
                  text: 'Full Width',
                  onPressed: () =>
                      _showSnackBar(context, 'Full width button clicked'),
                  widthInfinity: true,
                ),
              ],
            ),

            SizedBox(height: 24.h),

            // Outlined Buttons
            MPText.label('Outlined Buttons'),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                MPButton(
                  text: 'Outlined',
                  onPressed: () =>
                      _showSnackBar(context, 'Outlined button clicked'),
                  variant: MPButtonVariant.outlined,
                  size: MPButtonSize.regular,
                ),
                MPButton(
                  text: 'Outlined Large',
                  onPressed: () =>
                      _showSnackBar(context, 'Outlined large button clicked'),
                  variant: MPButtonVariant.outlined,
                  size: MPButtonSize.large,
                ),
                MPButton(
                  text: 'Outlined Disabled',
                  onPressed: () {},
                  enabled: false,
                  variant: MPButtonVariant.outlined,
                  size: MPButtonSize.regular,
                ),
              ],
            ),

            SizedBox(height: 24.h),

            // Ghost Buttons
            MPText.label('Ghost Buttons'),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                MPButton(
                  text: 'Ghost',
                  onPressed: () =>
                      _showSnackBar(context, 'Ghost button clicked'),
                  variant: MPButtonVariant.ghost,
                  size: MPButtonSize.regular,
                ),
                MPButton(
                  text: 'Ghost Large',
                  onPressed: () =>
                      _showSnackBar(context, 'Ghost large button clicked'),
                  variant: MPButtonVariant.ghost,
                  size: MPButtonSize.large,
                ),
                MPButton(
                  text: 'Ghost Disabled',
                  onPressed: () {},
                  enabled: false,
                  variant: MPButtonVariant.ghost,
                  size: MPButtonSize.regular,
                ),
              ],
            ),

            SizedBox(height: 24.h),

            MPText.head('Loading States'),
            SizedBox(height: 16.h),

            // Loading Buttons
            MPText.label('Buttons with Loading States'),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                MPButton(
                  text: _isLoading1 ? 'Loading...' : 'Click to Load',
                  onPressed: _isLoading1 ? null : () => _simulateLoading(1),
                  loading: _isLoading1,
                  size: MPButtonSize.regular,
                ),
                MPButton(
                  text: _isLoading2 ? 'Loading...' : 'Outlined Loading',
                  onPressed: _isLoading2 ? null : () => _simulateLoading(2),
                  loading: _isLoading2,
                  variant: MPButtonVariant.outlined,
                  size: MPButtonSize.regular,
                ),
                MPButton(
                  text: _isLoading3 ? 'Loading...' : 'Ghost Loading',
                  onPressed: _isLoading3 ? null : () => _simulateLoading(3),
                  loading: _isLoading3,
                  variant: MPButtonVariant.ghost,
                  size: MPButtonSize.regular,
                ),
              ],
            ),

            SizedBox(height: 24.h),

            MPText.head('Buttons with Icons'),
            SizedBox(height: 16.h),

            // Icon Buttons
            MPText.label('Buttons with Icons'),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                MPButton(
                  text: 'Save',
                  onPressed: () => _showSnackBar(context, 'Save clicked'),
                  icon: Icons.save,
                  size: MPButtonSize.regular,
                ),
                MPButton(
                  text: 'Download',
                  onPressed: () => _showSnackBar(context, 'Download clicked'),
                  icon: Icons.download,
                  iconPosition: MPButtonIconPosition.right,
                  variant: MPButtonVariant.outlined,
                  size: MPButtonSize.regular,
                ),
                MPButton(
                  text: 'Share',
                  onPressed: () => _showSnackBar(context, 'Share clicked'),
                  icon: Icons.share,
                  iconPosition: MPButtonIconPosition.top,
                  variant: MPButtonVariant.ghost,
                  size: MPButtonSize.regular,
                ),
              ],
            ),

            SizedBox(height: 24.h),

            MPText.head('New Button Variants'),
            SizedBox(height: 16.h),

            // New Button Variants
            MPText.label('Text, Info, and Warning Buttons'),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                MPButton(
                  text: 'Text Button',
                  onPressed: () =>
                      _showSnackBar(context, 'Text button clicked'),
                  variant: MPButtonVariant.text,
                  size: MPButtonSize.regular,
                ),
                MPButton(
                  text: 'Info',
                  onPressed: () =>
                      _showSnackBar(context, 'Info button clicked'),
                  icon: Icons.info,
                  variant: MPButtonVariant.info,
                  size: MPButtonSize.regular,
                ),
                MPButton(
                  text: 'Warning',
                  onPressed: () =>
                      _showSnackBar(context, 'Warning button clicked'),
                  icon: Icons.warning,
                  variant: MPButtonVariant.warning,
                  size: MPButtonSize.regular,
                ),
              ],
            ),

            MPText.head('Custom Styled Buttons'),
            SizedBox(height: 16.h),

            // Custom Styled Buttons
            MPText.label('Buttons with Custom Colors and Styles'),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                MPButton(
                  text: 'Success',
                  onPressed: () =>
                      _showSnackBar(context, 'Success button clicked'),
                  variant: MPButtonVariant.success,
                  size: MPButtonSize.regular,
                ),
                MPButton(
                  text: 'Warning',
                  onPressed: () =>
                      _showSnackBar(context, 'Warning button clicked'),
                  variant: MPButtonVariant.warning,
                  size: MPButtonSize.regular,
                ),
                MPButton(
                  text: 'Danger',
                  onPressed: () =>
                      _showSnackBar(context, 'Danger button clicked'),
                  variant: MPButtonVariant.danger,
                  size: MPButtonSize.regular,
                ),
                MPButton(
                  text: 'Custom Border',
                  onPressed: () =>
                      _showSnackBar(context, 'Custom border button clicked'),
                  variant: MPButtonVariant.outlined,
                  strokeColor: Colors.purple,
                  strokeWidth: 2,
                  textColor: Colors.purple,
                  size: MPButtonSize.regular,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _simulateLoading(int buttonIndex) {
    setState(() {
      switch (buttonIndex) {
        case 1:
          _isLoading1 = true;
          break;
        case 2:
          _isLoading2 = true;
          break;
        case 3:
          _isLoading3 = true;
          break;
      }
    });

    // Simulate loading for 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          switch (buttonIndex) {
            case 1:
              _isLoading1 = false;
              break;
            case 2:
              _isLoading2 = false;
              break;
            case 3:
              _isLoading3 = false;
              break;
          }
        });
        _showSnackBar(context, 'Loading completed!');
      }
    });
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

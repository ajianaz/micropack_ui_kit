import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class ToastPage extends StatelessWidget {
  const ToastPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: MPText.head(
          'Toast',
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
            _buildBasicToasts(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildVariantToasts(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildPositionToasts(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildDurationToasts(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildCustomToasts(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicToasts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head('Basic Toasts'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        MPText.label('Default Toast'),
        SizedBox(height: MPResponsivePadding.getXs(context)),
        MPButton(
          text: 'Show Default Toast',
          onPressed: () {
            MPToast.show(
              context,
              message: 'This is a default toast message',
            );
          },
          size: MPButtonSize.regular,
        ),
      ],
    );
  }

  Widget _buildVariantToasts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head('Toast Variants'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        Wrap(
          spacing: MPResponsivePadding.getSm(context),
          runSpacing: MPResponsivePadding.getXs(context),
          children: [
            MPButton(
              text: 'Success',
              onPressed: () {
                MPToast.success(
                  context,
                  message: 'Action completed successfully',
                );
              },
              size: MPButtonSize.regular,
            ),
            MPButton(
              text: 'Error',
              onPressed: () {
                MPToast.error(
                  context,
                  message: 'An error occurred',
                );
              },
              size: MPButtonSize.regular,
            ),
            MPButton(
              text: 'Warning',
              onPressed: () {
                MPToast.warning(
                  context,
                  message: 'Please check your input',
                );
              },
              size: MPButtonSize.regular,
            ),
            MPButton(
              text: 'Info',
              onPressed: () {
                MPToast.info(
                  context,
                  message: 'Here is some information',
                );
              },
              size: MPButtonSize.regular,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPositionToasts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head('Toast Positions'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        Wrap(
          spacing: MPResponsivePadding.getSm(context),
          runSpacing: MPResponsivePadding.getXs(context),
          children: [
            MPButton(
              text: 'Top',
              onPressed: () {
                MPToast.show(
                  context,
                  message: 'Toast at the top',
                  position: MPToastPosition.top,
                );
              },
              size: MPButtonSize.regular,
            ),
            MPButton(
              text: 'Center',
              onPressed: () {
                MPToast.show(
                  context,
                  message: 'Toast in the center',
                  position: MPToastPosition.center,
                );
              },
              size: MPButtonSize.regular,
            ),
            MPButton(
              text: 'Bottom',
              onPressed: () {
                MPToast.show(
                  context,
                  message: 'Toast at the bottom',
                  position: MPToastPosition.bottom,
                );
              },
              size: MPButtonSize.regular,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDurationToasts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head('Toast Durations'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        Wrap(
          spacing: MPResponsivePadding.getSm(context),
          runSpacing: MPResponsivePadding.getXs(context),
          children: [
            MPButton(
              text: 'Short (2s)',
              onPressed: () {
                MPToast.show(
                  context,
                  message: 'This will disappear quickly',
                  duration: MPToastDuration.short,
                );
              },
              size: MPButtonSize.regular,
            ),
            MPButton(
              text: 'Medium (3s)',
              onPressed: () {
                MPToast.show(
                  context,
                  message: 'This is the default duration',
                  duration: MPToastDuration.medium,
                );
              },
              size: MPButtonSize.regular,
            ),
            MPButton(
              text: 'Long (5s)',
              onPressed: () {
                MPToast.show(
                  context,
                  message: 'This will stay longer',
                  duration: MPToastDuration.long,
                );
              },
              size: MPButtonSize.regular,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCustomToasts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head('Custom Toasts'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        MPText.label('With Leading Icon'),
        SizedBox(height: MPResponsivePadding.getXs(context)),
        MPButton(
          text: 'Show with Star Icon',
          onPressed: () {
            MPToast.show(
              context,
              message: 'Featured item added',
              leading: Icon(
                Icons.star,
                color: Colors.white,
                size: 20,
              ),
            );
          },
          size: MPButtonSize.regular,
        ),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        MPText.label('With Trailing Icon'),
        SizedBox(height: MPResponsivePadding.getXs(context)),
        MPButton(
          text: 'Show with Close Icon',
          onPressed: () {
            MPToast.show(
              context,
              message: 'Tap to dismiss',
              trailing: Icon(
                Icons.close,
                color: Colors.white,
                size: 20,
              ),
            );
          },
          size: MPButtonSize.regular,
        ),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        MPText.label('Non-dismissible'),
        SizedBox(height: MPResponsivePadding.getXs(context)),
        MPButton(
          text: 'Show Non-dismissible Toast',
          onPressed: () {
            MPToast.show(
              context,
              message: 'This toast cannot be dismissed by tapping',
              dismissible: false,
              duration: MPToastDuration.short,
            );
          },
          size: MPButtonSize.regular,
        ),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        MPText.label('Custom Icon'),
        SizedBox(height: MPResponsivePadding.getXs(context)),
        MPButton(
          text: 'Show with Custom Icon',
          onPressed: () {
            MPToast.show(
              context,
              message: 'Custom notification',
              icon: Icons.notifications_active,
            );
          },
          size: MPButtonSize.regular,
        ),
      ],
    );
  }
}

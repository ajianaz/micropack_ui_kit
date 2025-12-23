import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class EmptyStateDemoPage extends StatelessWidget {
  const EmptyStateDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: MPText.head(
          'Empty State',
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
            _buildPredefinedStates(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildSizes(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildCustomStates(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildWithActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPredefinedStates(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head('Predefined States'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        Column(
          children: [
            _StateCard(
              title: 'No Data',
              child: MPEmptyState(
                variant: MPEmptyStateVariant.noData,
                size: MPEmptyStateSize.small,
              ),
            ),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            _StateCard(
              title: 'No Results',
              child: MPEmptyState(
                variant: MPEmptyStateVariant.noResults,
                size: MPEmptyStateSize.small,
              ),
            ),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            _StateCard(
              title: 'No Network',
              child: MPEmptyState(
                variant: MPEmptyStateVariant.noNetwork,
                size: MPEmptyStateSize.small,
              ),
            ),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            _StateCard(
              title: 'Error',
              child: MPEmptyState(
                variant: MPEmptyStateVariant.error,
                size: MPEmptyStateSize.small,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSizes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head('State Sizes'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        Column(
          children: [
            _StateCard(
              title: 'Small',
              child: MPEmptyState(
                variant: MPEmptyStateVariant.noData,
                size: MPEmptyStateSize.small,
              ),
            ),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            _StateCard(
              title: 'Medium',
              child: MPEmptyState(
                variant: MPEmptyStateVariant.noData,
                size: MPEmptyStateSize.medium,
              ),
            ),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            _StateCard(
              title: 'Large',
              child: MPEmptyState(
                variant: MPEmptyStateVariant.noData,
                size: MPEmptyStateSize.large,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCustomStates(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head('Custom States'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        Column(
          children: [
            _StateCard(
              title: 'Custom Title & Description',
              child: MPEmptyState(
                variant: MPEmptyStateVariant.custom,
                size: MPEmptyStateSize.medium,
                title: 'Custom Empty State',
                description: 'This is a custom empty state with custom text.',
              ),
            ),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            _StateCard(
              title: 'Custom Icon',
              child: MPEmptyState(
                variant: MPEmptyStateVariant.custom,
                size: MPEmptyStateSize.medium,
                icon: Icons.favorite_border,
                title: 'No Favorites',
                description: 'You haven\'t added any favorites yet.',
              ),
            ),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            _StateCard(
              title: 'Custom Image',
              child: MPEmptyState(
                variant: MPEmptyStateVariant.custom,
                size: MPEmptyStateSize.medium,
                image: FlutterLogo(size: 64),
                title: 'No Content',
                description: 'Custom image placeholder shown.',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWithActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head('States with Actions'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        Column(
          children: [
            _StateCard(
              title: 'With Action Button',
              child: MPEmptyState(
                variant: MPEmptyStateVariant.noResults,
                size: MPEmptyStateSize.medium,
                actionLabel: 'Clear Search',
                onAction: () {
                  MPSnackbar.show(
                    context,
                    message: 'Search cleared!',
                    fontSize: 12,
                  );
                },
              ),
            ),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            _StateCard(
              title: 'Retry Action',
              child: MPEmptyState(
                variant: MPEmptyStateVariant.noNetwork,
                size: MPEmptyStateSize.medium,
                actionLabel: 'Retry',
                onAction: () {
                  MPSnackbar.show(
                    context,
                    message: 'Retrying...',
                    fontSize: 12,
                  );
                },
              ),
            ),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            _StateCard(
              title: 'Go Back Action',
              child: MPEmptyState(
                variant: MPEmptyStateVariant.error,
                size: MPEmptyStateSize.medium,
                actionLabel: 'Go Back',
                onAction: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StateCard extends StatelessWidget {
  const _StateCard({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Padding(
            padding: const EdgeInsets.all(12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: MPText.head(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: context.mp.textColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: child,
          ),
        ],
      ),
    );
  }
}

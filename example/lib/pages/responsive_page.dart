import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

/// Responsive design showcase page
class ResponsivePage extends StatelessWidget {
  const ResponsivePage({super.key});

  Widget _buildResponsiveContent(
    BuildContext context,
    Orientation orientation,
    BoxConstraints constraints,
  ) {
    return MPOrientationLayout(
      portraitLayout: MPOrientationLayoutType.vertical,
      landscapeLayout: MPOrientationLayoutType.horizontal,
      spacing: 16,
      padding: MPResponsivePadding.card(context),
      children: [
        Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color: context.mp.primarySurface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: MPText(
              'Responsive Content',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color: context.mp.primarySurface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: MPText(
              'Responsive Content',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MPText('Responsive Design Showcase'),
        backgroundColor: context.mp.backgroundColor,
      ),
      backgroundColor: context.mp.backgroundColor,
      body: SingleChildScrollView(
        padding: MPResponsivePadding.page(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            const SizedBox(height: 24),
            _buildSectionHeader('Responsive Breakpoints'),
            const SizedBox(height: 16),

            // Breakpoint indicator
            MPResponsiveContainer(
              mobileHeight: 80,
              tabletHeight: 100,
              desktopHeight: 120,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: context.mp.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: MPText(
                    _getBreakpointText(context),
                    color: context.mp.neutral10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Responsive cards section
            _buildSectionHeader('Responsive Cards'),
            const SizedBox(height: 16),

            // Responsive card grid
            MPResponsiveGrid(
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildResponsiveCard(
                  context,
                  title: 'Basic Card',
                  subtitle: 'Adapts to screen size',
                  color: context.mp.primary,
                ),
                _buildResponsiveCard(
                  context,
                  title: 'Media Card',
                  subtitle: 'With responsive image',
                  color: context.mp.successColor,
                ),
                _buildResponsiveCard(
                  context,
                  title: 'Product Card',
                  subtitle: 'Adaptive pricing display',
                  color: context.mp.warningColor,
                ),
                _buildResponsiveCard(
                  context,
                  title: 'Profile Card',
                  subtitle: 'Responsive user info',
                  color: context.mp.errorColor,
                ),
                _buildResponsiveCard(
                  context,
                  title: 'Dashboard Card',
                  subtitle: 'Data visualization',
                  color: context.mp.infoColor,
                ),
                _buildResponsiveCard(
                  context,
                  title: 'Notification Card',
                  subtitle: 'Alert system',
                  color: context.mp.neutral70,
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Orientation-aware section
            _buildSectionHeader('Orientation-Aware Layouts'),
            const SizedBox(height: 16),

            MPOrientationAware(
              builder: _buildResponsiveContent,
            ),
            const SizedBox(height: 32),

            // Responsive spacing section
            _buildSectionHeader('Responsive Spacing'),
            const SizedBox(height: 16),

            _buildSpacingDemo(context),
            const SizedBox(height: 32),

            // Responsive constraints section
            _buildSectionHeader('Responsive Constraints'),
            const SizedBox(height: 16),

            _buildConstraintsDemo(context),
            const SizedBox(height: 32),

            // Responsive typography section
            _buildSectionHeader('Responsive Typography'),
            const SizedBox(height: 16),

            _buildTypographyDemo(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Builder(
      builder: (context) => MPText(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: context.mp.neutral90,
        ),
      ),
    );
  }

  String _getBreakpointText(BuildContext context) {
    final deviceSize = MPResponsive.getDeviceSize(context);
    final orientation = MPResponsive.getOrientation(context);

    String sizeText;
    switch (deviceSize) {
      case MPDeviceSize.smallMobile:
        sizeText = 'Small Mobile';
        break;
      case MPDeviceSize.mobile:
        sizeText = 'Mobile';
        break;
      case MPDeviceSize.largeMobile:
        sizeText = 'Large Mobile';
        break;
      case MPDeviceSize.smallTablet:
        sizeText = 'Small Tablet';
        break;
      case MPDeviceSize.tablet:
        sizeText = 'Tablet';
        break;
      case MPDeviceSize.largeTablet:
        sizeText = 'Large Tablet';
        break;
      case MPDeviceSize.smallDesktop:
        sizeText = 'Small Desktop';
        break;
      case MPDeviceSize.desktop:
        sizeText = 'Desktop';
        break;
      case MPDeviceSize.largeDesktop:
        sizeText = 'Large Desktop';
        break;
      case MPDeviceSize.ultraWide:
        sizeText = 'Ultra-Wide';
        break;
    }

    return '$sizeText • ${orientation.name} • '
        '${MediaQuery.of(context).size.width.toInt()}px';
  }

  Widget _buildResponsiveCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return MPCard(
      variant: MPCardVariant.filled,
      responsive: MPCardResponsiveConfig(
        mobileLayout: MPCardLayout.vertical,
        tabletLayout: MPCardLayout.horizontal,
        desktopLayout: MPCardLayout.horizontal,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 12),
          MPText(
            title,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 4),
          MPText.small(
            subtitle,
            color: context.mp.neutral70,
          ),
        ],
      ),
    );
  }

  Widget _buildSpacingDemo(BuildContext context) {
    return Container(
      color: context.mp.neutral20,
      padding: MPResponsivePadding.standard(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MPText(
            'Responsive Spacing Demo',
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: MPResponsivePadding.getSm(context)),
          Container(
            color: context.mp.primarySurface,
            padding: MPResponsivePadding.card(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MPText(
                    'Extra Small: ${MPResponsivePadding.getXs(context).toStringAsFixed(1)}px'),
                SizedBox(height: MPResponsivePadding.getXs(context)),
                Container(
                  color: context.mp.primary,
                  height: MPResponsivePadding.getXs(context),
                  width: double.infinity,
                ),
                SizedBox(height: MPResponsivePadding.getSm(context)),
                MPText(
                    'Small: ${MPResponsivePadding.getSm(context).toStringAsFixed(1)}px'),
                SizedBox(height: MPResponsivePadding.getSm(context)),
                Container(
                  color: context.mp.primary,
                  height: MPResponsivePadding.getSm(context),
                  width: double.infinity,
                ),
                SizedBox(height: MPResponsivePadding.getSm(context)),
                MPText(
                    'Medium: ${MPResponsivePadding.getMd(context).toStringAsFixed(1)}px'),
                SizedBox(height: MPResponsivePadding.getMd(context)),
                Container(
                  color: context.mp.primary,
                  height: MPResponsivePadding.getMd(context),
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConstraintsDemo(BuildContext context) {
    return MPResponsiveConstraints(
      mobileConstraints: const BoxConstraints(maxWidth: 300),
      tabletConstraints: const BoxConstraints(maxWidth: 500),
      desktopConstraints: const BoxConstraints(maxWidth: 700),
      child: Container(
        color: context.mp.primarySurface,
        padding: MPResponsivePadding.card(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MPText(
              'Responsive Constraints Demo',
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 12),
            MPText(
              'This container adapts its maximum width based on screen size:',
              color: context.mp.neutral70,
            ),
            const SizedBox(height: 8),
            MPText(
              '• Mobile: Max 300px\n• Tablet: Max 500px\n• Desktop: Max 700px',
              color: context.mp.neutral70,
            ),
            const SizedBox(height: 12),
            Container(
              color: context.mp.primary,
              width: double.infinity,
              height: 40,
              child: Center(
                child: MPText(
                  'Width-constrained container',
                  color: context.mp.neutral10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypographyDemo(BuildContext context) {
    return Container(
      color: context.mp.neutral20,
      padding: MPResponsivePadding.standard(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MPText(
            'Responsive Typography Demo',
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: MPResponsivePadding.getMd(context)),
          _buildResponsiveText(context, 'Heading 1', 32, FontWeight.w700),
          SizedBox(height: MPResponsivePadding.getSm(context)),
          _buildResponsiveText(context, 'Heading 2', 24, FontWeight.w600),
          SizedBox(height: MPResponsivePadding.getSm(context)),
          _buildResponsiveText(context, 'Heading 3', 20, FontWeight.w600),
          SizedBox(height: MPResponsivePadding.getSm(context)),
          _buildResponsiveText(context, 'Body Text', 16, FontWeight.w400),
          SizedBox(height: MPResponsivePadding.getSm(context)),
          _buildResponsiveText(context, 'Small Text', 14, FontWeight.w400),
          SizedBox(height: MPResponsivePadding.getSm(context)),
          _buildResponsiveText(context, 'Caption', 12, FontWeight.w400),
        ],
      ),
    );
  }

  Widget _buildResponsiveText(
    BuildContext context,
    String text,
    double baseSize,
    FontWeight weight,
  ) {
    final responsiveSize = MPResponsive.getFontSize(
      context: context,
      mobile: baseSize * 0.875,
      tablet: baseSize,
      desktop: baseSize * 1.125,
    );

    return MPText(
      text,
      style: TextStyle(
        fontSize: responsiveSize,
        fontWeight: weight,
      ),
    );
  }
}

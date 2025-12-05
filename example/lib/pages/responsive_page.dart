import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

/// Responsive design showcase page with comprehensive theme integration
class ResponsivePage extends StatefulWidget {
  const ResponsivePage({super.key});

  @override
  State<ResponsivePage> createState() => _ResponsivePageState();
}

class _ResponsivePageState extends State<ResponsivePage>
    with TickerProviderStateMixin {
  late AnimationController _themeAnimationController;
  late Animation<double> _themeAnimation;
  bool _isInitialized = false;
  String? _initializationError;

  @override
  void initState() {
    super.initState();
    _initializeThemeManager();
    _setupAnimationController();
  }

  Future<void> _initializeThemeManager() async {
    try {
      if (!MPThemeManager.instance.isInitialized) {
        await MPThemeManager.initialize();
      }

      // Add theme listener
      MPThemeManager.instance.addListener(_onThemeChanged);

      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      setState(() {
        _initializationError = e.toString();
        _isInitialized = true;
      });
    }
  }

  void _setupAnimationController() {
    _themeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _themeAnimation = CurvedAnimation(
      parent: _themeAnimationController,
      curve: Curves.easeInOut,
    );
    _themeAnimationController.forward();
  }

  void _onThemeChanged() {
    if (mounted) {
      setState(() {
        // Rebuild UI when theme changes
      });
    }
  }

  @override
  void dispose() {
    // Remove theme listener
    if (_isInitialized) {
      MPThemeManager.instance.removeListener(_onThemeChanged);
    }
    _themeAnimationController.dispose();
    super.dispose();
  }

  Widget _buildResponsiveContent(
    BuildContext context,
    Orientation orientation,
    BoxConstraints constraints,
  ) {
    final colorTheme = MPThemeManager.instance.getCurrentColorTheme(context);

    return MPOrientationLayout(
      portraitLayout: MPOrientationLayoutType.vertical,
      landscapeLayout: MPOrientationLayoutType.horizontal,
      spacing: 16,
      padding: MPResponsivePadding.card(context),
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color: colorTheme?.primarySurface ?? context.mp.primarySurface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: (colorTheme?.neutral20 ?? Colors.grey.shade300)
                    .withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: MPText(
              'Responsive Content',
              style: MPTextStyle.heading3(
                color: colorTheme?.neutral90 ?? context.mp.neutral90,
              ),
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color: colorTheme?.primarySurface ?? context.mp.primarySurface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: (colorTheme?.neutral20 ?? Colors.grey.shade300)
                    .withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: MPText(
              'Responsive Content',
              style: MPTextStyle.heading3(
                color: colorTheme?.neutral90 ?? context.mp.neutral90,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              MPText(
                _initializationError != null
                    ? 'Error: $_initializationError'
                    : 'Initializing theme manager...',
                style: MPTextStyle.body1(),
              ),
            ],
          ),
        ),
      );
    }

    final colorTheme = MPThemeManager.instance.getCurrentColorTheme(context);

    return Scaffold(
      appBar: AppBar(
        title: MPText(
          'Responsive Design Showcase',
          style: MPTextStyle.heading2(
            color: colorTheme?.neutral90 ?? context.mp.neutral90,
          ),
        ),
        backgroundColor:
            colorTheme?.primarySurface ?? context.mp.backgroundColor,
        elevation: 0,
      ),
      backgroundColor: colorTheme?.primarySurface ?? context.mp.backgroundColor,
      body: AnimatedBuilder(
        animation: _themeAnimation,
        builder: (context, child) {
          return FadeTransition(
            opacity: _themeAnimation,
            child: SingleChildScrollView(
              padding: MPResponsivePadding.page(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  _buildSectionHeader('Responsive Breakpoints', colorTheme),
                  const SizedBox(height: 16),

                  // Breakpoint indicator
                  MPResponsiveContainer(
                    mobileHeight: 80,
                    tabletHeight: 100,
                    desktopHeight: 120,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: colorTheme?.primary ?? context.mp.primary,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: (colorTheme?.primary ?? context.mp.primary)
                                .withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: MPText(
                          _getBreakpointText(context),
                          style: MPTextStyle.heading3(
                            color:
                                colorTheme?.neutral10 ?? context.mp.neutral10,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Responsive cards section
                  _buildSectionHeader('Responsive Cards', colorTheme),
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
                        color: colorTheme?.primary ?? context.mp.primary,
                        colorTheme: colorTheme,
                      ),
                      _buildResponsiveCard(
                        context,
                        title: 'Media Card',
                        subtitle: 'With responsive image',
                        color: context.mp.successColor,
                        colorTheme: colorTheme,
                      ),
                      _buildResponsiveCard(
                        context,
                        title: 'Product Card',
                        subtitle: 'Adaptive pricing display',
                        color: context.mp.warningColor,
                        colorTheme: colorTheme,
                      ),
                      _buildResponsiveCard(
                        context,
                        title: 'Profile Card',
                        subtitle: 'Responsive user info',
                        color: context.mp.errorColor,
                        colorTheme: colorTheme,
                      ),
                      _buildResponsiveCard(
                        context,
                        title: 'Dashboard Card',
                        subtitle: 'Data visualization',
                        color: context.mp.infoColor,
                        colorTheme: colorTheme,
                      ),
                      _buildResponsiveCard(
                        context,
                        title: 'Notification Card',
                        subtitle: 'Alert system',
                        color: colorTheme?.neutral70 ?? context.mp.neutral70,
                        colorTheme: colorTheme,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Orientation-aware section
                  _buildSectionHeader('Orientation-Aware Layouts', colorTheme),
                  const SizedBox(height: 16),

                  MPOrientationAware(
                    builder: _buildResponsiveContent,
                  ),
                  const SizedBox(height: 32),

                  // Responsive spacing section
                  _buildSectionHeader('Responsive Spacing', colorTheme),
                  const SizedBox(height: 16),

                  _buildSpacingDemo(context, colorTheme),
                  const SizedBox(height: 32),

                  // Responsive constraints section
                  _buildSectionHeader('Responsive Constraints', colorTheme),
                  const SizedBox(height: 16),

                  _buildConstraintsDemo(context, colorTheme),
                  const SizedBox(height: 32),

                  // Responsive typography section
                  _buildSectionHeader('Responsive Typography', colorTheme),
                  const SizedBox(height: 16),

                  _buildTypographyDemo(context, colorTheme),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title, MPColorTheme? colorTheme) {
    return MPText(
      title,
      style: MPTextStyle.heading2(
        color: colorTheme?.neutral90 ?? context.mp.neutral90,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  String _getBreakpointText(BuildContext context) {
    final deviceSize = MPResponsive.getDeviceSize(context);
    final orientation = MPResponsive.getOrientation(context);
    final mediaQueryData = MediaQuery.maybeOf(context);
    final screenWidth = mediaQueryData?.size.width ?? 0;

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

    return '$sizeText • ${orientation.name} • ${screenWidth.toInt()}px';
  }

  Widget _buildResponsiveCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required Color color,
    required MPColorTheme? colorTheme,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: MPCard(
        variant: MPCardVariant.filled,
        responsive: MPCardResponsiveConfig(
          mobileLayout: MPCardLayout.vertical,
          tabletLayout: MPCardLayout.horizontal,
          desktopLayout: MPCardLayout.horizontal,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            MPText(
              title,
              style: MPTextStyle.heading3(
                color: colorTheme?.neutral90 ?? context.mp.neutral90,
              ),
            ),
            const SizedBox(height: 4),
            MPText(
              subtitle,
              style: MPTextStyle.body1(
                color: colorTheme?.neutral70 ?? context.mp.neutral70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpacingDemo(BuildContext context, MPColorTheme? colorTheme) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: colorTheme?.neutral20 ?? context.mp.neutral20,
      padding: MPResponsivePadding.standard(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MPText(
            'Responsive Spacing Demo',
            style: MPTextStyle.heading3(
              color: colorTheme?.neutral90 ?? context.mp.neutral90,
            ),
          ),
          SizedBox(height: MPResponsivePadding.getSm(context)),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            color: colorTheme?.primarySurface ?? context.mp.primarySurface,
            padding: MPResponsivePadding.card(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MPText(
                  'Extra Small: ${MPResponsivePadding.getXs(context).toStringAsFixed(1)}px',
                  style: MPTextStyle.body1(
                    color: colorTheme?.neutral90 ?? context.mp.neutral90,
                  ),
                ),
                SizedBox(height: MPResponsivePadding.getXs(context)),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  color: colorTheme?.primary ?? context.mp.primary,
                  height: MPResponsivePadding.getXs(context),
                  width: double.infinity,
                ),
                SizedBox(height: MPResponsivePadding.getSm(context)),
                MPText(
                  'Small: ${MPResponsivePadding.getSm(context).toStringAsFixed(1)}px',
                  style: MPTextStyle.body1(
                    color: colorTheme?.neutral90 ?? context.mp.neutral90,
                  ),
                ),
                SizedBox(height: MPResponsivePadding.getSm(context)),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  color: colorTheme?.primary ?? context.mp.primary,
                  height: MPResponsivePadding.getSm(context),
                  width: double.infinity,
                ),
                SizedBox(height: MPResponsivePadding.getSm(context)),
                MPText(
                  'Medium: ${MPResponsivePadding.getMd(context).toStringAsFixed(1)}px',
                  style: MPTextStyle.body1(
                    color: colorTheme?.neutral90 ?? context.mp.neutral90,
                  ),
                ),
                SizedBox(height: MPResponsivePadding.getMd(context)),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  color: colorTheme?.primary ?? context.mp.primary,
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

  Widget _buildConstraintsDemo(BuildContext context, MPColorTheme? colorTheme) {
    return MPResponsiveConstraints(
      mobileConstraints: const BoxConstraints(maxWidth: 300),
      tabletConstraints: const BoxConstraints(maxWidth: 500),
      desktopConstraints: const BoxConstraints(maxWidth: 700),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        color: colorTheme?.primarySurface ?? context.mp.primarySurface,
        padding: MPResponsivePadding.card(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MPText(
              'Responsive Constraints Demo',
              style: MPTextStyle.heading3(
                color: colorTheme?.neutral90 ?? context.mp.neutral90,
              ),
            ),
            const SizedBox(height: 12),
            MPText(
              'This container adapts its maximum width based on screen size:',
              style: MPTextStyle.body1(
                color: colorTheme?.neutral70 ?? context.mp.neutral70,
              ),
            ),
            const SizedBox(height: 8),
            MPText(
              '• Mobile: Max 300px\n• Tablet: Max 500px\n• Desktop: Max 700px',
              style: MPTextStyle.body1(
                color: colorTheme?.neutral70 ?? context.mp.neutral70,
              ),
            ),
            const SizedBox(height: 12),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              color: colorTheme?.primary ?? context.mp.primary,
              width: double.infinity,
              height: 40,
              child: Center(
                child: MPText(
                  'Width-constrained container',
                  style: MPTextStyle.body1(
                    color: colorTheme?.neutral10 ?? context.mp.neutral10,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypographyDemo(BuildContext context, MPColorTheme? colorTheme) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: colorTheme?.neutral20 ?? context.mp.neutral20,
      padding: MPResponsivePadding.standard(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MPText(
            'Responsive Typography Demo',
            style: MPTextStyle.heading3(
              color: colorTheme?.neutral90 ?? context.mp.neutral90,
            ),
          ),
          SizedBox(height: MPResponsivePadding.getMd(context)),
          _buildResponsiveText(
              context, 'Heading 1', 32, FontWeight.w700, colorTheme),
          SizedBox(height: MPResponsivePadding.getSm(context)),
          _buildResponsiveText(
              context, 'Heading 2', 24, FontWeight.w600, colorTheme),
          SizedBox(height: MPResponsivePadding.getSm(context)),
          _buildResponsiveText(
              context, 'Heading 3', 20, FontWeight.w600, colorTheme),
          SizedBox(height: MPResponsivePadding.getSm(context)),
          _buildResponsiveText(
              context, 'Body Text', 16, FontWeight.w400, colorTheme),
          SizedBox(height: MPResponsivePadding.getSm(context)),
          _buildResponsiveText(
              context, 'Small Text', 14, FontWeight.w400, colorTheme),
          SizedBox(height: MPResponsivePadding.getSm(context)),
          _buildResponsiveText(
              context, 'Caption', 12, FontWeight.w400, colorTheme),
        ],
      ),
    );
  }

  Widget _buildResponsiveText(
    BuildContext context,
    String text,
    double baseSize,
    FontWeight weight,
    MPColorTheme? colorTheme,
  ) {
    final responsiveSize = MPResponsive.getFontSize(
      context: context,
      mobile: baseSize * 0.875,
      tablet: baseSize,
      desktop: baseSize * 1.125,
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: MPText(
        text,
        style: MPTextStyle(
          fontSize: responsiveSize,
          fontWeight: weight,
          color: colorTheme?.neutral90 ?? context.mp.neutral90,
          fontFamily: MpUiKit.fontName ?? MPTextStyle.defaultFontFamily,
        ).toTextStyle(context),
      ),
    );
  }
}

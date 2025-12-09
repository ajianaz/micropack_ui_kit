import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';
import 'package:micropack_ui_kit/src/core/fonts/mp_font_manager.dart';
import 'package:micropack_ui_kit/src/core/utils/responsive_font_helper.dart';

/// Enhanced Typography Demo Page
///
/// Demonstrates the improved typography system with:
/// - Robust font fallback system
/// - Platform-specific optimizations
/// - Enhanced responsive scaling
/// - Graceful error handling
class TypographyDemoPage extends StatefulWidget {
  const TypographyDemoPage({super.key});

  @override
  State<TypographyDemoPage> createState() => _TypographyDemoPageState();
}

class _TypographyDemoPageState extends State<TypographyDemoPage> {
  bool _isLoading = false;
  String _currentFont = 'Poppins';
  List<String> _fontLoadingStats = [];

  @override
  void initState() {
    super.initState();
    _loadFontStatistics();
  }

  Future<void> _loadFontStatistics() async {
    final fontManager = MPFontManager();
    final stats = fontManager.getFontStats();

    // Preload common fonts for demonstration
    await fontManager
        .preloadCriticalFonts(['Poppins', 'Roboto', 'Inter', 'Lato']);

    setState(() {
      _fontLoadingStats = [
        'Total Fonts: ${stats['totalFonts']}',
        'Loaded: ${stats['loadedFonts']}',
        'Failed: ${stats['failedFonts']}',
        'Cached Styles: ${stats['cachedStyles']}',
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: MPText.head(
          'Enhanced Typography Demo',
          style: TextStyle(color: context.mp.textColor),
        ),
        backgroundColor: context.mp.adaptiveBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: context.mp.textColor),
            onPressed: _loadFontStatistics,
            tooltip: 'Reload Font Statistics',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: MPResponsivePadding.card(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFontStatsSection(context),
            SizedBox(height: MPResponsivePadding.getXl(context)),
            _buildResponsiveTypographySection(context),
            SizedBox(height: MPResponsivePadding.getXl(context)),
            _buildPlatformOptimizationSection(context),
            SizedBox(height: MPResponsivePadding.getXl(context)),
            _buildFontFallbackSection(context),
            SizedBox(height: MPResponsivePadding.getXl(context)),
            _buildInteractiveDemo(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFontStatsSection(BuildContext context) {
    return Card(
      color: context.mp.cardColor,
      child: Padding(
        padding: MPResponsivePadding.card(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MPText.head(
              'Font Loading Statistics',
              style: TextStyle(color: context.mp.primary),
            ),
            SizedBox(height: MPResponsivePadding.getSm(context)),
            ..._fontLoadingStats
                .map((stat) => Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MPResponsivePadding.getXs(context)),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 16,
                            color: context.mp.primary,
                          ),
                          SizedBox(width: MPResponsivePadding.getSm(context)),
                          Expanded(
                            child: MPText.body(
                              stat,
                              style: TextStyle(color: context.mp.textColor),
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildResponsiveTypographySection(BuildContext context) {
    final screenCategory = ResponsiveFontHelper.getScreenCategory(context);

    return Card(
      color: context.mp.cardColor,
      child: Padding(
        padding: MPResponsivePadding.card(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MPText.head(
              'Responsive Typography ($screenCategory)',
              style: TextStyle(color: context.mp.primary),
            ),
            SizedBox(height: MPResponsivePadding.getSm(context)),
            _buildResponsiveText(context, 'Small Mobile', 12, isMobile: true),
            _buildResponsiveText(context, 'Mobile', 14, isMobile: true),
            _buildResponsiveText(context, 'Tablet', 16, isTablet: true),
            _buildResponsiveText(context, 'Desktop', 18, isDesktop: true),
          ],
        ),
      ),
    );
  }

  Widget _buildResponsiveText(
      BuildContext context, String label, double baseSize,
      {bool isMobile = false, bool isTablet = false, bool isDesktop = false}) {
    final responsiveSize =
        ResponsiveFontHelper.getResponsiveFontSize(baseSize, context);
    final lineHeight =
        ResponsiveFontHelper.getResponsiveLineHeight(baseSize, context);
    final letterSpacing =
        ResponsiveFontHelper.getResponsiveLetterSpacing(baseSize, context);
    final fontWeight =
        ResponsiveFontHelper.getResponsiveFontWeight(FontWeight.w400, context);

    return Container(
      width: double.infinity,
      padding: MPResponsivePadding.card(context),
      margin: EdgeInsets.only(bottom: MPResponsivePadding.getSm(context)),
      decoration: BoxDecoration(
        color: context.mp.cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.mp.adaptiveBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MPText.subhead(
                '$label Text',
                style: TextStyle(color: context.mp.primary),
              ),
              MPText.body(
                'Base: ${baseSize.toStringAsFixed(1)} → Responsive: ${responsiveSize.toStringAsFixed(1)}',
                style: TextStyle(color: context.mp.subtitleColor),
              ),
            ],
          ),
          SizedBox(height: MPResponsivePadding.getXs(context)),
          MPText.body(
            'The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog.',
            style: TextStyle(
              fontSize: responsiveSize,
              height: lineHeight,
              letterSpacing: letterSpacing,
              fontWeight: fontWeight,
              color: context.mp.textColor,
            ),
            maxLines: 3,
          ),
          SizedBox(height: MPResponsivePadding.getXs(context)),
          Row(
            children: [
              _buildInfoChip('Mobile', isMobile),
              _buildInfoChip('Tablet', isTablet),
              _buildInfoChip('Desktop', isDesktop),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label, bool isActive) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MPResponsivePadding.getXs(context),
          vertical: MPResponsivePadding.getXs(context)),
      decoration: BoxDecoration(
        color:
            isActive ? context.mp.primary : context.mp.cardColor, // ✅ Adaptive
        borderRadius: BorderRadius.circular(12),
      ),
      child: MPText.small(
        label,
        style: TextStyle(
          color: isActive ? Colors.white : context.mp.textColor, // ✅ Adaptive
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildPlatformOptimizationSection(BuildContext context) {
    return Card(
      color: context.mp.cardColor,
      child: Padding(
        padding: MPResponsivePadding.card(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MPText.head(
              'Platform-Specific Optimizations',
              style: TextStyle(color: context.mp.primary),
            ),
            SizedBox(height: MPResponsivePadding.getSm(context)),
            _buildPlatformOptimizedText(context, 'Poppins'),
            _buildPlatformOptimizedText(context, 'Roboto'),
            _buildPlatformOptimizedText(context, 'Inter'),
            SizedBox(height: MPResponsivePadding.getSm(context)),
            MPText.body(
              'Platform optimizations include:\n• Font size adjustments per platform\n• Letter spacing optimization\n• Line height tuning\n• Font weight enhancement\n• Leading distribution optimization',
              style: TextStyle(color: context.mp.subtitleColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlatformOptimizedText(BuildContext context, String fontFamily) {
    final fontManager = MPFontManager();
    final platformFont = MPFontManager.getPlatformFontFamily(fontFamily);

    return Container(
      width: double.infinity,
      padding: MPResponsivePadding.card(context),
      margin: EdgeInsets.only(bottom: MPResponsivePadding.getSm(context)),
      decoration: BoxDecoration(
        color: context.mp.cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.mp.adaptiveBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MPText.subhead(
                fontFamily,
                style: TextStyle(color: context.mp.primary),
              ),
              MPText.small(
                '→ $platformFont',
                style: TextStyle(color: context.mp.subtitleColor),
              ),
            ],
          ),
          SizedBox(height: MPResponsivePadding.getXs(context)),
          MPText.body(
            'Sample text demonstrating platform-optimized rendering for $fontFamily font family.',
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 16,
              color: context.mp.textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFontFallbackSection(BuildContext context) {
    return Card(
      color: context.mp.cardColor,
      child: Padding(
        padding: MPResponsivePadding.card(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MPText.head(
              'Font Fallback System',
              style: TextStyle(color: context.mp.primary),
            ),
            SizedBox(height: MPResponsivePadding.getSm(context)),
            _buildFallbackDemo(context, 'Poppins'),
            _buildFallbackDemo(context, 'Invalid Font'),
            _buildFallbackDemo(context, 'Custom Font'),
            SizedBox(height: MPResponsivePadding.getSm(context)),
            MPText.body(
              'The fallback system ensures text remains readable even when:\n• Google Fonts fail to load\n• Network issues occur\n• Custom fonts are unavailable\n• Platform-specific rendering issues arise',
              style: TextStyle(color: context.mp.subtitleColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackDemo(BuildContext context, String fontFamily) {
    final fontManager = MPFontManager();
    final loadingState = fontManager.getFontLoadingState(fontFamily);

    return Container(
      width: double.infinity,
      padding: MPResponsivePadding.card(context),
      margin: EdgeInsets.only(bottom: MPResponsivePadding.getSm(context)),
      decoration: BoxDecoration(
        color: context.mp.cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: loadingState == MPFontLoadingState.failed
              ? context.mp.errorColor
              : context.mp.adaptiveBorderColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MPText.subhead(
                fontFamily,
                style: TextStyle(color: context.mp.primary),
              ),
              _buildLoadingStateChip(loadingState),
            ],
          ),
          SizedBox(height: MPResponsivePadding.getXs(context)),
          MPText.body(
            'This text uses enhanced font fallback system with graceful error handling.',
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 16,
              color: context.mp.textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingStateChip(MPFontLoadingState state) {
    Color chipColor;
    String chipText;
    IconData chipIcon;

    switch (state) {
      case MPFontLoadingState.loaded:
        chipColor = Colors.green;
        chipText = 'Loaded';
        chipIcon = Icons.check_circle;
        break;
      case MPFontLoadingState.loading:
        chipColor = Colors.orange;
        chipText = 'Loading';
        chipIcon = Icons.hourglass_empty;
        break;
      case MPFontLoadingState.failed:
        chipColor = Colors.red;
        chipText = 'Failed';
        chipIcon = Icons.error;
        break;
      default:
        chipColor = Colors.grey;
        chipText = 'Not Loaded';
        chipIcon = Icons.help_outline;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MPResponsivePadding.getXs(context),
          vertical: MPResponsivePadding.getXs(context)),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            chipIcon,
            size: 14,
            color: Colors.white,
          ),
          SizedBox(width: MPResponsivePadding.getXs(context)),
          MPText.small(
            chipText,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractiveDemo(BuildContext context) {
    return Card(
      color: context.mp.cardColor,
      child: Padding(
        padding: MPResponsivePadding.card(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MPText.head(
              'Interactive Typography Demo',
              style: TextStyle(color: context.mp.primary),
            ),
            SizedBox(height: MPResponsivePadding.getSm(context)),
            TextField(
              decoration: InputDecoration(
                labelText: 'Type custom text',
                hintText: 'Try different fonts and sizes',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: context.mp.adaptiveBorderColor),
                ),
                filled: true,
                fillColor: context.mp.adaptiveBackgroundColor,
              ),
              style: TextStyle(
                fontFamily: _currentFont,
                fontSize: 16,
                color: context.mp.textColor,
              ),
              onChanged: (value) {
                setState(() {
                  _currentFont = value.isNotEmpty ? value : 'Poppins';
                });
              },
            ),
            SizedBox(height: MPResponsivePadding.getSm(context)),
            MPText.body(
              'Current Font: $_currentFont',
              style: TextStyle(color: context.mp.subtitleColor),
            ),
            SizedBox(height: MPResponsivePadding.getSm(context)),
            Row(
              children: [
                MPButton(
                  text: 'Test Poppins',
                  onPressed: () => _testFont('Poppins'),
                  variant: MPButtonVariant.outlined,
                ),
                SizedBox(width: MPResponsivePadding.getXs(context)),
                MPButton(
                  text: 'Test Roboto',
                  onPressed: () => _testFont('Roboto'),
                  variant: MPButtonVariant.outlined,
                ),
                SizedBox(width: MPResponsivePadding.getXs(context)),
                MPButton(
                  text: 'Test Invalid',
                  onPressed: () => _testFont('InvalidFontName'),
                  variant: MPButtonVariant.outlined,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _testFont(String fontFamily) {
    final fontManager = MPFontManager();
    final loadingState = fontManager.getFontLoadingState(fontFamily);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: MPText.body(
          'Font "$fontFamily" test: ${loadingState.name}',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: loadingState == MPFontLoadingState.loaded
            ? Colors.green
            : loadingState == MPFontLoadingState.failed
                ? Colors.red
                : Colors.orange,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

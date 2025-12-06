import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:micropack_ui_kit/micropack_ui_kit.dart';
import 'package:micropack_ui_kit/src/core/theme/mp_theme_manager.dart';

import 'package:micropack_ui_kit/src/core/theme/mp_theme.dart';
import 'package:micropack_ui_kit/src/core/theme/mp_color_theme.dart';
import 'package:micropack_ui_kit/src/core/utils/component_init.dart';

/// MPThemeWidget - Theme wrapper widget for MicroPack UI Kit
///
/// Features:
/// - StatefulWidget with listener pattern
/// - Automatic MPThemeManager initialization
/// - Loading state during theme initialization
/// - MaterialApp builder with correct theme
/// - Theme change handling with automatic rebuild
/// - Integration with MPComponentInit for ScreenUtil
/// - Error handling for initialization failures
/// - Debug information support
class MPThemeWidget extends StatefulWidget {
  const MPThemeWidget({
    required this.home,
    this.title = 'MicroPack UI Kit App',
    this.designSize,
    this.debugShowCheckedModeBanner = true,
    this.showDebugInfo = false,
    this.onThemeChanged,
    this.loadingBuilder,
    this.errorBuilder,
    this.routes,
    this.initialRoute,
    this.navigatorObservers,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.builder,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales,
    this.themeMode,
    this.highContrast,
    this.useInheritedMediaQuery = false,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
    this.themeAnimationDuration = kThemeAnimationDuration,
    this.themeAnimationCurve = Curves.linear,
    super.key,
  });

  /// The widget for the default route of the app
  final Widget home;

  /// A one-line description of the app for use in the window manager
  final String title;

  /// The design size for ScreenUtil initialization
  final Size? designSize;

  /// Whether to show a debug banner
  final bool debugShowCheckedModeBanner;

  /// Whether to show debug information overlay
  final bool showDebugInfo;

  /// Callback when theme changes
  final VoidCallback? onThemeChanged;

  /// Custom loading widget builder
  final Widget Function(BuildContext context)? loadingBuilder;

  /// Custom error widget builder
  final Widget Function(BuildContext context, String? error)? errorBuilder;

  /// The application's top-level routing table
  final Map<String, WidgetBuilder>? routes;

  /// The name of the first route to show
  final String? initialRoute;

  /// The list of observers for the Navigator
  final List<NavigatorObserver>? navigatorObservers;

  /// The route generator callback used when the app is navigated to a named route
  final RouteFactory? onGenerateRoute;

  /// Called when onGenerateRoute fails to generate a route
  final RouteFactory? onUnknownRoute;

  /// A builder for the root of the app
  final Widget Function(BuildContext, Widget?)? builder;

  /// The initial locale for the app
  final Locale? locale;

  /// The delegates for this app's Localizations widget
  final List<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  /// Callback for resolving locale lists
  final LocaleListResolutionCallback? localeListResolutionCallback;

  /// Callback for resolving locales
  final LocaleResolutionCallback? localeResolutionCallback;

  /// The list of locales that the app supports
  final List<Locale>? supportedLocales;

  /// The theme mode to use
  final ThemeMode? themeMode;

  /// Whether to use high contrast mode
  final bool? highContrast;

  /// Whether to use inherited MediaQuery
  final bool useInheritedMediaQuery;

  /// The map of shortcuts to intent mappings
  final Map<ShortcutActivator, Intent>? shortcuts;

  /// The map of intent to action mappings
  final Map<Type, Action<Intent>>? actions;

  /// The restoration ID to save and restore the state of the app
  final String? restorationScopeId;

  /// The scroll behavior for the app
  final ScrollBehavior? scrollBehavior;

  /// The duration of theme animation
  final Duration themeAnimationDuration;

  /// The curve of theme animation
  final Curve themeAnimationCurve;

  @override
  State<MPThemeWidget> createState() => _MPThemeWidgetState();
}

class _MPThemeWidgetState extends State<MPThemeWidget> {
  // ============ STATE MANAGEMENT ============

  bool _isInitialized = false;
  bool _isInitializing = false;
  String? _initializationError;
  ThemeMode? _currentThemeMode;

  // ============ LIFECYCLE ============

  @override
  void initState() {
    super.initState();
    _initializeThemeManager();
  }

  @override
  void dispose() {
    // Remove theme listener
    try {
      MPThemeManager.instance.removeListener(_onThemeChanged);
    } catch (e) {
      // Manager might not be initialized, ignore
    }
    super.dispose();
  }

  // ============ INITIALIZATION ============

  Future<void> _initializeThemeManager() async {
    if (_isInitialized || _isInitializing) return;

    setState(() {
      _isInitializing = true;
      _initializationError = null;
    });

    try {
      // Initialize MPThemeManager
      await MPThemeManager.initialize();

      // Add theme listener
      MPThemeManager.instance.addListener(_onThemeChanged);

      // Get initial theme mode
      _currentThemeMode = widget.themeMode ?? MPThemeManager.instance.themeMode;

      setState(() {
        _isInitialized = true;
        _isInitializing = false;
      });
    } catch (e) {
      setState(() {
        _initializationError = e.toString();
        _isInitializing = false;
      });
    }
  }

  // ============ THEME HANDLING ============

  void _onThemeChanged() {
    if (mounted) {
      final newThemeMode =
          widget.themeMode ?? MPThemeManager.instance.themeMode;

      if (_currentThemeMode != newThemeMode) {
        setState(() {
          _currentThemeMode = newThemeMode;
        });

        // Call external callback if provided
        widget.onThemeChanged?.call();
      }
    }
  }

  ThemeData _getLightTheme() {
    if (!_isInitialized) {
      // Return fallback theme if not initialized
      return MPTheme.lightTheme();
    }

    try {
      return MPThemeManager.instance.getCurrentThemeData(context);
    } catch (e) {
      debugPrint('Error getting light theme: $e');
      return MPTheme.lightTheme();
    }
  }

  ThemeData _getDarkTheme() {
    if (!_isInitialized) {
      // Return fallback theme if not initialized
      return MPTheme.darkTheme();
    }

    try {
      return MPThemeManager.instance.getCurrentThemeData(context);
    } catch (e) {
      debugPrint('Error getting dark theme: $e');
      return MPTheme.darkTheme();
    }
  }

  // ============ WIDGET BUILDERS ============

  Widget _buildLoadingWidget() {
    Widget child;
    if (widget.loadingBuilder != null) {
      child = widget.loadingBuilder!(context);
    } else {
      child = Scaffold(
        backgroundColor: Colors.white, // Safe fallback
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.blue, // Safe fallback
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Initializing theme...',
                style: TextStyle(
                  color: Colors.black, // Safe fallback
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
      home: child,
    );
  }

  Widget _buildErrorWidget() {
    Widget child;
    if (widget.errorBuilder != null) {
      child = widget.errorBuilder!(context, _initializationError);
    } else {
      child = Scaffold(
        backgroundColor: Colors.white, // Safe fallback
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red, // Safe fallback
                  size: 64,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Theme Initialization Error',
                  style: TextStyle(
                    color: Colors.black, // Safe fallback
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _initializationError ?? 'Unknown error occurred',
                  style: const TextStyle(
                    color: Colors.grey, // Safe fallback
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _initializeThemeManager,
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
      home: child,
    );
  }

  Widget _buildDebugInfo() {
    if (!widget.showDebugInfo || !_isInitialized) {
      return const SizedBox.shrink();
    }

    final debugInfo = MPThemeManager.instance.getDebugInfo();

    return Positioned(
      top: 50,
      left: 10,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Theme Debug Info',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            ...debugInfo.entries.map((entry) => Text(
                  '${entry.key}: ${entry.value}',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 10,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildMaterialApp() {
    return MaterialApp(
      title: widget.title,
      theme: _getLightTheme(),
      darkTheme: _getDarkTheme(),
      themeMode: _currentThemeMode,
      debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
      home: Stack(
        children: [
          widget.home,
          _buildDebugInfo(),
        ],
      ),
      routes: widget.routes?.map(
              (key, value) => MapEntry(key, (context) => value(context))) ??
          {},
      initialRoute: widget.initialRoute,
      navigatorObservers: widget.navigatorObservers ?? const [],
      onGenerateRoute: widget.onGenerateRoute,
      onUnknownRoute: widget.onUnknownRoute,
      builder: widget.builder,
      locale: widget.locale,
      localizationsDelegates: widget.localizationsDelegates,
      localeListResolutionCallback: widget.localeListResolutionCallback,
      localeResolutionCallback: widget.localeResolutionCallback,
      supportedLocales: widget.supportedLocales ?? const [Locale('en', 'US')],
      useInheritedMediaQuery: widget.useInheritedMediaQuery,
      shortcuts: widget.shortcuts,
      actions: widget.actions,
      restorationScopeId: widget.restorationScopeId,
      scrollBehavior: widget.scrollBehavior,
      themeAnimationDuration: widget.themeAnimationDuration,
      themeAnimationCurve: widget.themeAnimationCurve,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Wrap with MPComponentInit for ScreenUtil support
    return MPComponentInit(
      designSize: widget.designSize,
      builder: (context) {
        // Show loading state
        if (_isInitializing) {
          return _buildLoadingWidget();
        }

        // Show error state
        if (_initializationError != null) {
          return _buildErrorWidget();
        }

        // Show main app
        return _buildMaterialApp();
      },
    );
  }
}

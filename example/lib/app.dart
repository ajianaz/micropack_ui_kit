import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

import 'package:micropack_ui_kit_example/pages/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MPThemeWidget(
      title: 'Micropack UI KIT',
      designSize: const Size(375, 812), // iPhone X design size
      debugShowCheckedModeBanner: true,
      showDebugInfo: false, // Set to true for debugging theme issues
      onThemeChanged: () {
        // Optional: Handle theme changes if needed
        debugPrint('Theme changed');
      },
      loadingBuilder: (context) {
        // Custom loading widget during theme initialization
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    MPThemeConfig.getPrimary(),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Initializing theme...',
                  style: TextStyle(
                    color: MPThemeConfig.getPrimaryTextColor(),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      errorBuilder: (context, error) {
        // Custom error widget for theme initialization failures
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: MPThemeConfig.getErrorColor(),
                    size: 64,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Theme Initialization Error',
                    style: TextStyle(
                      color: MPThemeConfig.getPrimaryTextColor(),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    error?.toString() ?? 'Unknown error occurred',
                    style: TextStyle(
                      color: MPThemeConfig.getSecondaryTextColor(),
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      // Retry initialization by rebuilding the app
                      // In a real app, you might want to restart the app
                      // or trigger a re-initialization
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      home: const HomePage(),
    );
  }
}

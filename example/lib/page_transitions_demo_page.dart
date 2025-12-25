import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

/// Demo page for MPPageTransition animations
///
/// Demonstrates various page transition types available in Micropack UI Kit.
class PageTransitionDemoPage extends StatelessWidget {
  const PageTransitionDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MPText(
          'Page Transitions',
          fontSize: 20,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: context.mp.adaptiveBackgroundColor,
        elevation: 0,
      ),
      body: Container(
        color: context.mp.adaptiveBackgroundColor,
        child: ListView(
          padding: MPResponsivePadding.page(context),
          children: [
            _DescriptionCard(),
            const SizedBox(height: 24),
            const _SectionTitle('Basic Transitions'),
            _TransitionButton(
              context,
              'Fade Transition',
              'Smooth fade in/out animation',
              MPPageTransitionType.fade,
              Icons.opacity,
            ),
            _TransitionButton(
              context,
              'Slide Right',
              'Slide from right (iOS style)',
              MPPageTransitionType.slideRight,
              Icons.arrow_forward,
            ),
            _TransitionButton(
              context,
              'Slide Left',
              'Slide from left',
              MPPageTransitionType.slideLeft,
              Icons.arrow_back,
            ),
            _TransitionButton(
              context,
              'Slide Up',
              'Slide from bottom',
              MPPageTransitionType.slideUp,
              Icons.arrow_upward,
            ),
            _TransitionButton(
              context,
              'Slide Down',
              'Slide from top',
              MPPageTransitionType.slideDown,
              Icons.arrow_downward,
            ),
            const SizedBox(height: 24),
            const _SectionTitle('Scale & Rotate'),
            _TransitionButton(
              context,
              'Scale',
              'Scale from center',
              MPPageTransitionType.scale,
              Icons.zoom_in,
            ),
            _TransitionButton(
              context,
              'Rotate',
              'Rotate with fade',
              MPPageTransitionType.rotate,
              Icons.rotate_90_degrees_ccw,
            ),
            const SizedBox(height: 24),
            const _SectionTitle('Material Design 3'),
            _MD3TransitionButton(
              context,
              'Shared Axis - Forward',
              'Z-axis forward transition',
              MPSharedAxisTransitionType.forward,
              Icons.login,
            ),
            _MD3TransitionButton(
              context,
              'Shared Axis - Backward',
              'Z-axis backward transition',
              MPSharedAxisTransitionType.backward,
              Icons.logout,
            ),
            _MD3TransitionButton(
              context,
              'Shared Axis - Scaled',
              'Scaled transition',
              MPSharedAxisTransitionType.scaled,
              Icons.fullscreen,
            ),
            _MD3TransitionButton(
              context,
              'Fade Through',
              'Crossfade animation',
              null,
              Icons.flip,
            ),
            const SizedBox(height: 24),
            const _SectionTitle('Zoom Transition'),
            _ZoomTransitionButton(
              context,
              'Zoom from Center',
              'Hero-style zoom transition',
              Offset.zero,
            ),
            _ZoomTransitionButton(
              context,
              'Zoom from Top Right',
              'Zoom from corner',
              const Offset(1, 0),
            ),
            _ZoomTransitionButton(
              context,
              'Zoom from Bottom Left',
              'Zoom from corner',
              const Offset(0, 1),
            ),
          ],
        ),
      ),
    );
  }
}

class _DescriptionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MPResponsivePadding.card(context),
      decoration: BoxDecoration(
        color: context.mp.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.mp.borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: context.mp.adaptiveShadowColor,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: context.mp.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.animation,
                  color: context.mp.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MPText(
                  'Page Transitions',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: context.mp.textColor,
                  ),
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          MPText(
            'Tap any button below to see different page transition animations. '
            'These transitions can be used when navigating between screens.',
            style: TextStyle(color: context.mp.subtitleColor),
            fontSize: 14,
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: MPText(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: context.mp.textColor,
        ),
        fontSize: 18,
      ),
    );
  }
}

class _TransitionButton extends StatelessWidget {
  const _TransitionButton(
    this.context,
    this.title,
    this.description,
    this.type,
    this.icon,
  );

  final BuildContext context;
  final String title;
  final String description;
  final MPPageTransitionType type;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: MPButton(
        text: title,
        variant: MPButtonVariant.outlined,
        icon: icon,
        onPressed: () => _navigate(context),
      ),
    );
  }

  void _navigate(BuildContext context) {
    Navigator.of(context).push(
      MPPageTransition(
        type: type,
        child: const _SecondPage(title: 'Second Page'),
      ),
    );
  }
}

class _MD3TransitionButton extends StatelessWidget {
  const _MD3TransitionButton(
    this.context,
    this.title,
    this.description,
    this.type,
    this.icon,
  );

  final BuildContext context;
  final String title;
  final String description;
  final MPSharedAxisTransitionType? type;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: MPButton(
        text: title,
        variant: MPButtonVariant.outlined,
        icon: icon,
        onPressed: () => _navigate(context),
      ),
    );
  }

  void _navigate(BuildContext context) {
    if (type != null) {
      Navigator.of(context).push(
        MPSharedAxisTransition(
          type: type!,
          child: const _SecondPage(title: 'Shared Axis Page'),
        ),
      );
    } else {
      Navigator.of(context).push(
        MPFadeThroughTransition(
          child: const _SecondPage(title: 'Fade Through Page'),
        ),
      );
    }
  }
}

class _ZoomTransitionButton extends StatelessWidget {
  const _ZoomTransitionButton(
    this.context,
    this.title,
    this.description,
    this.begin,
  );

  final BuildContext context;
  final String title;
  final String description;
  final Offset begin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: MPButton(
        text: title,
        variant: MPButtonVariant.outlined,
        icon: Icons.zoom_out_map,
        onPressed: () => _navigate(context),
      ),
    );
  }

  void _navigate(BuildContext context) {
    Navigator.of(context).push(
      MPZoomPageTransition(
        begin: begin,
        child: const _SecondPage(title: 'Zoom Transition Page'),
      ),
    );
  }
}

class _SecondPage extends StatelessWidget {
  const _SecondPage({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MPText(
          title,
          fontSize: 20,
          style: TextStyle(color: context.mp.textColor),
        ),
        backgroundColor: context.mp.adaptiveBackgroundColor,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: context.mp.cardColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: context.mp.adaptiveShadowColor,
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(
                Icons.check_circle_outline,
                size: 64,
                color: context.mp.primary,
              ),
            ),
            const SizedBox(height: 24),
            MPText(
              'Transition Complete!',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: context.mp.textColor,
              ),
              fontSize: 20,
            ),
            const SizedBox(height: 12),
            MPText(
              'Press back to see the reverse transition',
              style: TextStyle(color: context.mp.subtitleColor),
              fontSize: 14,
            ),
            const SizedBox(height: 32),
            MPButton(
              text: 'Go Back',
              variant: MPButtonVariant.primary,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

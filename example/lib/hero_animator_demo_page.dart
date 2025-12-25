import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

/// Demo page for MPHheroAnimator
///
/// Demonstrates hero animation capabilities with various examples.
class HeroAnimatorDemoPage extends StatelessWidget {
  const HeroAnimatorDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MPText(
          'Hero Animator',
          fontSize: 20,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: context.mp.adaptiveBackgroundColor,
        elevation: 0,
      ),
      body: Container(
        color: context.mp.adaptiveBackgroundColor,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _DescriptionCard(),
            const SizedBox(height: 24),
            const _SectionTitle('Basic Hero Animations'),
            _HeroCard(
              title: 'Standard Hero',
              description: 'Default Material hero animation',
              icon: Icons.star,
              tag: 'hero-standard',
              animationType: MPHheroAnimationType.standard,
              color: Colors.blue,
            ),
            _HeroCard(
              title: 'Fade Hero',
              description: 'Smooth fade transition',
              icon: Icons.opacity,
              tag: 'hero-fade',
              animationType: MPHheroAnimationType.fade,
              color: Colors.green,
            ),
            _HeroCard(
              title: 'Scale + Fade Hero',
              description: 'Combined scale and fade',
              icon: Icons.zoom_in,
              tag: 'hero-scale',
              animationType: MPHheroAnimationType.scaleFade,
              color: Colors.purple,
            ),
            _HeroCard(
              title: 'Slide + Fade Hero',
              description: 'Slide and fade together',
              icon: Icons.arrow_forward,
              tag: 'hero-slide',
              animationType: MPHheroAnimationType.slideFade,
              color: Colors.orange,
            ),
            const SizedBox(height: 24),
            const _SectionTitle('Twin Hero Animations'),
            _TwinHeroCard(
              title1: 'Profile Picture',
              title2: 'Username',
              description: 'Coordinated dual heroes',
              icon1: Icons.account_circle,
              icon2: Icons.person,
              tag1: 'twin-hero-1',
              tag2: 'twin-hero-2',
              color: Colors.teal,
            ),
            const SizedBox(height: 24),
            const _SectionTitle('Hero Group'),
            _HeroGroupCard(),
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
      padding: const EdgeInsets.all(16),
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
                  'Hero Animations',
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
            'Tap any card below to see different hero animation styles. '
            'Heroes create smooth transitions between matching elements across screens.',
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

class _HeroCard extends StatelessWidget {
  const _HeroCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.tag,
    required this.animationType,
    required this.color,
  });

  final String title;
  final String description;
  final IconData icon;
  final String tag;
  final MPHheroAnimationType animationType;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToSecondPage(context),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.mp.cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: context.mp.borderColor, width: 1),
          boxShadow: [
            BoxShadow(
              color: context.mp.adaptiveShadowColor,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            MPHheroAnimator(
              tag: tag,
              animationType: animationType,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 28,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MPText(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: context.mp.textColor,
                    ),
                    fontSize: 14,
                  ),
                  const SizedBox(height: 4),
                  MPText(
                    description,
                    style: TextStyle(color: context.mp.subtitleColor),
                    fontSize: 12,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: context.mp.subtitleColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToSecondPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _HeroSecondPage(
          title: title,
          tag: tag,
          animationType: animationType,
          icon: icon,
          color: color,
        ),
      ),
    );
  }
}

class _TwinHeroCard extends StatelessWidget {
  const _TwinHeroCard({
    required this.title1,
    required this.title2,
    required this.description,
    required this.icon1,
    required this.icon2,
    required this.tag1,
    required this.tag2,
    required this.color,
  });

  final String title1;
  final String title2;
  final String description;
  final IconData icon1;
  final IconData icon2;
  final String tag1;
  final String tag2;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToSecondPage(context),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.mp.cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: context.mp.borderColor, width: 1),
          boxShadow: [
            BoxShadow(
              color: context.mp.adaptiveShadowColor,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            MPTwinHeroAnimator(
              tag1: tag1,
              tag2: tag2,
              child1: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon1,
                  color: color,
                  size: 24,
                ),
              ),
              child2: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon2,
                  color: color,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MPText(
                    description,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: context.mp.textColor,
                    ),
                    fontSize: 14,
                  ),
                  const SizedBox(height: 4),
                  MPText(
                    '$title1 + $title2',
                    style: TextStyle(color: context.mp.subtitleColor),
                    fontSize: 12,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: context.mp.subtitleColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToSecondPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _TwinHeroSecondPage(
          title1: title1,
          title2: title2,
          description: description,
          tag1: tag1,
          tag2: tag2,
          icon1: icon1,
          icon2: icon2,
          color: color,
        ),
      ),
    );
  }
}

class _HeroGroupCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToSecondPage(context),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              context.mp.cardColor,
              context.mp.cardColor.withValues(alpha: 0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: context.mp.borderColor, width: 1),
        ),
        child: Column(
          children: [
            Row(
              children: [
                MPHheroGroup(
                  tags: const ['group-1', 'group-2', 'group-3'],
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text('1',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text('2',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text('3',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                  spacing: 8,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MPText(
                        'Hero Group',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: context.mp.textColor,
                        ),
                        fontSize: 14,
                      ),
                      const SizedBox(height: 4),
                      MPText(
                        'Multiple coordinated heroes',
                        style: TextStyle(color: context.mp.subtitleColor),
                        fontSize: 12,
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: context.mp.subtitleColor,
                  size: 16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToSecondPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const _HeroGroupSecondPage(),
      ),
    );
  }
}

class _HeroSecondPage extends StatelessWidget {
  const _HeroSecondPage({
    required this.title,
    required this.tag,
    required this.animationType,
    required this.icon,
    required this.color,
  });

  final String title;
  final String tag;
  final MPHheroAnimationType animationType;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MPText(
          'Hero Animation',
          fontSize: 20,
        ),
        backgroundColor: context.mp.adaptiveBackgroundColor,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MPHheroAnimator(
              tag: tag,
              animationType: animationType,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: color, width: 2),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 64,
                ),
              ),
            ),
            const SizedBox(height: 24),
            MPText(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: context.mp.textColor,
              ),
              fontSize: 20,
            ),
            const SizedBox(height: 12),
            MPText(
              'Tap back to see reverse animation',
              style: TextStyle(color: context.mp.subtitleColor),
              fontSize: 14,
            ),
            const SizedBox(height: 32),
            MPButton(
              text: 'Go Back',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

class _TwinHeroSecondPage extends StatelessWidget {
  const _TwinHeroSecondPage({
    required this.title1,
    required this.title2,
    required this.description,
    required this.tag1,
    required this.tag2,
    required this.icon1,
    required this.icon2,
    required this.color,
  });

  final String title1;
  final String title2;
  final String description;
  final String tag1;
  final String tag2;
  final IconData icon1;
  final IconData icon2;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MPText(
          'Twin Hero Animation',
          fontSize: 20,
        ),
        backgroundColor: context.mp.adaptiveBackgroundColor,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MPTwinHeroAnimator(
              tag1: tag1,
              tag2: tag2,
              child1: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 2),
                ),
                child: Icon(
                  icon1,
                  color: color,
                  size: 48,
                ),
              ),
              child2: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 2),
                ),
                child: Icon(
                  icon2,
                  color: color,
                  size: 48,
                ),
              ),
            ),
            const SizedBox(height: 24),
            MPText(
              description,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: context.mp.textColor,
              ),
              fontSize: 20,
            ),
            const SizedBox(height: 12),
            MPText(
              '$title1 and $title2 animate together',
              style: TextStyle(color: context.mp.subtitleColor),
              fontSize: 14,
            ),
            const SizedBox(height: 32),
            MPButton(
              text: 'Go Back',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroGroupSecondPage extends StatelessWidget {
  const _HeroGroupSecondPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MPText(
          'Hero Group Animation',
          fontSize: 20,
        ),
        backgroundColor: context.mp.adaptiveBackgroundColor,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MPHheroGroup(
              tags: const ['group-1', 'group-2', 'group-3'],
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Text('Step 1',
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  ),
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Text('Step 2',
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  ),
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Text('Step 3',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  ),
                ),
              ],
              spacing: 16,
            ),
            const SizedBox(height: 24),
            MPText(
              'Hero Group Animation',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: context.mp.textColor,
              ),
              fontSize: 20,
            ),
            const SizedBox(height: 12),
            MPText(
              'All items animate together',
              style: TextStyle(color: context.mp.subtitleColor),
              fontSize: 14,
            ),
            const SizedBox(height: 32),
            MPButton(
              text: 'Go Back',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

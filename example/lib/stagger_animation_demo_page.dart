import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

/// Demo page for MPStaggerAnimation
///
/// Demonstrates various stagger animation patterns.
class StaggerAnimationDemoPage extends StatefulWidget {
  const StaggerAnimationDemoPage({super.key});

  @override
  State<StaggerAnimationDemoPage> createState() => _StaggerAnimationDemoPageState();
}

class _StaggerAnimationDemoPageState extends State<StaggerAnimationDemoPage> {
  MPStaggerDirection _direction = MPStaggerDirection.forward;
  MPStaggerAnimationType _animationType = MPStaggerAnimationType.fade;
  bool _isGridView = false;

  final List<String> _items = List.generate(
    15,
    (index) => 'Item ${index + 1}',
  );

  void _resetAnimation() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MPText(
          'Stagger Animation',
          fontSize: 20,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: context.mp.adaptiveBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            color: context.mp.textColor,
            onPressed: _resetAnimation,
          ),
        ],
      ),
      body: Column(
        children: [
          _ControlsCard(),
          Expanded(
            child: _isGridView ? _buildGridView() : _buildListView(),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return MPStaggerListView(
      staggerDirection: _direction,
      delay: const Duration(milliseconds: 80),
      animationType: _animationType,
      itemCount: _items.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return _StaggerItem(title: _items[index], index: index);
      },
    );
  }

  Widget _buildGridView() {
    return MPStaggerGridView(
      staggerDirection: _direction,
      delay: const Duration(milliseconds: 80),
      animationType: _animationType,
      crossAxisCount: 3,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      itemCount: _items.length,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, index) {
        return _GridItem(title: _items[index], index: index);
      },
    );
  }
}

class _ControlsCard extends StatelessWidget {
  const _ControlsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.mp.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.mp.borderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MPText(
            'Animation Settings',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: context.mp.textColor,
            ),
            fontSize: 16,
          ),
          const SizedBox(height: 16),
          MPText(
            'Stagger Direction',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: context.mp.subtitleColor,
            ),
            fontSize: 14,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              _DirectionChip(
                label: 'Forward',
                direction: MPStaggerDirection.forward,
                icon: Icons.arrow_forward,
              ),
              _DirectionChip(
                label: 'Backward',
                direction: MPStaggerDirection.backward,
                icon: Icons.arrow_back,
              ),
              _DirectionChip(
                label: 'Center Out',
                direction: MPStaggerDirection.centerOut,
                icon: Icons.expand,
              ),
              _DirectionChip(
                label: 'Center In',
                direction: MPStaggerDirection.centerIn,
                icon: Icons.compress,
              ),
            ],
          ),
          const SizedBox(height: 16),
          MPText(
            'Animation Type',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: context.mp.subtitleColor,
            ),
            fontSize: 14,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _AnimationTypeChip(
                label: 'Fade',
                type: MPStaggerAnimationType.fade,
              ),
              _AnimationTypeChip(
                label: 'Slide + Fade',
                type: MPStaggerAnimationType.slideFade,
              ),
              _AnimationTypeChip(
                label: 'Scale + Fade',
                type: MPStaggerAnimationType.scaleFade,
              ),
              _AnimationTypeChip(
                label: 'All Effects',
                type: MPStaggerAnimationType.slideScaleFade,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              MPText(
                'View Mode:',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: context.mp.subtitleColor,
                ),
                fontSize: 14,
              ),
              const SizedBox(width: 12),
              _ViewToggleChip(label: 'List', isGrid: false),
              const SizedBox(width: 8),
              _ViewToggleChip(label: 'Grid', isGrid: true),
            ],
          ),
        ],
      ),
    );
  }
}

class _DirectionChip extends StatefulWidget {
  const _DirectionChip({
    required this.label,
    required this.direction,
    required this.icon,
  });

  final String label;
  final MPStaggerDirection direction;
  final IconData icon;

  @override
  State<_DirectionChip> createState() => _DirectionChipState();
}

class _DirectionChipState extends State<_DirectionChip> {
  @override
  Widget build(BuildContext context) {
    final page = context.findAncestorStateOfType<_StaggerAnimationDemoPageState>();
    final isSelected = page?._direction == widget.direction;

    return GestureDetector(
      onTap: () {
        page?.setState(() {
          page._direction = widget.direction;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? context.mp.primary
              : context.mp.adaptiveBackgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? context.mp.primary : context.mp.borderColor,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon,
              size: 16,
              color: isSelected ? Colors.white : context.mp.subtitleColor,
            ),
            const SizedBox(width: 6),
            MPText(
              widget.label,
              style: TextStyle(
                color: isSelected ? Colors.white : context.mp.textColor,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
              fontSize: 12,
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimationTypeChip extends StatefulWidget {
  const _AnimationTypeChip({
    required this.label,
    required this.type,
  });

  final String label;
  final MPStaggerAnimationType type;

  @override
  State<_AnimationTypeChip> createState() => _AnimationTypeChipState();
}

class _AnimationTypeChipState extends State<_AnimationTypeChip> {
  @override
  Widget build(BuildContext context) {
    final page = context.findAncestorStateOfType<_StaggerAnimationDemoPageState>();
    final isSelected = page?._animationType == widget.type;

    return GestureDetector(
      onTap: () {
        page?.setState(() {
          page._animationType = widget.type;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? context.mp.primary
              : context.mp.adaptiveBackgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? context.mp.primary : context.mp.borderColor,
          ),
        ),
        child: MPText(
          widget.label,
          style: TextStyle(
            color: isSelected ? Colors.white : context.mp.textColor,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
          fontSize: 12,
        ),
      ),
    );
  }
}

class _ViewToggleChip extends StatefulWidget {
  const _ViewToggleChip({
    required this.label,
    required this.isGrid,
  });

  final String label;
  final bool isGrid;

  @override
  State<_ViewToggleChip> createState() => _ViewToggleChipState();
}

class _ViewToggleChipState extends State<_ViewToggleChip> {
  @override
  Widget build(BuildContext context) {
    final page = context.findAncestorStateOfType<_StaggerAnimationDemoPageState>();
    final isSelected = page?._isGridView == widget.isGrid;

    return GestureDetector(
      onTap: () {
        page?.setState(() {
          page._isGridView = widget.isGrid;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? context.mp.primary
              : context.mp.adaptiveBackgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? context.mp.primary : context.mp.borderColor,
          ),
        ),
        child: MPText(
          widget.label,
          style: TextStyle(
            color: isSelected ? Colors.white : context.mp.textColor,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
          fontSize: 12,
        ),
      ),
    );
  }
}

class _StaggerItem extends StatelessWidget {
  const _StaggerItem({
    required this.title,
    required this.index,
  });

  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.mp.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.mp.borderColor, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  context.mp.primary,
                  context.mp.primary.withValues(alpha: 0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: MPText(
                '${index + 1}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MPText(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: context.mp.textColor,
                  ),
                  fontSize: 14,
                ),
                const SizedBox(height: 4),
                MPText(
                  'Stagger animation demo item',
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
    );
  }
}

class _GridItem extends StatelessWidget {
  const _GridItem({
    required this.title,
    required this.index,
  });

  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.mp.cardColor,
            context.mp.cardColor.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.mp.borderColor, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: context.mp.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: MPText(
                '${index + 1}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: context.mp.primary,
                ),
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 8),
          MPText(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: context.mp.textColor,
            ),
            fontSize: 12,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

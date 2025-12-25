import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

/// Demo page for MPListAnimator animations
///
/// Demonstrates list and grid animation capabilities.
class ListAnimatorDemoPage extends StatefulWidget {
  const ListAnimatorDemoPage({super.key});

  @override
  State<ListAnimatorDemoPage> createState() => _ListAnimatorDemoPageState();
}

class _ListAnimatorDemoPageState extends State<ListAnimatorDemoPage> {
  MPStaggerMode _staggerMode = MPStaggerMode.staggered;
  MPListAnimationType _animationType = MPListAnimationType.fadeScale;

  final List<String> _items = List.generate(
    20,
    (index) => 'Item ${index + 1}',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MPText(
          'List Animator',
          fontSize: 20,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: context.mp.adaptiveBackgroundColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          _ControlsCard(),
          Expanded(
            child: MPListAnimator(
              staggerMode: _staggerMode,
              staggerDelay: const Duration(milliseconds: 50),
              animationType: _animationType,
              itemCount: _items.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return _ListItem(
                  title: _items[index],
                  index: index,
                );
              },
            ),
          ),
        ],
      ),
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
            'Stagger Mode',
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
              _StaggerModeChip(
                label: 'Simultaneous',
                mode: MPStaggerMode.simultaneous,
              ),
              _StaggerModeChip(
                label: 'Sequential',
                mode: MPStaggerMode.sequential,
              ),
              _StaggerModeChip(
                label: 'Staggered',
                mode: MPStaggerMode.staggered,
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
                type: MPListAnimationType.fade,
              ),
              _AnimationTypeChip(
                label: 'Slide Left',
                type: MPListAnimationType.slideLeft,
              ),
              _AnimationTypeChip(
                label: 'Slide Right',
                type: MPListAnimationType.slideRight,
              ),
              _AnimationTypeChip(
                label: 'Slide Up',
                type: MPListAnimationType.slideUp,
              ),
              _AnimationTypeChip(
                label: 'Scale',
                type: MPListAnimationType.scale,
              ),
              _AnimationTypeChip(
                label: 'Fade + Scale',
                type: MPListAnimationType.fadeScale,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StaggerModeChip extends StatefulWidget {
  const _StaggerModeChip({
    required this.label,
    required this.mode,
  });

  final String label;
  final MPStaggerMode mode;

  @override
  State<_StaggerModeChip> createState() => _StaggerModeChipState();
}

class _StaggerModeChipState extends State<_StaggerModeChip> {
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    final page = context.findAncestorStateOfType<_ListAnimatorDemoPageState>();
    _isSelected = page?._staggerMode == widget.mode;
  }

  @override
  Widget build(BuildContext context) {
    final page = context.findAncestorStateOfType<_ListAnimatorDemoPageState>();
    _isSelected = page?._staggerMode == widget.mode;

    return GestureDetector(
      onTap: () {
        setState(() {
          page?._staggerMode = widget.mode;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: _isSelected
              ? context.mp.primary
              : context.mp.adaptiveBackgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isSelected ? context.mp.primary : context.mp.borderColor,
          ),
        ),
        child: MPText(
          widget.label,
          style: TextStyle(
            color: _isSelected ? Colors.white : context.mp.textColor,
            fontWeight: _isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
          fontSize: 12,
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
  final MPListAnimationType type;

  @override
  State<_AnimationTypeChip> createState() => _AnimationTypeChipState();
}

class _AnimationTypeChipState extends State<_AnimationTypeChip> {
  @override
  Widget build(BuildContext context) {
    final page = context.findAncestorStateOfType<_ListAnimatorDemoPageState>();
    final isSelected = page?._animationType == widget.type;

    return GestureDetector(
      onTap: () {
        setState(() {
          page?._animationType = widget.type;
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

class _ListItem extends StatelessWidget {
  const _ListItem({
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
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: context.mp.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
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
          const SizedBox(width: 12),
          Expanded(
            child: MPText(
              title,
              style: TextStyle(color: context.mp.textColor),
              fontSize: 14,
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: context.mp.subtitleColor,
            size: 20,
          ),
        ],
      ),
    );
  }
}

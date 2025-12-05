import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

/// Page demonstrating Phase 3 Component Enhancements
class ComponentEnhancementsPage extends StatelessWidget {
  const ComponentEnhancementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MPText.subhead('Component Enhancements'),
        backgroundColor: context.mp.adaptiveBackgroundColor,
        elevation: 0,
      ),
      backgroundColor: context.mp.adaptiveBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Responsive Cards
            _buildSection(
              title: '3.1 Responsive Cards',
              description:
                  'Cards that adapt to different screen sizes and orientations',
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  // Basic responsive card
                  MPCard(
                    variant: MPCardVariant.surface,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MPText.subhead(
                          'Responsive Card',
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(height: 4),
                        MPText.small(
                          'Adapts layout based on screen size',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Media card with responsive image
                  MPCard.media(
                    mediaData: MPCardMediaData(
                      title: 'Media Card',
                      subtitle: 'Responsive image and content',
                      imageUrl:
                          'https://picsum.photos/seed/responsive/400/300.jpg',
                      description:
                          'This card demonstrates responsive media handling with proper image sizing and content adaptation.',
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Compact landscape card
                  MPCard(
                    variant: MPCardVariant.outlined,
                    layout: MPCardLayout.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MPText.subhead(
                          'Compact Card',
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(height: 4),
                        MPText.small(
                          'Optimized for landscape',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Section 2: Enhanced Buttons
            _buildSection(
              title: '3.2 Enhanced Buttons',
              description:
                  'Buttons with improved states, interactions, and animations',
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  MPButton(
                    text: 'Primary',
                    variant: MPButtonVariant.primary,
                    onPressed: () {},
                  ),
                  MPButton(
                    text: 'Loading',
                    variant: MPButtonVariant.primary,
                    loading: true,
                    onPressed: () {},
                  ),
                  MPButton(
                    text: 'Success',
                    variant: MPButtonVariant.success,
                    onPressed: () {},
                  ),
                  MPButton(
                    text: 'Danger',
                    variant: MPButtonVariant.danger,
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Section 3: Loading States
            _buildSection(
              title: '3.3 Loading States',
              description:
                  'Consistent loading indicators and animations across components',
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  // Skeleton loaders
                  Row(
                    children: [
                      Expanded(
                        child: MPSkeleton.text(
                          width: double.infinity,
                          height: 20,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: MPSkeleton.avatar(
                          width: 48,
                          height: 48,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Loading overlay
                  SizedBox(
                    height: 120,
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: context.mp.neutral10,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: MPText('Content being loaded...'),
                          ),
                        ),
                        MPLoadingOverlay(
                          isLoading: true,
                          loadingText: 'Loading...',
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: context.mp.neutral10,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: MPText('Content being loaded...'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Section 4: Text Overflow Handling
            _buildSection(
              title: '3.4 Text Overflow Handling',
              description:
                  'Proper text truncation, ellipsis, and expandable content',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  MPText.subhead(
                    'Text Overflow Examples',
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 16),
                  // Ellipsis overflow
                  MPText(
                    'This is a very long text that should be truncated with an ellipsis when it exceeds available space.',
                    maxLines: 2,
                    overflowBehavior: MPTextOverflowBehavior.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Fade overflow
                  MPText(
                    'This is a very long text that should fade out at edges when it exceeds available space.',
                    maxLines: 2,
                    overflowBehavior: MPTextOverflowBehavior.fade,
                  ),
                  const SizedBox(height: 8),
                  // Expandable overflow
                  MPText(
                    'This is a very long text that can be expanded to show full content when user taps on "Show more". It contains enough text to demonstrate expandable functionality with proper animation and state management.',
                    overflowBehavior: MPTextOverflowBehavior.expandable,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Section 5: Orientation-Aware Components
            _buildSection(
              title: '3.5 Orientation-Aware Components',
              description:
                  'Components that adapt to portrait and landscape orientations',
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  // Orientation-aware text field
                  MPCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MPText.subhead(
                          'Orientation-Aware TextField',
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(height: 8),
                        MPTextField(
                          TextEditingController(),
                          hint: 'Type here...',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Orientation-aware theme toggle
                  MPCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MPText.subhead(
                          'Orientation-Aware Theme Toggle',
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(height: 8),
                        const MPThemeToggle(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Orientation-aware skeleton
                  MPCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MPText.subhead(
                          'Orientation-Aware Skeleton',
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            MPSkeleton.avatar(
                              width: 48,
                              height: 48,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MPSkeleton.text(
                                    height: 16,
                                    width: double.infinity,
                                  ),
                                  const SizedBox(height: 8),
                                  MPSkeleton.text(
                                    height: 12,
                                    width: double.infinity,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Section 6: Interactive Demo
            _buildSection(
              title: 'Interactive Demo',
              description: 'Combine all enhancements in a real-world example',
              child: MPCard.withSections(
                headerData: MPCardHeaderData(
                  title: 'Interactive Demo',
                  subtitle: 'Combine all enhancements',
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MPText.body(
                      'This card showcases all Phase 3 enhancements working together:',
                    ),
                    const SizedBox(height: 12),
                    ...[
                      'Responsive layout',
                      'Enhanced interactions',
                      'Loading states',
                      'Overflow handling',
                      'Orientation awareness'
                    ].map(
                      (feature) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              size: 16,
                              color: context.mp.primary,
                            ),
                            const SizedBox(width: 8),
                            MPText.small(feature),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                footerData: MPCardFooterData(
                  actions: [
                    MPButton(
                      text: 'Try It',
                      variant: MPButtonVariant.primary,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                MPText('All enhancements working together!'),
                            backgroundColor: context.mp.primary,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String description,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          title,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 4),
        MPText.small(
          description,
          color: Colors.grey,
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

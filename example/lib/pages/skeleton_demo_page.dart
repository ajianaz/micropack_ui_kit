import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class SkeletonDemoPage extends StatelessWidget {
  const SkeletonDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: MPText.head(
          'Skeleton Demo',
          style: TextStyle(color: context.mp.textColor),
          fontSize: 20,
        ),
        backgroundColor: context.mp.adaptiveBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: MPResponsivePadding.card(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTypes(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildCardSkeletons(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildListSkeletons(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildExamples(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTypes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Skeleton Types',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _SkeletonCard(
          title: 'Text Skeleton',
          description: 'Loading text placeholder',
          context: context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MPSkeleton.text(width: double.infinity),
              SizedBox(height: 8),
              MPSkeleton.text(width: 200),
              SizedBox(height: 8),
              MPSkeleton.text(width: 150),
            ],
          ),
        ),
        SizedBox(height: 16),
        _SkeletonCard(
          title: 'Avatar Skeleton',
          description: 'Loading avatar placeholder',
          context: context,
          child: Row(
            children: [
              MPSkeleton.avatar(width: 64, height: 64),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MPSkeleton.text(width: 150),
                    SizedBox(height: 8),
                    MPSkeleton.text(width: 100),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _SkeletonCard(
          title: 'Image Skeleton',
          description: 'Loading image placeholder',
          context: context,
          child: MPSkeleton(
            width: double.infinity,
            height: 200,
          ),
        ),
        SizedBox(height: 16),
        _SkeletonCard(
          title: 'Card Skeleton',
          description: 'Loading card placeholder',
          context: context,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.mp.cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: context.mp.borderColor,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MPSkeleton(width: 100, height: 100),
                SizedBox(height: 12),
                MPSkeleton.text(width: 200),
                SizedBox(height: 8),
                MPSkeleton.text(width: 150),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCardSkeletons(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Card Skeletons',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: List.generate(2, (index) {
            return Container(
              width: 300,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.mp.cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: context.mp.borderColor,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      MPSkeleton.avatar(width: 48, height: 48),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MPSkeleton.text(width: 120),
                            SizedBox(height: 6),
                            MPSkeleton.text(width: 80),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  MPSkeleton(width: double.infinity, height: 120),
                  SizedBox(height: 12),
                  MPSkeleton.text(width: double.infinity),
                  SizedBox(height: 6),
                  MPSkeleton.text(width: 200),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildListSkeletons(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'List Skeletons',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _SkeletonCard(
          title: 'List Items',
          description: 'Loading list items',
          context: context,
          child: Column(
            children: List.generate(4, (index) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: context.mp.dividerColor,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    MPSkeleton.avatar(width: 48, height: 48),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MPSkeleton.text(width: 200),
                          SizedBox(height: 6),
                          MPSkeleton.text(width: 150),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildExamples(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Practical Examples',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _ExampleCard(
          title: 'Profile Loading',
          description: 'User profile skeleton',
          context: context,
          child: Column(
            children: [
              Center(
                child: MPSkeleton.avatar(width: 100, height: 100),
              ),
              SizedBox(height: 16),
              MPSkeleton.text(width: 200),
              SizedBox(height: 8),
              MPSkeleton.text(width: 150),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: MPSkeleton.button(height: 48),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: MPSkeleton.button(height: 48),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _ExampleCard(
          title: 'Feed Loading',
          description: 'Social media feed skeleton',
          context: context,
          child: Column(
            children: List.generate(2, (index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context.mp.cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: context.mp.borderColor,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        MPSkeleton.avatar(width: 48, height: 48),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MPSkeleton.text(width: 150),
                              SizedBox(height: 6),
                              MPSkeleton.text(width: 100),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    MPSkeleton(width: double.infinity, height: 150),
                    SizedBox(height: 12),
                    MPSkeleton.text(width: double.infinity),
                    SizedBox(height: 6),
                    MPSkeleton.text(width: 200),
                  ],
                ),
              );
            }),
          ),
        ),
        SizedBox(height: 16),
        _ExampleCard(
          title: 'Product Grid Loading',
          description: 'E-commerce product grid skeleton',
          context: context,
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(4, (index) {
              return Container(
                width: 160,
                decoration: BoxDecoration(
                  color: context.mp.cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: context.mp.borderColor,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MPSkeleton(
                      width: double.infinity,
                      height: 120,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MPSkeleton.text(width: 120),
                          SizedBox(height: 6),
                          MPSkeleton.text(width: 80),
                          SizedBox(height: 12),
                          MPSkeleton.button(width: double.infinity, height: 36),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _SkeletonCard({
    required String title,
    required String description,
    required Widget child,
    required BuildContext context,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.mp.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.mp.borderColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MPText.head(
            title,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 4),
          MPText.label(
            description,
            style: TextStyle(
              color: context.mp.subtitleColor,
            ),
          ),
          SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _ExampleCard({
    required String title,
    required String description,
    required Widget child,
    required BuildContext context,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: context.mp.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.mp.borderColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MPText.head(
                  title,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 4),
                MPText.label(
                  description,
                  style: TextStyle(
                    color: context.mp.subtitleColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: child,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class TooltipDemoPage extends StatelessWidget {
  const TooltipDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: MPText.head(
          'Tooltip Demo',
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
            _buildBasicTooltips(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildRichTooltips(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildPositionedTooltips(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildExamples(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicTooltips(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Basic Tooltips',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _TooltipCard(
          context: context,
          title: 'Simple Text',
          description: 'Basic tooltip with text',
          child: Wrap(
            spacing: 12,
            children: [
              MPTooltip(
                message: 'This is a tooltip',
                child: Icon(Icons.help_outline),
              ),
              MPTooltip(
                message: 'Click to learn more',
                child: IconButton(
                  icon: Icon(Icons.info_outline),
                  onPressed: () {},
                ),
              ),
              MPTooltip(
                message: 'Add new item',
                child: FloatingActionButton(
                  onPressed: () {},
                  mini: true,
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _TooltipCard(
          context: context,
          title: 'With Duration',
          description: 'Custom tooltip duration',
          child: MPTooltip(
            message: 'This tooltip stays longer',
            showDuration: const Duration(seconds: 3),
            child: MPButton(
              text: 'Hover Me',
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRichTooltips(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Rich Tooltips',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _TooltipCard(
          context: context,
          title: 'With Icon',
          description: 'Tooltip with leading icon',
          child: MPTooltip(
            message: 'Feature available in Pro',
            child: Icon(Icons.lock),
          ),
        ),
        SizedBox(height: 16),
        _TooltipCard(
          context: context,
          title: 'Multi-line',
          description: 'Tooltip with multiple lines',
          child: MPTooltip(
            message: 'This is a longer tooltip\nwith multiple lines\nto show more information',
            child: MPButton(
              text: 'Rich Tooltip',
              onPressed: () {},
            ),
          ),
        ),
        SizedBox(height: 16),
        _TooltipCard(
          context: context,
          title: 'Styled Content',
          description: 'Custom styled tooltip',
          child: MPTooltip(
            message: 'Success',
            variant: MPTooltipVariant.success,
            child: Icon(Icons.done),
          ),
        ),
      ],
    );
  }

  Widget _buildPositionedTooltips(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Positioned Tooltips',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _TooltipCard(
          context: context,
          title: 'Top Position',
          description: 'Tooltip positioned above',
          child: MPTooltip(
            message: 'Positioned at top',
            preferBelow: false,
            verticalOffset: -8,
            child: MPButton(
              text: 'Top',
              onPressed: () {},
            ),
          ),
        ),
        SizedBox(height: 16),
        _TooltipCard(
          context: context,
          title: 'Bottom Position',
          description: 'Tooltip positioned below',
          child: MPTooltip(
            message: 'Positioned at bottom',
            preferBelow: true,
            verticalOffset: 8,
            child: MPButton(
              text: 'Bottom',
              onPressed: () {},
            ),
          ),
        ),
        SizedBox(height: 16),
        _TooltipCard(
          context: context,
          title: 'Left Position',
          description: 'Tooltip positioned on left',
          child: MPTooltip(
            message: 'Positioned at left',
            child: MPButton(
              text: 'Left',
              onPressed: () {},
            ),
          ),
        ),
        SizedBox(height: 16),
        _TooltipCard(
          context: context,
          title: 'Right Position',
          description: 'Tooltip positioned on right',
          child: MPTooltip(
            message: 'Positioned at right',
            child: MPButton(
              text: 'Right',
              onPressed: () {},
            ),
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
          context: context,
          title: 'Action Buttons',
          description: 'Tooltips for button actions',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MPTooltip(
                message: 'Refresh data',
                child: IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {},
                ),
              ),
              MPTooltip(
                message: 'Download file',
                child: IconButton(
                  icon: Icon(Icons.download),
                  onPressed: () {},
                ),
              ),
              MPTooltip(
                message: 'Share with others',
                child: IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {},
                ),
              ),
              MPTooltip(
                message: 'More options',
                child: IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _ExampleCard(
          context: context,
          title: 'Form Field Help',
          description: 'Contextual help for form fields',
          child: Container(
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
                Row(
                  children: [
                    Expanded(
                      child: MPText.head('Password'),
                    ),
                    MPTooltip(
                      message: 'Password must be at least 8 characters\nwith uppercase and lowercase letters',
                      child: Icon(Icons.help_outline),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  decoration: BoxDecoration(
                    color: context.mp.cardColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: context.mp.borderColor,
                      width: 1,
                    ),
                  ),
                  child: Text('•••••••••'),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
        _ExampleCard(
          context: context,
          title: 'Feature Indicator',
          description: 'Tooltip showing feature status',
          child: Row(
            children: [
              Expanded(
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
                  child: Row(
                    children: [
                      MPTooltip(
                        message: 'Premium feature\nUpgrade to access',
                        variant: MPTooltipVariant.warning,
                        child: Icon(Icons.videocam),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MPText.head('Video Call', fontSize: 14),
                            MPText.label(
                              'Start video conference',
                              style: TextStyle(
                                color: context.mp.subtitleColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _ExampleCard(
          context: context,
          title: 'Icon Actions',
          description: 'Tooltips for icon-only actions',
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: context.mp.cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: context.mp.borderColor,
                width: 1,
              ),
            ),
            child: Wrap(
              spacing: 16,
              children: [
                MPTooltip(
                  message: 'Edit profile',
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: context.mp.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.edit, color: context.mp.primary),
                  ),
                ),
                MPTooltip(
                  message: 'Delete item',
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.delete, color: Colors.red),
                  ),
                ),
                MPTooltip(
                  message: 'Favorite',
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.amber.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.star, color: Colors.amber),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _TooltipCard({
    required BuildContext context,
    required String title,
    required String description,
    required Widget child,
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
    required BuildContext context,
    required String title,
    required String description,
    required Widget child,
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
            color: context.mp.adaptiveShadowColor.withValues(alpha: 0.05),
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: child,
          ),
        ],
      ),
    );
  }
}

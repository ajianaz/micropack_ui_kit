import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class SnackbarDemoPage extends StatelessWidget {
  const SnackbarDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: MPText.head(
          'Snackbar Demo',
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
            _buildVariants(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildWithDuration(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildWithActions(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildPositions(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildExamples(context),
          ],
        ),
      ),
    );
  }

  Widget _buildVariants(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Snackbar Variants',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _SnackbarCard(
          title: 'Success',
          description: 'Success message',
          action: () => _showSuccess(context),
        ),
        SizedBox(height: 16),
        _SnackbarCard(
          title: 'Error',
          description: 'Error message',
          action: () => _showError(context),
        ),
        SizedBox(height: 16),
        _SnackbarCard(
          title: 'Info',
          description: 'Information message',
          action: () => _showInfo(context),
        ),
        SizedBox(height: 16),
        _SnackbarCard(
          title: 'Warning',
          description: 'Warning message',
          action: () => _showWarning(context),
        ),
      ],
    );
  }

  Widget _buildWithDuration(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Duration Controls',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _SnackbarCard(
          title: 'Short Duration',
          description: '2 seconds duration',
          action: () => _showShortDuration(context),
        ),
        SizedBox(height: 16),
        _SnackbarCard(
          title: 'Medium Duration',
          description: '4 seconds duration',
          action: () => _showMediumDuration(context),
        ),
        SizedBox(height: 16),
        _SnackbarCard(
          title: 'Long Duration',
          description: '6 seconds duration',
          action: () => _showLongDuration(context),
        ),
      ],
    );
  }

  Widget _buildWithActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'With Actions',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _SnackbarCard(
          title: 'Undo Action',
          description: 'Snackbar with undo button',
          action: () => _showUndo(context),
        ),
        SizedBox(height: 16),
        _SnackbarCard(
          title: 'Retry Action',
          description: 'Snackbar with retry button',
          action: () => _showRetry(context),
        ),
        SizedBox(height: 16),
        _SnackbarCard(
          title: 'Learn More',
          description: 'Snackbar with learn more link',
          action: () => _showLearnMore(context),
        ),
      ],
    );
  }

  Widget _buildPositions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Position Variations',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _SnackbarCard(
          title: 'Top Position',
          description: 'Snackbar at top of screen',
          action: () => _showTopPosition(context),
        ),
        SizedBox(height: 16),
        _SnackbarCard(
          title: 'Bottom Position',
          description: 'Snackbar at bottom of screen',
          action: () => _showBottomPosition(context),
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
          title: 'Form Success',
          description: 'Form submission success',
          context: context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MPText.label('Enter your email'),
              SizedBox(height: 8),
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
                child: Text('user@example.com'),
              ),
              SizedBox(height: 16),
              MPButton(
                text: 'Subscribe',
                variant: MPButtonVariant.primary,
                onPressed: () => _showFormSuccess(context),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _ExampleCard(
          title: 'Delete Confirmation',
          description: 'Item deletion with undo',
          context: context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
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
                    Icon(Icons.delete, color: Colors.red),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MPText.head('Delete Item', fontSize: 14),
                          MPText.label(
                            'This action cannot be undone',
                            style: TextStyle(
                              color: context.mp.subtitleColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              MPButton(
                text: 'Delete',
                variant: MPButtonVariant.danger,
                onPressed: () => _showDeleteConfirmation(context),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _ExampleCard(
          title: 'Network Status',
          description: 'Online/offline status updates',
          context: context,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    MPButton(
                      text: 'Go Online',
                      variant: MPButtonVariant.outlined,
                      onPressed: () => _showOnline(context),
                    ),
                    SizedBox(height: 12),
                    MPButton(
                      text: 'Go Offline',
                      variant: MPButtonVariant.outlined,
                      onPressed: () => _showOffline(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Show Methods

  void _showSuccess(BuildContext context) {
    MPSnackbar.success(
      context,
      message: 'Success! Your changes have been saved.',
    );
  }

  void _showError(BuildContext context) {
    MPSnackbar.error(
      context,
      message: 'Error! Something went wrong. Please try again.',
    );
  }

  void _showInfo(BuildContext context) {
    MPSnackbar.info(
      context,
      message: 'Info! You have 3 new messages.',
    );
  }

  void _showWarning(BuildContext context) {
    MPSnackbar.warning(
      context,
      message: 'Warning! Your session will expire in 5 minutes.',
    );
  }

  void _showShortDuration(BuildContext context) {
    MPSnackbar.info(
      context,
      message: 'This message will disappear in 2 seconds.',
      duration: const Duration(seconds: 2),
    );
  }

  void _showMediumDuration(BuildContext context) {
    MPSnackbar.info(
      context,
      message: 'This message will disappear in 4 seconds.',
      duration: const Duration(seconds: 4),
    );
  }

  void _showLongDuration(BuildContext context) {
    MPSnackbar.info(
      context,
      message: 'This message will disappear in 6 seconds.',
      duration: const Duration(seconds: 6),
    );
  }

  void _showUndo(BuildContext context) {
    MPSnackbar.show(
      context,
      message: 'Item deleted',
      action: SnackBarAction(
        label: 'UNDO',
        onPressed: () {
          // Handle undo
        },
      ),
    );
  }

  void _showRetry(BuildContext context) {
    MPSnackbar.show(
      context,
      message: 'Connection failed',
      action: SnackBarAction(
        label: 'RETRY',
        onPressed: () {
          // Handle retry
        },
      ),
    );
  }

  void _showLearnMore(BuildContext context) {
    MPSnackbar.show(
      context,
      message: 'New feature available',
      action: SnackBarAction(
        label: 'LEARN MORE',
        onPressed: () {
          // Handle learn more
        },
      ),
    );
  }

  void _showTopPosition(BuildContext context) {
    MPSnackbar.info(
      context,
      message: 'This is a top positioned snackbar',
    );
  }

  void _showBottomPosition(BuildContext context) {
    MPSnackbar.success(
      context,
      message: 'This is a bottom positioned snackbar',
    );
  }

  void _showFormSuccess(BuildContext context) {
    MPSnackbar.success(
      context,
      message: 'Successfully subscribed!',
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    MPSnackbar.info(
      context,
      message: 'Item deleted successfully',
    );
  }

  void _showOnline(BuildContext context) {
    MPSnackbar.success(
      context,
      message: 'You are now online',
    );
  }

  void _showOffline(BuildContext context) {
    MPSnackbar.warning(
      context,
      message: 'You are now offline. Some features may be limited.',
    );
  }

  // Widget Helpers

  Widget _SnackbarCard({
    required String title,
    required String description,
    required VoidCallback action,
  }) {
    return Builder(
      builder: (context) => GestureDetector(
        onTap: action,
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
          child: Row(
            children: [
              _VariantIcon(title),
              SizedBox(width: 16),
              Expanded(
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
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _VariantColor(title).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: _VariantColor(title),
                  size: 16,
                ),
              ),
            ],
          ),
        ),
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
            padding: const EdgeInsets.all(20),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _VariantIcon(String variant) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: _VariantColor(variant).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Icon(
          _VariantIconData(variant),
          color: _VariantColor(variant),
          size: 24,
        ),
      ),
    );
  }

  IconData _VariantIconData(String variant) {
    switch (variant) {
      case 'Success':
        return Icons.check_circle;
      case 'Error':
        return Icons.error;
      case 'Info':
        return Icons.info;
      case 'Warning':
        return Icons.warning;
      default:
        return Icons.info;
    }
  }

  Color _VariantColor(String variant) {
    switch (variant) {
      case 'Success':
        return Colors.green;
      case 'Error':
        return Colors.red;
      case 'Info':
        return Colors.blue;
      case 'Warning':
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }
}

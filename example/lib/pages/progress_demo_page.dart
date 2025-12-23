import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class ProgressDemoPage extends StatefulWidget {
  const ProgressDemoPage({super.key});

  @override
  State<ProgressDemoPage> createState() => _ProgressDemoPageState();
}

class _ProgressDemoPageState extends State<ProgressDemoPage> {
  double _linearProgress1 = 0.3;
  double _linearProgress2 = 0.7;
  double _linearProgress3 = 0.0;
  double _circularProgress = 0.6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: MPText.head(
          'Progress Demo',
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
            _buildLinearProgress(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildCircularProgress(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildProgressStates(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildExamples(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLinearProgress(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Linear Progress',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _ProgressCard(
          title: 'Determinate',
          description: 'Progress with known value',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MPProgressBar.linear(
                value: _linearProgress1,
              ),
              SizedBox(height: 12),
              MPText.label(
                '${(_linearProgress1 * 100).toInt()}%',
                style: TextStyle(
                  color: context.mp.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              Slider(
                value: _linearProgress1,
                onChanged: (value) {
                  setState(() {
                    _linearProgress1 = value;
                  });
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _ProgressCard(
          title: 'High Progress',
          description: 'Progress with high value',
          child: MPProgressBar.linear(
            value: _linearProgress2,
          ),
        ),
        SizedBox(height: 16),
        _ProgressCard(
          title: 'Low Progress',
          description: 'Progress with low value',
          child: MPProgressBar.linear(
            value: _linearProgress3,
          ),
        ),
      ],
    );
  }

  Widget _buildCircularProgress(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Circular Progress',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _ProgressCard(
          title: 'Standard',
          description: 'Circular progress indicator',
          child: Column(
            children: [
              MPProgressBar.circular(
                value: _circularProgress,
              ),
              SizedBox(height: 16),
              Slider(
                value: _circularProgress,
                onChanged: (value) {
                  setState(() {
                    _circularProgress = value;
                  });
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _ProgressCard(
          title: 'Indeterminate',
          description: 'Unknown progress duration',
          child: MPProgressBar.circular(
            value: 0.0,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressStates(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Progress States',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _ProgressCard(
          title: 'Completed',
          description: '100% progress',
          child: const MPProgressBar.linear(
            value: 1.0,
          ),
        ),
        SizedBox(height: 16),
        _ProgressCard(
          title: 'Loading',
          description: 'Indeterminate state',
          child: MPProgressBar.linear(
            value: 0.0,
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
          title: 'File Upload',
          description: 'Upload progress indicator',
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.cloud_upload, color: context.mp.primary),
                  SizedBox(width: 16),
                  Expanded(
                    child: MPText.head('Uploading file.pdf'),
                  ),
                  MPText.label('75%'),
                ],
              ),
              SizedBox(height: 16),
              const MPProgressBar.linear(
                value: 0.75,
              ),
              SizedBox(height: 8),
              MPText.label(
                '75 MB of 100 MB uploaded',
                style: TextStyle(
                  color: context.mp.subtitleColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _ExampleCard(
          title: 'Form Completion',
          description: 'Multi-step form progress',
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.format_list_numbered, color: context.mp.primary),
                  SizedBox(width: 16),
                  Expanded(
                    child: MPText.head('Step 3 of 5'),
                  ),
                  MPText.label('60%'),
                ],
              ),
              SizedBox(height: 16),
              const MPProgressBar.linear(
                value: 0.6,
              ),
              SizedBox(height: 8),
              MPText.label(
                'Please complete the remaining fields',
                style: TextStyle(
                  color: context.mp.subtitleColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _ExampleCard(
          title: 'Data Sync',
          description: 'Synchronization status',
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.sync, color: context.mp.primary),
                        SizedBox(width: 12),
                        MPText.head('Syncing data...'),
                      ],
                    ),
                    SizedBox(height: 16),
                    MPProgressBar.linear(
                      value: 0.0,
                    ),
                    SizedBox(height: 8),
                    MPText.label(
                      'Downloading latest changes',
                      style: TextStyle(
                        color: context.mp.subtitleColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              MPProgressBar.circular(
                value: 0.0,
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _ExampleCard(
          title: 'Download Manager',
          description: 'Multiple file downloads',
          child: Column(
            children: [
              _DownloadItem('File 1', 0.9),
              SizedBox(height: 12),
              _DownloadItem('File 2', 0.45),
              SizedBox(height: 12),
              _DownloadItem('File 3', 0.15),
            ],
          ),
        ),
      ],
    );
  }

  Widget _ProgressCard({
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _DownloadItem(String name, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.description, color: context.mp.primary, size: 20),
            SizedBox(width: 12),
            Expanded(child: MPText.head(name, fontSize: 14)),
            MPText.label('${(progress * 100).toInt()}%'),
          ],
        ),
        SizedBox(height: 8),
        MPProgressBar.linear(value: progress),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

/// Demo page for new components added in v0.3.0
///
/// Shows MPCarousel, MPSlidable, MPExpansionTile, MPDataTable, and MPStepper
class NewComponentsDemoPage extends StatefulWidget {
  const NewComponentsDemoPage({super.key});

  @override
  State<NewComponentsDemoPage> createState() => _NewComponentsDemoPageState();
}

class _NewComponentsDemoPageState extends State<NewComponentsDemoPage> {
  // Carousel state
  int _currentCarouselIndex = 0;

  // Stepper state
  int _currentStep = 0;

  // Expansion tile state
  bool _isExpansionTileExpanded = false;

  // Text field controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: MPText.head(
          'New Components Demo',
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
            _buildCarouselSection(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildSlidableSection(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildExpansionTileSection(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildDataTableSection(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildStepperSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCarouselSection(BuildContext context) {
    final carouselItems = [
      {'title': 'Featured 1', 'color': context.mp.primary},
      {'title': 'Featured 2', 'color': context.mp.successColor},
      {'title': 'Featured 3', 'color': context.mp.warningColor},
    ];

    return _SectionCard(
      context: context,
      title: 'MPCarousel',
      description: 'Image/content slider with multiple variants',
      child: Column(
        children: [
          MPCarousel(
            items: carouselItems.map((item) {
              return Container(
                decoration: BoxDecoration(
                  color: item['color'] as Color,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: MPText.head(
                    item['title'] as String,
                    style: const TextStyle(color: Colors.white, fontSize: 32),
                  ),
                ),
              );
            }).toList(),
            onPageChanged: (index, reason) {
              setState(() {
                _currentCarouselIndex = index;
              });
            },
            variant: MPCarouselVariant.standard,
            autoPlay: true,
            infiniteScroll: true,
          ),
          SizedBox(height: MPResponsivePadding.getMd(context)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: carouselItems.asMap().entries.map((entry) {
              return Container(
                width: _currentCarouselIndex == entry.key ? 24 : 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: _currentCarouselIndex == entry.key
                      ? context.mp.primary
                      : context.mp.subtitleColor.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSlidableSection(BuildContext context) {
    return _SectionCard(
      context: context,
      title: 'MPSlidable',
      description: 'Swipeable list items with actions',
      child: Column(
        children: [
          MPSlidable(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.mp.cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: context.mp.borderColor),
              ),
              child: Row(
                children: [
                  Icon(Icons.mail, color: context.mp.primary),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MPText.head('Swipe left for actions', fontSize: 16),
                        MPText.label(
                          'Try swiping this item',
                          style: TextStyle(color: context.mp.subtitleColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            startActions: [
              MPSlidableAction(
                icon: Icons.archive,
                label: 'Archive',
                isDestructive: false,
                onPressed: (context) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: MPText('Archived'),
                      backgroundColor: context.mp.successColor,
                    ),
                  );
                },
              ),
            ],
            endActions: [
              MPSlidableAction(
                icon: Icons.delete,
                label: 'Delete',
                isDestructive: true,
                onPressed: (context) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: MPText('Deleted'),
                      backgroundColor: context.mp.errorColor,
                    ),
                  );
                },
              ),
              MPSlidableAction(
                icon: Icons.share,
                label: 'Share',
                isDestructive: false,
                onPressed: (context) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: MPText('Shared'),
                      backgroundColor: context.mp.primary,
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 12),
          MPSlidable(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.mp.cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: context.mp.borderColor),
              ),
              child: Row(
                children: [
                  Icon(Icons.notification_important,
                      color: context.mp.warningColor),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MPText.head('Important notification', fontSize: 16),
                        MPText.label(
                          'Swipe for quick actions',
                          style: TextStyle(color: context.mp.subtitleColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            startActions: [
              MPSlidableAction(
                icon: Icons.mark_email_read,
                label: 'Read',
                isDestructive: false,
                onPressed: (context) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: MPText('Marked as read'),
                      backgroundColor: context.mp.primary,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExpansionTileSection(BuildContext context) {
    return _SectionCard(
      context: context,
      title: 'MPExpansionTile',
      description: 'Expandable card with adaptive theming',
      child: MPExpansionTile(
        title: MPText.head('Tap to expand', fontSize: 16),
        subtitle: MPText.label(
          'This tile can be expanded/collapsed',
          style: TextStyle(color: context.mp.subtitleColor),
        ),
        leading: Icon(Icons.info_outline, color: context.mp.primary),
        initiallyExpanded: _isExpansionTileExpanded,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MPText.label(
                  'This is the expanded content area. '
                  'You can put any widgets here.',
                  style: TextStyle(color: context.mp.textColor),
                ),
                SizedBox(height: 12),
                MPButton.primary(
                  text: 'Action Button',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: MPText('Action triggered!'),
                        backgroundColor: context.mp.successColor,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTableSection(BuildContext context) {
    final columns = [
      MPDataColumn(
        label: 'Name',
        onSort: (columnIndex, ascending) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: MPText('Sorted by Name'),
              backgroundColor: context.mp.primary,
            ),
          );
          return 0;
        },
      ),
      MPDataColumn(label: 'Age', numeric: true),
      MPDataColumn(label: 'Role'),
      MPDataColumn(label: 'Status'),
    ];

    final rows = [
      ['John Doe', '28', 'Developer', 'Active'],
      ['Jane Smith', '34', 'Designer', 'Active'],
      ['Bob Johnson', '45', 'Manager', 'Inactive'],
      ['Alice Brown', '29', 'Developer', 'Active'],
      ['Charlie Wilson', '38', 'QA Engineer', 'Active'],
    ];

    return _SectionCard(
      context: context,
      title: 'MPDataTable',
      description: 'Data table with alternating row colors',
      child: MPDataTable(
        columns: columns,
        rows: rows,
      ),
    );
  }

  Widget _buildStepperSection(BuildContext context) {
    final steps = [
      MPStep(
        title: MPText.head('Account Details', fontSize: 16),
        subtitle: MPText.label(
          'Enter your account information',
          style: TextStyle(color: context.mp.subtitleColor),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MPTextField(
              _nameController,
              label: 'Full Name',
              hint: 'Enter your name',
              prefixIcon: Icon(Icons.person, color: context.mp.subtitleColor),
            ),
            SizedBox(height: 12),
            MPTextField(
              _emailController,
              label: 'Email',
              hint: 'Enter your email',
              prefixIcon: Icon(Icons.email, color: context.mp.subtitleColor),
            ),
          ],
        ),
      ),
      MPStep(
        title: MPText.head('Preferences', fontSize: 16),
        subtitle: MPText.label(
          'Choose your preferences',
          style: TextStyle(color: context.mp.subtitleColor),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MPText.label('Select your interests:', fontSize: 14),
            SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                MPChip(
                  label: 'Technology',
                  variant: MPChipVariant.primary,
                ),
                MPChip(
                  label: 'Design',
                  variant: MPChipVariant.secondary,
                ),
                MPChip(
                  label: 'Business',
                  variant: MPChipVariant.outlined,
                ),
              ],
            ),
          ],
        ),
      ),
      MPStep(
        title: MPText.head('Confirmation', fontSize: 16),
        subtitle: MPText.label(
          'Review and confirm',
          style: TextStyle(color: context.mp.subtitleColor),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color:
                    context.mp.adaptiveBackgroundColor.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: context.mp.borderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MPText.head('Summary', fontSize: 16),
                  SizedBox(height: 8),
                  MPText.label(
                    '• Account details entered',
                    style: TextStyle(color: context.mp.textColor),
                  ),
                  MPText.label(
                    '• Preferences selected',
                    style: TextStyle(color: context.mp.textColor),
                  ),
                  MPText.label(
                    '• Ready to submit',
                    style: TextStyle(color: context.mp.textColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ];

    return _SectionCard(
      context: context,
      title: 'MPStepper',
      description: 'Step-by-step workflow component',
      child: MPStepper(
        steps: steps,
        currentStep: _currentStep,
        type: StepperType.vertical,
        onContinue: () {
          if (_currentStep < steps.length - 1) {
            setState(() {
              _currentStep++;
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: MPText('Completed!'),
                backgroundColor: context.mp.successColor,
              ),
            );
          }
        },
        onCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep--;
            });
          }
        },
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.context,
    required this.title,
    required this.description,
    required this.child,
  });

  final BuildContext context;
  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
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
                  fontSize: 18,
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
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: child,
          ),
        ],
      ),
    );
  }
}

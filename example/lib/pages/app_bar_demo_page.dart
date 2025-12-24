import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class AppBarDemoPage extends StatelessWidget {
  const AppBarDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: MPText.head(
          'App Bar Demo',
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
            _buildWithActions(context),
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
          'App Bar Variants',
          fontSize: 18,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _PreviewCard(
          title: 'Standard',
          description: 'Clean app bar with bottom border',
          color: Colors.blue,
          onTap: () => _showStandard(context),
        ),
        SizedBox(height: 12),
        _PreviewCard(
          title: 'Elevated',
          description: 'App bar with subtle shadow',
          color: Colors.green,
          onTap: () => _showElevated(context),
        ),
        SizedBox(height: 12),
        _PreviewCard(
          title: 'Transparent',
          description: 'Transparent background',
          color: Colors.purple,
          onTap: () => _showTransparent(context),
        ),
      ],
    );
  }

  Widget _buildWithActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'App Bars with Actions',
          fontSize: 18,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _PreviewCard(
          title: 'With Leading',
          description: 'Back or menu button',
          color: Colors.orange,
          onTap: () => _showWithLeading(context),
        ),
        SizedBox(height: 12),
        _PreviewCard(
          title: 'With Actions',
          description: 'Multiple action buttons',
          color: Colors.cyan,
          onTap: () => _showWithActions(context),
        ),
        SizedBox(height: 12),
        _PreviewCard(
          title: 'With Subtitle',
          description: 'Title with description',
          color: Colors.indigo,
          onTap: () => _showWithSubtitle(context),
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
          fontSize: 18,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _PreviewCard(
          title: 'Search App Bar',
          description: 'With search field',
          color: Colors.teal,
          onTap: () => _showSearchAppBar(context),
        ),
        SizedBox(height: 12),
        _PreviewCard(
          title: 'Profile App Bar',
          description: 'Profile header',
          color: Colors.pink,
          onTap: () => _showProfileAppBar(context),
        ),
        SizedBox(height: 12),
        _PreviewCard(
          title: 'Chat App Bar',
          description: 'Conversation header',
          color: Colors.amber,
          onTap: () => _showChatAppBar(context),
        ),
      ],
    );
  }

  Widget _PreviewCard({
    required String title,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Builder(
      builder: (context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
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
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    Icons.widgets_outlined,
                    color: color,
                    size: 28,
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MPText.head(
                      title,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 6),
                    MPText.label(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: context.mp.subtitleColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: color,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Show Methods - Full screen examples

  void _showStandard(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _AppBarExamplePage(
          title: 'Standard App Bar',
          description: 'Clean design with bottom border',
          child: Column(
            children: [
              MPAppBar(
                title: MPText.head('Home'),
                trailing: IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: Center(
                  child: _ExampleContent('Standard App Bar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showElevated(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _AppBarExamplePage(
          title: 'Elevated App Bar',
          description: 'App bar with shadow effect',
          child: Column(
            children: [
              MPAppBar(
                title: MPText.head('Elevated'),
                variant: MPAppBarVariant.elevated,
                trailing: IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: Center(
                  child: _ExampleContent('Elevated App Bar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTransparent(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _AppBarExamplePage(
          title: 'Transparent App Bar',
          description: 'Transparent background',
          backgroundColor: context.mp.primary,
          child: Column(
            children: [
              MPAppBar(
                title: MPText.head('Transparent'),
                variant: MPAppBarVariant.transparent,
                trailing: IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: Center(
                  child: _ExampleContent('Transparent App Bar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showWithLeading(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _AppBarExamplePage(
          title: 'With Leading',
          description: 'Back or menu button',
          child: Column(
            children: [
              MPAppBar(
                title: MPText.head('Settings'),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {},
                ),
                trailing: IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: Center(
                  child: _ExampleContent('With Leading Widget'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showWithActions(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _AppBarExamplePage(
          title: 'Multiple Actions',
          description: 'Several action buttons',
          child: Column(
            children: [
              MPAppBar(
                title: MPText.head('Photos'),
                actions: [
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.filter_list),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: _ExampleContent('With Multiple Actions'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showWithSubtitle(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _AppBarExamplePage(
          title: 'With Subtitle',
          description: 'Title with description',
          child: Column(
            children: [
              MPAppBar(
                title: MPText.head('Profile'),
                subtitle: MPText.label('View and edit your profile'),
                trailing: IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: Center(
                  child: _ExampleContent('App Bar with Subtitle'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSearchAppBar(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _AppBarExamplePage(
          title: 'Search App Bar',
          description: 'With search input field',
          child: Column(
            children: [
              MPAppBar(
                title: MPText.head('Search'),
                actions: [
                  IconButton(
                    icon: Icon(Icons.filter_list),
                    onPressed: () {},
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                          Icon(
                            Icons.search,
                            color: context.mp.captionColor,
                            size: 24,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Search...',
                              style: TextStyle(
                                color: context.mp.captionColor,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.mic,
                            color: context.mp.primary,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showProfileAppBar(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _AppBarExamplePage(
          title: 'Profile App Bar',
          description: 'Profile header design',
          child: Column(
            children: [
              MPAppBar(
                title: MPText.head('Profile'),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {},
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {},
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: context.mp.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: context.mp.primary,
                        ),
                      ),
                      SizedBox(height: 24),
                      MPText.head('John Doe', fontSize: 24),
                      SizedBox(height: 8),
                      MPText.label(
                        'john.doe@example.com',
                        style: TextStyle(
                          fontSize: 16,
                          color: context.mp.subtitleColor,
                        ),
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _ProfileButton(label: 'Edit Profile'),
                          SizedBox(width: 16),
                          _ProfileButton(label: 'Share'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showChatAppBar(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _AppBarExamplePage(
          title: 'Chat App Bar',
          description: 'Conversation header design',
          child: Column(
            children: [
              MPAppBar(
                title: MPText.head('Jane Smith'),
                subtitle: MPText.label('2 new messages'),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {},
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.video_call),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.call),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 24),
                      MPText.head('Jane Smith', fontSize: 24),
                      SizedBox(height: 8),
                      MPText.label(
                        'Online now',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _ProfileButton(label: 'Call'),
                          SizedBox(width: 16),
                          _ProfileButton(label: 'Message'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper widgets

class _AppBarExamplePage extends StatelessWidget {
  const _AppBarExamplePage({
    required this.title,
    required this.description,
    required this.child,
    this.backgroundColor,
  });

  final String title;
  final String description;
  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? context.mp.adaptiveBackgroundColor;

    return Scaffold(
      backgroundColor: bgColor,
      body: child,
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: bgColor,
            border: Border(
              top: BorderSide(
                color: context.mp.dividerColor,
                width: 1,
              ),
            ),
          ),
          child: MPButton(
            text: 'Close',
            variant: MPButtonVariant.outlined,
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
    );
  }
}

class _ExampleContent extends StatelessWidget {
  const _ExampleContent(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.check_circle_outline,
          size: 64,
          color: context.mp.primary,
        ),
        SizedBox(height: 24),
        MPText.head(
          text,
          fontSize: 20,
        ),
        SizedBox(height: 8),
        MPText.label(
          'This is an example of app bar variant',
          style: TextStyle(
            color: context.mp.subtitleColor,
          ),
        ),
      ],
    );
  }
}

class _ProfileButton extends StatelessWidget {
  const _ProfileButton({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: context.mp.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () {},
      child: Text(label),
    );
  }
}

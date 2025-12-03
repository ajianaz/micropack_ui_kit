import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

/// Performance demo showcasing all Phase 1 optimizations
class PerformanceDemo extends StatefulWidget {
  const PerformanceDemo({super.key});

  @override
  State<PerformanceDemo> createState() => _PerformanceDemoState();
}

class _PerformanceDemoState extends State<PerformanceDemo> {
  late MPReactiveNotifier<bool> _isLoading;
  late MPReactiveNotifier<double> _progress;
  late MPReactiveNotifier<int> _selectedTab;
  late MPReactiveNotifier<bool> _showSkeleton;

  @override
  void initState() {
    super.initState();
    
    // Enable performance monitoring
    MPPerformanceMonitor.enableMonitoring(true);
    
    // Initialize reactive state
    _isLoading = MPReactiveNotifier(false);
    _progress = MPReactiveNotifier(0.0);
    _selectedTab = MPReactiveNotifier(0);
    _showSkeleton = MPReactiveNotifier(true);
    
    // Simulate loading
    _simulateLoading();
  }

  void _simulateLoading() async {
    // Show skeleton for 2 seconds
    await Future.delayed(const Duration(seconds: 2));
    _showSkeleton.value = false;
    
    // Show loading progress
    _isLoading.value = true;
    for (int i = 0; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 50));
      _progress.value = i / 100.0;
    }
    
    _isLoading.value = false;
    
    // Print performance summary
    Future.delayed(const Duration(seconds: 2), () {
      MPPerformanceMonitor.printSummary();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Performance & Animation Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics),
            onPressed: () {
              MPPerformanceMonitor.printSummary();
            },
          ),
        ],
      ),
      body: MPLoadingOverlay(
        isLoading: _isLoading.value,
        loadingText: 'Loading performance demo...',
        showProgress: true,
        progress: _progress.value,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Performance monitoring
              _buildPerformanceSection(),
              const SizedBox(height: 24),
              
              // Builder pattern cards
              _buildBuilderPatternSection(),
              const SizedBox(height: 24),
              
              // Animated interactions
              _buildAnimatedInteractionsSection(),
              const SizedBox(height: 24),
              
              // Smooth transitions
              _buildTransitionsSection(),
              const SizedBox(height: 24),
              
              // Skeleton loading
              _buildSkeletonSection(),
              const SizedBox(height: 24),
              
              // Progressive image loading
              _buildProgressiveImageSection(),
              const SizedBox(height: 24),
              
              // Reactive builders
              _buildReactiveBuilderSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPerformanceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.headline('Performance Monitoring'),
        const SizedBox(height: 12),
        
        MPPerformanceWrapper(
          child: MPCardBuilder()
              .variant(MPCardVariant.elevated)
              .title('Performance Features')
              .content(Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFeatureItem('✓ Real-time rebuild tracking'),
                  _buildFeatureItem('✓ Render time monitoring'),
                  _buildFeatureItem('✓ Memory usage tracking'),
                  _buildFeatureItem('✓ Performance overlay'),
                  _buildFeatureItem('✓ Optimization suggestions'),
                ],
              ))
              .build(),
        ),
      ],
    );
  }

  Widget _buildBuilderPatternSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.headline('Builder Pattern Cards'),
        const SizedBox(height: 12),
        
        // Conditional rendering with builder pattern
        MPPerformanceWrapper(
          child: MPCardBuilder()
              .variant(MPCardVariant.primary)
              .title('Conditional Builder')
              .content(Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MPText.body('This card uses builder pattern for:'),
                  const SizedBox(height: 8),
                  _buildFeatureItem('✓ Lazy rendering'),
                  _buildFeatureItem('✓ Conditional content'),
                  _buildFeatureItem('✓ Performance optimization'),
                  _buildFeatureItem('✓ Reduced widget rebuilds'),
                ],
              ))
              .onTap(() {
                MPSnackbarAnimatedHelper.info(
                  context,
                  message: 'Builder pattern card tapped!',
                  animationType: MPSnackbarAnimationType.scaleFade,
                );
              })
              .build(),
        ),
        
        const SizedBox(height: 12),
        
        // Complex content with optimization
        MPPerformanceWrapper(
          child: MPCardBuilder()
              .variant(MPCardVariant.interactive)
              .size(MPCardSize.large)
              .title('Optimized Complex Card')
              .content(Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MPText.subhead('Advanced Features:'),
                  const SizedBox(height: 8),
                  _buildFeatureItem('🚀 RepaintBoundary wrapping'),
                  _buildFeatureItem('🚀 Content-based optimization'),
                  _buildFeatureItem('🚀 Smart layout switching'),
                  _buildFeatureItem('🚀 Minimal rebuilds'),
                ],
              ))
              .actions([
                MPButton(
                  text: 'Action 1',
                  onPressed: () {},
                  variant: MPButtonVariant.outlined,
                ),
                MPButton(
                  text: 'Action 2',
                  onPressed: () {},
                  variant: MPButtonVariant.primary,
                ),
              ])
              .build(),
        ),
      ],
    );
  }

  Widget _buildAnimatedInteractionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.headline('Animated Interactions'),
        const SizedBox(height: 12),
        
        // Interactive animated buttons
        Wrap(
          spacing: 12.0,
          children: [
            MPIRichInteractionAnimator(
              normalColor: context.mp.primary,
              hoverColor: context.mp.primaryHover,
              pressedColor: context.mp.primaryPressed,
              hoverScale: 1.05,
              pressScale: 0.95,
              onTap: () {
                MPSnackbarAnimatedHelper.success(
                  context,
                  message: 'Scale and color animation!',
                  animationType: MPSnackbarAnimationType.scaleFade,
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: context.mp.primary,
                ),
                child: const Text(
                  'Animated Button',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            
            MPInteractionAnimator(
              hoverScale: 1.1,
              pressScale: 0.9,
              onTap: () {
                MPSnackbarAnimatedHelper.warning(
                  context,
                  message: 'Scale animation only!',
                  animationType: MPSnackbarAnimationType.slideScale,
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: context.mp.warningColor,
                ),
                child: const Text(
                  'Warning Button',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 12),
        
        // Animated card with rich interactions
        MPPerformanceWrapper(
          child: MPIRichInteractionAnimator(
            normalColor: context.mp.adaptiveBackgroundColor,
            hoverColor: context.mp.neutral10,
            pressedColor: context.mp.neutral20,
            hoverScale: 1.02,
            pressScale: 0.98,
            onTap: () {
              MPSnackbarAnimatedHelper.info(
                context,
                message: 'Card with rich interactions!',
              );
            },
            child: MPCardBuilder()
                .variant(MPCardVariant.elevated)
                .title('Interactive Card')
                .content(const MPText.body(
                  'Hover and press to see smooth animations!'
                ))
                .build(),
          ),
        ),
      ],
    );
  }

  Widget _buildTransitionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.headline('Smooth Transitions'),
        const SizedBox(height: 12),
        
        // Animated tabs
        MPPerformanceWrapper(
          child: MPCardBuilder()
              .variant(MPCardVariant.surface)
              .title('Animated Tabs')
              .content(MPTabBarAnimated(
                tabs: [
                  MPTabRoundedAnimated(
                    title: 'Tab 1',
                    isSelected: _selectedTab.value == 0,
                    onTap: () => _selectedTab.value = 0,
                    enableSlideAnimation: true,
                  ),
                  MPTabRoundedAnimated(
                    title: 'Tab 2',
                    isSelected: _selectedTab.value == 1,
                    onTap: () => _selectedTab.value = 1,
                    enableSlideAnimation: true,
                  ),
                  MPTabRoundedAnimated(
                    title: 'Tab 3',
                    isSelected: _selectedTab.value == 2,
                    onTap: () => _selectedTab.value = 2,
                    enableSlideAnimation: true,
                  ),
                ],
                selectedIndex: _selectedTab.value,
                animationDuration: const Duration(milliseconds: 300),
              ))
              .build(),
        ),
        
        const SizedBox(height: 12),
        
        // Dialog transition demo
        MPButton(
          text: 'Show Animated Dialog',
          onPressed: () {
            MPDialogHelper.show(
              context: context,
              title: const Text('Smooth Dialog Transition'),
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('This dialog uses smooth fade and scale animations.'),
                  SizedBox(height: 16),
                  Text('Try different animation types!'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ],
              animationType: MPDialogAnimationType.fadeScale,
              animationDuration: const Duration(milliseconds: 400),
            );
          },
        ),
        
        const SizedBox(height: 12),
        
        // Snackbar transition demo
        MPButton(
          text: 'Show Animated Snackbar',
          onPressed: () {
            MPSnackbarAnimatedHelper.success(
              context,
              message: 'Snackbar with smooth scale animation!',
              animationType: MPSnackbarAnimationType.scaleFade,
              duration: const Duration(seconds: 3),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSkeletonSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.headline('Skeleton Loading'),
        const SizedBox(height: 12),
        
        MPReactiveBuilder<bool>(
          valueListenable: _showSkeleton,
          builder: (context, showSkeleton, child) {
            if (showSkeleton) {
              return Column(
                children: [
                  // Form skeleton
                  MPPerformanceWrapper(
                    child: MPCardBuilder()
                        .variant(MPCardVariant.surface)
                        .title('Form Skeleton')
                        .content(MPFormSkeleton(
                          fields: MPSkeletonTextFieldConfigs.loginForm(),
                          spacing: 16.0,
                          animationType: MPSkeletonAnimationType.shimmer,
                          animationDuration: const Duration(milliseconds: 1500),
                        ))
                        .build(),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Card skeletons
                  Row(
                    children: [
                      Expanded(
                        child: MPPerformanceWrapper(
                          child: MPCardBuilder()
                              .variant(MPCardVariant.elevated)
                              .content(MPSkeletonVariants.articleCard(context))
                              .build(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: MPPerformanceWrapper(
                          child: MPCardBuilder()
                              .variant(MPCardVariant.elevated)
                              .content(MPSkeletonVariants.articleCard(context))
                              .build(),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  MPButton(
                    text: 'Show Loaded Content',
                    onPressed: () => _showSkeleton.value = false,
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  // Loaded form
                  MPPerformanceWrapper(
                    child: MPCardBuilder()
                        .variant(MPCardVariant.surface)
                        .title('Loaded Form')
                        .content(Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MPTextField(
                              labelText: 'Email',
                              hintText: 'Enter your email',
                              prefixIcon: Icons.email,
                            ),
                            const SizedBox(height: 16),
                            MPTextField(
                              labelText: 'Password',
                              hintText: 'Enter your password',
                              prefixIcon: Icons.lock,
                              isPassword: true,
                            ),
                          ],
                        ))
                        .actions([
                          MPButton(
                            text: 'Login',
                            onPressed: () {},
                            variant: MPButtonVariant.primary,
                          ),
                        ])
                        .build(),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  MPButton(
                    text: 'Show Skeleton Again',
                    onPressed: () => _showSkeleton.value = true,
                  ),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildProgressiveImageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.headline('Progressive Image Loading'),
        const SizedBox(height: 12),
        
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: [
            // Card image
            SizedBox(
              width: 200,
              height: 150,
              child: MPProgressiveImageStyles.card(
                imageUrl: 'https://picsum.photos/200/150',
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            
            // Avatar image
            MPProgressiveImageStyles.avatar(
              imageUrl: 'https://picsum.photos/100/100',
              size: 80,
            ),
            
            // Hero image
            SizedBox(
              width: 300,
              height: 200,
              child: MPProgressiveImageStyles.hero(
                imageUrl: 'https://picsum.photos/300/200',
                thumbnailUrl: 'https://picsum.photos/50/33',
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        MPText.body('Features:'),
        const SizedBox(height: 8),
        _buildFeatureItem('🖼️ Thumbnail preview loading'),
        _buildFeatureItem('🖼️ Smooth fade-in animations'),
        _buildFeatureItem('🖼️ Error handling with retry'),
        _buildFeatureItem('🖼️ Progress indicators'),
        _buildFeatureItem('🖼️ Optimized caching'),
      ],
    );
  }

  Widget _buildReactiveBuilderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.headline('Reactive State Management'),
        const SizedBox(height: 12),
        
        MPPerformanceWrapper(
          child: MPCardBuilder()
              .variant(MPCardVariant.surface)
              .title('Reactive Counter')
              .content(Column(
                children: [
                  MPReactiveBuilder<int>(
                    valueListenable: MPReactiveNotifier(0),
                    initializeWith: 0,
                    builder: (context, count, child) {
                      return Column(
                        children: [
                          MPText.headline('Count: $count'),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              MPButton(
                                text: '-',
                                onPressed: () {
                                  // Update would happen through the notifier
                                },
                                variant: MPButtonVariant.outlined,
                              ),
                              const SizedBox(width: 12),
                              MPButton(
                                text: '+',
                                onPressed: () {
                                  // Update would happen through the notifier
                                },
                                variant: MPButtonVariant.primary,
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  const MPText.body(
                    'Reactive builders provide efficient state updates\n'
                    'with minimal widget rebuilds and automatic disposal.'
                  ),
                ],
              ))
              .build(),
        ),
      ],
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: MPText.small(text),
    );
  }
}

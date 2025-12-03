# Responsive Design Checklist

## Breakpoint System
- [ ] Unified breakpoint definitions (mobile < 600, tablet 600-1024, desktop > 1024)
- [ ] Consistent breakpoint usage across all components
- [ ] Orientation-specific layouts implemented
- [ ] Adaptive layouts for ultra-wide screens
- [ ] Small mobile optimization (< 360px)
- [ ] Large desktop optimization (> 1920px)

## Layout Adaptation
- [ ] LayoutBuilder used for responsive layouts
- [ ] Flex/Expanded widgets for flexible layouts
- [ ] MediaQuery usage optimized and cached
- [ ] Responsive padding and margins
- [ ] Adaptive grid systems
- [ ] Responsive constraints (min/max sizes)

## Typography Scaling
- [ ] Responsive font sizes using breakpoints
- [ ] Line height adaptation for readability
- [ ] Letter spacing adjustments for different sizes
- [ ] Text scaling support for accessibility
- [ ] Responsive heading hierarchy
- [ ] Text overflow handling

## Component Adaptation
- [ ] Touch targets sized appropriately for mobile
- [ ] Dense layouts for desktop when needed
- [ ] Horizontal/vertical layout switching
- [ ] Component variants for different screen sizes
- [ ] Responsive image sizing and loading
- [ ] Adaptive interaction patterns

## Performance Considerations
- [ ] Optimized rebuilds for responsive changes
- [ ] Cached responsive calculations
- [ ] Efficient responsive state management
- [ ] Lazy loading for large responsive lists
- [ ] Optimized image loading for different sizes
- [ ] Memory management for responsive widgets

## Testing Requirements
- [ ] Test on all defined breakpoints
- [ ] Test portrait and landscape orientations
- [ ] Test on actual devices (not just simulators)
- [ ] Test with different pixel densities
- [ ] Test responsive animations and transitions
- [ ] Test performance on low-end devices

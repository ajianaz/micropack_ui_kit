import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class SliderDemoPage extends StatefulWidget {
  const SliderDemoPage({super.key});

  @override
  State<SliderDemoPage> createState() => _SliderDemoPageState();
}

class _SliderDemoPageState extends State<SliderDemoPage> {
  // Variant sliders
  double _primaryValue = 0.5;
  double _secondaryValue = 0.3;
  double _successValue = 0.7;
  double _warningValue = 0.4;
  double _errorValue = 0.6;
  double _infoValue = 0.8;

  // Discrete sliders
  double _discrete5 = 2.0;
  double _discrete10 = 5.0;
  double _discrete20 = 10.0;

  // Custom range sliders
  double _volumeValue = 0.7;
  double _brightnessValue = 0.5;
  double _priceValue = 500.0;
  double _ratingValue = 3.5;

  // State sliders
  double _enabledValue = 0.6;
  double _disabledValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: MPText.head(
          'Slider Demo',
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
            _buildDiscreteSliders(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildStates(context),
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
          'Slider Variants',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _sliderCard(
          title: 'Primary',
          description: 'Primary brand color slider',
          value: _primaryValue,
          child: MPSlider(
            value: _primaryValue,
            variant: MPSliderVariant.primary,
            onChanged: (value) => setState(() => _primaryValue = value),
          ),
        ),
        SizedBox(height: 16),
        _sliderCard(
          title: 'Secondary',
          description: 'Secondary color slider',
          value: _secondaryValue,
          child: MPSlider(
            value: _secondaryValue,
            variant: MPSliderVariant.secondary,
            onChanged: (value) => setState(() => _secondaryValue = value),
          ),
        ),
        SizedBox(height: 16),
        _sliderCard(
          title: 'Success',
          description: 'Success color slider',
          value: _successValue,
          child: MPSlider(
            value: _successValue,
            variant: MPSliderVariant.success,
            onChanged: (value) => setState(() => _successValue = value),
          ),
        ),
        SizedBox(height: 16),
        _sliderCard(
          title: 'Warning',
          description: 'Warning color slider',
          value: _warningValue,
          child: MPSlider(
            value: _warningValue,
            variant: MPSliderVariant.warning,
            onChanged: (value) => setState(() => _warningValue = value),
          ),
        ),
        SizedBox(height: 16),
        _sliderCard(
          title: 'Error',
          description: 'Error color slider',
          value: _errorValue,
          child: MPSlider(
            value: _errorValue,
            variant: MPSliderVariant.error,
            onChanged: (value) => setState(() => _errorValue = value),
          ),
        ),
        SizedBox(height: 16),
        _sliderCard(
          title: 'Info',
          description: 'Info color slider',
          value: _infoValue,
          child: MPSlider(
            value: _infoValue,
            variant: MPSliderVariant.info,
            onChanged: (value) => setState(() => _infoValue = value),
          ),
        ),
      ],
    );
  }

  Widget _buildDiscreteSliders(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Discrete Sliders',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _sliderCard(
          title: '5 Divisions',
          description: 'Slider with 5 discrete steps',
          value: _discrete5,
          child: MPSlider(
            value: _discrete5,
            divisions: 5,
            label: '${_discrete5.toInt()}',
            onChanged: (value) => setState(() => _discrete5 = value),
          ),
        ),
        SizedBox(height: 16),
        _sliderCard(
          title: '10 Divisions',
          description: 'Slider with 10 discrete steps',
          value: _discrete10,
          child: MPSlider(
            value: _discrete10,
            divisions: 10,
            label: '${_discrete10.toInt()}',
            onChanged: (value) => setState(() => _discrete10 = value),
          ),
        ),
        SizedBox(height: 16),
        _sliderCard(
          title: '20 Divisions',
          description: 'Slider with 20 discrete steps',
          value: _discrete20,
          child: MPSlider(
            value: _discrete20,
            divisions: 20,
            label: '${_discrete20.toInt()}',
            onChanged: (value) => setState(() => _discrete20 = value),
          ),
        ),
      ],
    );
  }

  Widget _buildStates(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head(
          'Slider States',
          fontSize: 20,
        ),
        SizedBox(height: MPResponsivePadding.getMd(context)),
        _sliderCard(
          title: 'Enabled',
          description: 'Active and interactive slider',
          value: _enabledValue,
          child: MPSlider(
            value: _enabledValue,
            onChanged: (value) => setState(() => _enabledValue = value),
          ),
        ),
        SizedBox(height: 16),
        _sliderCard(
          title: 'Disabled',
          description: 'Non-interactive slider',
          value: _disabledValue,
          child: MPSlider(
            value: _disabledValue,
            enabled: false,
            onChanged: (value) {},
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
        _exampleCard(
          title: 'Volume Control',
          description: 'Audio volume adjustment',
          icon: Icons.volume_up,
          value: _volumeValue,
          suffix: 'Volume',
          variant: MPSliderVariant.primary,
          onChanged: (value) => setState(() => _volumeValue = value),
        ),
        SizedBox(height: 16),
        _exampleCard(
          title: 'Brightness Control',
          description: 'Screen brightness adjustment',
          icon: Icons.brightness_6,
          value: _brightnessValue,
          suffix: 'Brightness',
          variant: MPSliderVariant.info,
          onChanged: (value) => setState(() => _brightnessValue = value),
        ),
        SizedBox(height: 16),
        _exampleCard(
          title: 'Price Range',
          description: 'Price filter with custom range (\$0-\$1000)',
          icon: Icons.attach_money,
          value: _priceValue,
          min: 0,
          max: 1000,
          divisions: 20,
          suffix: '\$${_priceValue.toInt()}',
          variant: MPSliderVariant.success,
          onChanged: (value) => setState(() => _priceValue = value),
        ),
        SizedBox(height: 16),
        _exampleCard(
          title: 'Rating Scale',
          description: '5-star rating slider',
          icon: Icons.star,
          value: _ratingValue,
          min: 1,
          max: 5,
          divisions: 8,
          suffix: '${_ratingValue.toStringAsFixed(1)} ★',
          variant: MPSliderVariant.warning,
          onChanged: (value) => setState(() => _ratingValue = value),
        ),
      ],
    );
  }

  Widget _sliderCard({
    required String title,
    required String description,
    required double value,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MPText.head(
                title,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              MPText.label(
                '${(value * 100).toInt()}%',
                style: TextStyle(
                  color: context.mp.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
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

  Widget _exampleCard({
    required String title,
    required String description,
    required IconData icon,
    required double value,
    double min = 0.0,
    double max = 1.0,
    int? divisions,
    required String suffix,
    MPSliderVariant variant = MPSliderVariant.primary,
    required ValueChanged<double> onChanged,
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: context.mp.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: context.mp.primary, size: 20),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MPText.head(title, fontSize: 16),
                    SizedBox(height: 2),
                    MPText.label(
                      description,
                      style: TextStyle(
                        fontSize: 12,
                        color: context.mp.subtitleColor,
                      ),
                    ),
                  ],
                ),
              ),
              MPText.head(
                suffix,
                fontSize: 14,
                style: TextStyle(color: context.mp.primary),
              ),
            ],
          ),
          SizedBox(height: 16),
          MPSlider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            variant: variant,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';
import 'package:micropack_ui_kit/src/core/styles/mp_text_field_border.dart';

/// MPTextField - Theme-aware text field component
///
/// This component has been updated to use the new theme system with context.mp
/// for consistent theming across light and dark modes.
///
/// Theme Implementation:
/// - Background: uses context.mp.adaptiveBackgroundColor
/// - Cursor color: uses context.mp.primary
/// - Icon colors: uses context.mp.neutral80 for consistent visibility
/// - Clear button icon: uses context.mp.neutral80
/// - Loading indicator: uses context.mp.primary
/// - Image placeholder: uses context.mp.neutral30 and context.mp.captionColor
///
/// State Colors:
/// - Enabled: uses context.mp.textColor
/// - Disabled: uses context.mp.disabledColor
/// - Hint text: uses context.mp.neutral60
/// - Label text: uses context.mp.textColor
/// - Helper text: uses context.mp.subtitleColor
/// - Error text: uses context.mp.errorColor
/// - Counter text: uses context.mp.captionColor
///
/// Border Colors:
/// - Default border: uses context.mp.adaptiveBorderColor
/// - Focus border: uses context.mp.primaryFocus
/// - Error border: uses context.mp.errorColor
///
/// All variants (DEFAULT, PASSWORD, BORDER, BORDER_PASSWORD) now use the theme system correctly.

enum MPTextFieldType { DEFAULT, PASSWORD, BORDER, BORDER_PASSWORD }

/// Input formatter for common patterns
class MPInputFormatters {
  /// Phone number formatter (XXX-XXX-XXXX)
  static final TextInputFormatter phoneNumber = TextInputFormatter.withFunction(
    (oldValue, newValue) {
      final text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
      if (text.length > 10) return oldValue;

      String formatted = '';
      for (int i = 0; i < text.length; i++) {
        if (i == 3 || i == 6) formatted += '-';
        formatted += text[i];
      }

      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    },
  );

  /// Credit card formatter (XXXX-XXXX-XXXX-XXXX)
  static final TextInputFormatter creditCard = TextInputFormatter.withFunction(
    (oldValue, newValue) {
      final text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
      if (text.length > 16) return oldValue;

      String formatted = '';
      for (int i = 0; i < text.length; i++) {
        if (i > 0 && i % 4 == 0) formatted += '-';
        formatted += text[i];
      }

      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    },
  );

  /// Currency formatter
  static final TextInputFormatter currency = TextInputFormatter.withFunction(
    (oldValue, newValue) {
      final text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
      if (text.isEmpty) return const TextEditingValue(text: '');

      final number = int.tryParse(text) ?? 0;
      final formatted = '\$${number.toString().replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]},',
          )}';

      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    },
  );
}

/// Common validators for text fields
class MPValidators {
  /// Required field validator
  static String? required(String? value, [String? message]) {
    if (value == null || value.trim().isEmpty) {
      return message ?? 'This field is required';
    }
    return null;
  }

  /// Email validator
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// Phone number validator
  static String? phoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    final digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.length != 10) {
      return 'Phone number must be 10 digits';
    }
    return null;
  }

  /// Password validator
  static String? password(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
      return 'Password must contain at least one number';
    }
    return null;
  }

  /// Minimum length validator
  static String? minLength(int length, String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    if (value.length < length) {
      return 'Must be at least $length characters';
    }
    return null;
  }

  /// Maximum length validator
  static String? maxLength(int length, String? value) {
    if (value != null && value.length > length) {
      return 'Must be no more than $length characters';
    }
    return null;
  }

  /// Number range validator
  static String? numberRange(int min, int max, String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    final number = int.tryParse(value);
    if (number == null) {
      return 'Please enter a valid number';
    }
    if (number < min || number > max) {
      return 'Must be between $min and $max';
    }
    return null;
  }
}

class MPTextField extends StatefulWidget {
  /// Tipe yang tersedia pada Widget MPTextField
  MPTextFieldType? type;

  /// Controller
  final TextEditingController controller;

  /// Mengatur tampilan keyboard
  final TextInputType? keyboardType;

  /// Mengatur bentuk aksi 'enter' di keyboard
  final TextInputAction? textInputAction;

  /// Mengatur gaya teks
  final MPTextStyle? textStyle;

  /// Mengatur [MPTextField] dapat diedit atau tidak.
  /// Secara default bernilai `false`
  final bool readOnly;

  /// Mengatur [MPTextField] dapat diedit atau tidak.
  /// Berbeda dengan [readOnly], ketika [enabled] bernilai `true`
  /// maka [MPTextField] akan memasuki mode disabled
  final bool? enabled;

  /// Mengatur tampilan teks, akan disembunyikan dan diganti `*` atau tidak
  /// Secara default bernilai `false`
  bool obscureText;

  /// Mengatur warna cursor
  final Color? cursorColor;

  /// Menangani aksi ketika sudah selesai mengedit
  final void Function()? onEditingComplete;

  /// Menangani aksi ketika sudah selesai mengetik dan menekan `enter`
  final void Function(String)? onFieldSubmitted;

  /// Menangani aksi setiap ada perubahan pengetikan
  final void Function(String)? onChange;

  /// Menangani aksi validasi
  final String? Function(String?)? validator;

  /// Menangani aksi validasi akan dilakukan kapan
  final AutovalidateMode? autoValidateMode;

  /// Semantic label for accessibility
  final String? semanticLabel;

  /// Menangani aksi ketika [MPTextField] di-Tap
  final void Function()? onTap;

  ///
  final FocusNode? focusNode;

  ///
  final TextCapitalization textCapitalization;

  /// Memberikan hint
  final String? hint;

  /// Mengatur gaya dari [hint]
  final MPTextStyle? hintStyle;

  /// Memberikan label. Jika [hint] dan [label] diisi, maka [hint] akan diabaikan
  /// dan [label] yang akan ditampilkan
  final String? label;

  /// Mengatur gaya dari [label]
  final MPTextStyle? labelStyle;

  /// Mengatur Widget kustom untuk label. Jika [labelCustom] diisi maka [label],
  /// [labelStyle] dan [floatingLabelStyle] akan diabaikan
  final Widget? labelCustom;

  /// Mengatur perataan dari [label] yang mengambang
  final FloatingLabelAlignment? floatingLabelAlignment;

  /// Mengatur kemunculan [label] mengambang
  final FloatingLabelBehavior? floatingLabelBehavior;

  /// Mengatur gaya dari [label] mengambang
  final MPTextStyle? floatingLabelStyle;

  /// Mengatur ikon
  final Widget? icon;

  /// Mengatur warna dari ikon
  final Color? iconColor;

  /// Mengatur ikon pada awalan [MPTextField]
  final Widget? prefixIcon;

  /// Mengatur warna [prefixIcon]
  final Color? prefixIconColor;

  /// Mengatur teks pada awalan [MPTextField]. Terletak antara [prefixIcon]
  /// dan tempat untuk mengetik. [prefixText] akan muncul jika [prefix] bernilai
  /// null dan [MPTextField] dalam status fokus
  final String? prefixText;

  /// Mengatur gaya dari [prefixText]
  final MPTextStyle? prefixTextStyle;

  /// Mengatur Widget pada awalan [MPTextField]. Terletak antara [prefixIcon]
  /// dan tempat untuk mengetik. [prefix] akan muncul jika [prefixText] bernilai
  /// null dan [MPTextField] dalam status fokus
  final Widget? prefix;

  /// Mengatur ikon pada akhiran [MPTextField]
  /// Jika [type] = [MPTextFieldType.PASSWORD] atau [MPTextFieldType.BORDER_PASSWORD]
  /// maka [suffixIcon] akan diabaikan
  Widget? suffixIcon;

  /// Mengatur [suffixIcon] jika [type] = [MPTextFieldType.PASSWORD] atau [MPTextFieldType.BORDER_PASSWORD]
  /// dan [obscureText] = false.
  Widget? suffixIconEyeOpen;

  /// Mengatur [suffixIcon] jika [type] = [MPTextFieldType.PASSWORD] atau [MPTextFieldType.BORDER_PASSWORD]
  /// dan [obscureText] = true
  Widget? suffixIconEyeClose;

  /// Mengatur warna dari [suffixIcon]
  final Color? suffixIconColor;

  /// Mengatur teks pada akhiran [MPTextField]. Terletak antara [suffixIcon]
  /// dan tempat untuk mengetik. [suffixText] akan muncul jika [suffix] bernilai
  /// null dan [MPTextField] dalam status fokus
  final String? suffixText;

  /// Mengatur gaya dari [suffixText]
  final MPTextStyle? suffixTextStyle;

  /// Mengatur Widget pada awalan [MPTextField]. Terletak antara [suffixIcon]
  /// dan tempat untuk mengetik. [suffix] akan muncul jika [suffixText] bernilai
  /// null dan [MPTextField] dalam status fokus
  final Widget? suffix;

  /// Mengatur garis batas / border pada [MPTextField]
  MPTextFieldBorder? border;

  /// Mengatur teks counter. Terletak pada kanan bawah [MPTextField]
  final String? counterText;

  /// Mengatur gaya teks [counterText]
  final MPTextStyle? counterStyle;

  /// mengatur teks helper. Terletak pada kiri bawah [MPTextField]
  final String? helperText;

  /// Mengatur gaya teks [helperText]
  final MPTextStyle? helperStyle;

  /// Mengatur teks error. Terletak pada kiri bawah [MPTextField].
  /// Jika [helperText] tidak bernilai null akan terganti dengan [errorText]
  final String? errorText;

  /// Mengatur gaya teks [errorText]
  final MPTextStyle? errorStyle;

  /// Mengatur warna dari [MPTextField].
  /// Akan diabaikan jika [filled] bernilai null atau false
  final Color? fillColor;

  /// Mengatur [MPTextField] berwarna atau tidak
  final bool? filled;

  /// Mengatur padding
  final EdgeInsetsGeometry? padding;

  /// Mengatur ukuran dari [MPTextField]
  final BoxConstraints? constraints;

  /// Input Formatter
  final List<TextInputFormatter>? inputFormatter;

  /// Character limit for the field
  final int? maxLength;

  /// Show character counter
  final bool showCounter;

  /// Show clear button when field is not empty
  final bool showClearButton;

  /// Clear button icon
  final Widget? clearButtonIcon;

  /// Callback when clear button is pressed
  final VoidCallback? onClear;

  /// Auto focus when field is built
  final bool autofocus;

  /// Text alignment
  final TextAlign textAlign;

  /// Enable suggestions
  final bool enableSuggestions;

  /// Enable autocorrect
  final bool autocorrect;

  /// Enable interactive selection
  final bool enableInteractiveSelection;

  /// Scroll padding for keyboard
  final EdgeInsets? scrollPadding;

  /// Text direction
  final TextDirection? textDirection;

  /// Creates a default MPTextField
  MPTextField(
    this.controller, {
    super.key,
    this.keyboardType,
    this.textInputAction,
    this.textStyle,
    this.readOnly = false,
    this.obscureText = false,
    this.cursorColor,
    this.onEditingComplete,
    this.onChange,
    this.onFieldSubmitted,
    this.onTap,
    this.validator,
    this.autoValidateMode,
    this.semanticLabel,
    this.enabled,
    this.focusNode,
    this.textCapitalization = TextCapitalization.none,
    this.hint,
    this.hintStyle,
    this.label,
    this.labelStyle,
    this.labelCustom,
    this.floatingLabelAlignment,
    this.floatingLabelBehavior,
    this.floatingLabelStyle,
    this.icon,
    this.iconColor,
    this.prefixIcon,
    this.prefixIconColor,
    this.prefixText,
    this.prefixTextStyle,
    this.prefix,
    this.suffixIcon,
    this.suffixIconColor,
    this.suffixText,
    this.suffixTextStyle,
    this.suffix,
    this.border,
    this.counterText,
    this.counterStyle,
    this.helperText,
    this.helperStyle,
    this.errorText,
    this.errorStyle,
    this.filled,
    this.fillColor,
    this.padding,
    this.constraints,
    this.inputFormatter,
    this.maxLength,
    this.showCounter = false,
    this.showClearButton = false,
    this.clearButtonIcon,
    this.onClear,
    this.autofocus = false,
    this.textAlign = TextAlign.start,
    this.enableSuggestions = true,
    this.autocorrect = true,
    this.enableInteractiveSelection = true,
    this.scrollPadding,
    this.textDirection,
  }) {
    type = MPTextFieldType.DEFAULT;
  }

  /// Creates a password MPTextField
  MPTextField.password(
    this.controller, {
    super.key,
    this.keyboardType,
    this.textInputAction,
    this.textStyle,
    this.readOnly = false,
    this.obscureText = true,
    this.cursorColor,
    this.onEditingComplete,
    this.onChange,
    this.onFieldSubmitted,
    this.onTap,
    this.validator,
    this.autoValidateMode,
    this.semanticLabel,
    this.enabled,
    this.focusNode,
    this.textCapitalization = TextCapitalization.none,
    this.hint,
    this.hintStyle,
    this.label,
    this.labelStyle,
    this.labelCustom,
    this.floatingLabelAlignment,
    this.floatingLabelBehavior,
    this.floatingLabelStyle,
    this.icon,
    this.iconColor,
    this.prefixIcon,
    this.prefixIconColor,
    this.prefixText,
    this.prefixTextStyle,
    this.prefix,
    this.suffixIconEyeOpen,
    this.suffixIconEyeClose,
    this.suffixIconColor,
    this.suffixText,
    this.suffixTextStyle,
    this.suffix,
    this.border,
    this.counterText,
    this.counterStyle,
    this.helperText,
    this.helperStyle,
    this.errorText,
    this.errorStyle,
    this.filled,
    this.fillColor,
    this.padding,
    this.constraints,
    this.inputFormatter,
    this.maxLength,
    this.showCounter = false,
    this.showClearButton = false,
    this.clearButtonIcon,
    this.onClear,
    this.autofocus = false,
    this.textAlign = TextAlign.start,
    this.enableSuggestions = true,
    this.autocorrect = true,
    this.enableInteractiveSelection = true,
    this.scrollPadding,
    this.textDirection,
  }) {
    type = MPTextFieldType.PASSWORD;
  }

  /// Creates a bordered MPTextField
  MPTextField.border(
    this.controller, {
    super.key,
    this.keyboardType,
    this.textInputAction,
    this.textStyle,
    this.readOnly = false,
    this.obscureText = false,
    this.cursorColor,
    this.onEditingComplete,
    this.onChange,
    this.onFieldSubmitted,
    this.onTap,
    this.validator,
    this.autoValidateMode,
    this.semanticLabel,
    this.enabled,
    this.focusNode,
    this.textCapitalization = TextCapitalization.none,
    this.hint,
    this.hintStyle,
    this.label,
    this.labelStyle,
    this.labelCustom,
    this.floatingLabelAlignment,
    this.floatingLabelBehavior,
    this.floatingLabelStyle,
    this.icon,
    this.iconColor,
    this.prefixIcon,
    this.prefixIconColor,
    this.prefixText,
    this.prefixTextStyle,
    this.prefix,
    this.suffixIcon,
    this.suffixIconColor,
    this.suffixText,
    this.suffixTextStyle,
    this.suffix,
    this.border,
    this.counterText,
    this.counterStyle,
    this.helperText,
    this.helperStyle,
    this.errorText,
    this.errorStyle,
    this.filled,
    this.fillColor,
    this.padding,
    this.constraints,
    this.inputFormatter,
    this.maxLength,
    this.showCounter = false,
    this.showClearButton = false,
    this.clearButtonIcon,
    this.onClear,
    this.autofocus = false,
    this.textAlign = TextAlign.start,
    this.enableSuggestions = true,
    this.autocorrect = true,
    this.enableInteractiveSelection = true,
    this.scrollPadding,
    this.textDirection,
  }) {
    type = MPTextFieldType.BORDER;
    // Note: border will be set in build method using theme-aware colors
  }

  /// Creates a bordered password MPTextField
  MPTextField.borderPassword(
    this.controller, {
    super.key,
    this.keyboardType,
    this.textInputAction,
    this.textStyle,
    this.readOnly = false,
    this.obscureText = true,
    this.cursorColor,
    this.onEditingComplete,
    this.onChange,
    this.onFieldSubmitted,
    this.onTap,
    this.validator,
    this.autoValidateMode,
    this.semanticLabel,
    this.enabled,
    this.focusNode,
    this.textCapitalization = TextCapitalization.none,
    this.hint,
    this.hintStyle,
    this.label,
    this.labelStyle,
    this.labelCustom,
    this.floatingLabelAlignment,
    this.floatingLabelBehavior,
    this.floatingLabelStyle,
    this.icon,
    this.iconColor,
    this.prefixIcon,
    this.prefixIconColor,
    this.prefixText,
    this.prefixTextStyle,
    this.prefix,
    this.suffixIconEyeOpen,
    this.suffixIconEyeClose,
    this.suffixIconColor,
    this.suffixText,
    this.suffixTextStyle,
    this.suffix,
    this.border,
    this.counterText,
    this.counterStyle,
    this.helperText,
    this.helperStyle,
    this.errorText,
    this.errorStyle,
    this.filled,
    this.fillColor,
    this.padding,
    this.constraints,
    this.inputFormatter,
    this.maxLength,
    this.showCounter = false,
    this.showClearButton = false,
    this.clearButtonIcon,
    this.onClear,
    this.autofocus = false,
    this.textAlign = TextAlign.start,
    this.enableSuggestions = true,
    this.autocorrect = true,
    this.enableInteractiveSelection = true,
    this.scrollPadding,
    this.textDirection,
  }) {
    type = MPTextFieldType.BORDER_PASSWORD;
    // Note: border will be set in build method using theme-aware colors
  }

  @override
  State<MPTextField> createState() => _MPTextFieldState();
}

class _MPTextFieldState extends State<MPTextField> {
  final Widget _defaultSuffixIconEyeOpen = const Icon(FontAwesomeIcons.eye);
  final Widget _defaultSuffixIconEyeClose =
      const Icon(FontAwesomeIcons.eyeSlash);
  bool _isLandscape = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateOrientation();
  }

  void _updateOrientation() {
    final newOrientation = MediaQuery.of(context).orientation;
    final newIsLandscape = newOrientation == Orientation.landscape;

    if (_isLandscape != newIsLandscape) {
      setState(() {
        _isLandscape = newIsLandscape;
      });
    }
  }

  void _togglePasswordView() {
    setState(() {
      widget.obscureText = !widget.obscureText;
      settingSuffixIcon();
    });
  }

  @override
  Widget build(BuildContext context) {
    settingSuffixIcon();

    // Build combined input formatters
    final List<TextInputFormatter> formatters = [];

    // Add maxLength formatter if specified
    if (widget.maxLength != null) {
      formatters.add(LengthLimitingTextInputFormatter(widget.maxLength));
    }

    // Add custom formatters
    if (widget.inputFormatter != null) {
      formatters.addAll(widget.inputFormatter!);
    }

    // Build suffix icon with clear button
    Widget? finalSuffixIcon = _buildSuffixIcon();

    // Get theme-aware colors for consistent theming across light and dark modes
    final themeColors = context.mp;

    // Get orientation-aware padding
    final orientationAwarePadding = _getOrientationAwarePadding();

    // Wrap with Semantics widget if semanticLabel is provided
    Widget textField = TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        // Hint text with theme-aware subtitle color for better visibility
        hintText: widget.hint,
        hintStyle:
            (widget.hintStyle?.toTextStyle(context) ?? TextStyle()).copyWith(
          color: widget.hintStyle?.color ?? themeColors.subtitleColor,
        ),
        hintMaxLines: widget.hintStyle?.maxLines,

        // Label text with theme-aware text color for consistency
        labelText: widget.label,
        labelStyle:
            (widget.labelStyle?.toTextStyle(context) ?? TextStyle()).copyWith(
          color: widget.labelStyle?.color ?? themeColors.textColor,
        ),
        label: widget.labelCustom,
        floatingLabelAlignment: widget.floatingLabelAlignment,
        floatingLabelBehavior: widget.floatingLabelBehavior,
        floatingLabelStyle:
            (widget.floatingLabelStyle?.toTextStyle(context) ?? TextStyle())
                .copyWith(
          color: widget.floatingLabelStyle?.color ?? themeColors.textColor,
        ),

        // Icon with theme-aware primary color for visual hierarchy
        icon: widget.icon,
        iconColor: widget.iconColor ?? themeColors.primary,

        // Prefix icon with theme-aware neutral80 color for consistency
        prefixIcon: widget.prefixIcon,
        prefixIconColor: widget.prefixIconColor ?? themeColors.neutral80,
        prefix: widget.prefix,
        prefixText: widget.prefixText,
        prefixStyle:
            (widget.prefixTextStyle?.toTextStyle(context) ?? TextStyle())
                .copyWith(
          color: widget.prefixTextStyle?.color ?? themeColors.subtitleColor,
        ),

        // Suffix elements with theme-aware colors
        suffixIcon: finalSuffixIcon,
        suffixIconColor: widget.suffixIconColor ?? themeColors.neutral80,
        suffix: widget.suffix,
        suffixText: widget.suffixText,
        suffixStyle:
            (widget.suffixTextStyle?.toTextStyle(context) ?? TextStyle())
                .copyWith(
          color: widget.suffixTextStyle?.color ?? themeColors.subtitleColor,
        ),

        // Counter text with theme-aware caption color for subtle appearance
        counterText:
            widget.showCounter ? _buildCounterText() : widget.counterText,
        counterStyle:
            (widget.counterStyle?.toTextStyle(context) ?? TextStyle()).copyWith(
          color: widget.counterStyle?.color ?? themeColors.captionColor,
        ),

        // Helper text with theme-aware subtitle color
        helperText: widget.helperText,
        helperStyle:
            (widget.helperStyle?.toTextStyle(context) ?? TextStyle()).copyWith(
          color: widget.helperStyle?.color ?? themeColors.subtitleColor,
        ),

        // Error text with theme-aware error color for clear indication
        errorText: widget.errorText,
        errorStyle:
            (widget.errorStyle?.toTextStyle(context) ?? TextStyle()).copyWith(
          color: widget.errorStyle?.color ?? themeColors.errorColor,
        ),

        // Fill color using cardColor for proper dark mode contrast and visual separation
        // In dark mode: uses neutral80 (medium-dark) for contrast against neutral90 background
        // In light mode: uses neutral10 (white)
        fillColor: widget.fillColor ?? themeColors.cardColor,
        filled: widget.filled ?? true,
        border: widget.border?.border?.toBorder() ??
            _getThemeAwareBorder(themeColors, 'default'),
        enabledBorder: widget.border?.enableBorder?.toBorder() ??
            _getThemeAwareBorder(themeColors, 'enabled'),
        errorBorder: widget.border?.errorBorder?.toBorder() ??
            _getThemeAwareBorder(themeColors, 'error'),
        focusedErrorBorder: widget.border?.focusedErrorBorder?.toBorder() ??
            _getThemeAwareBorder(themeColors, 'focusedError'),
        focusedBorder: widget.border?.focusedBorder?.toBorder() ??
            _getThemeAwareBorder(themeColors, 'focused'),
        disabledBorder: widget.border?.disableBorder?.toBorder() ??
            _getThemeAwareBorder(themeColors, 'disabled'),
        contentPadding: widget.padding ?? orientationAwarePadding,
        constraints: widget.constraints ?? _getOrientationAwareConstraints(),
        focusColor: Colors.transparent,
      ),
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      // Text style with theme-aware text color for readability
      // Always use theme-aware color unless explicitly overridden
      style: (widget.textStyle?.toTextStyle(context) ??
              MpUiKit.textStyle.toTextStyle(context))
          .copyWith(
        color: widget.textStyle?.color ?? themeColors.textColor,
        fontSize: _getOrientationAwareFontSize(),
      ),
      textAlign: widget.textAlign,
      readOnly: widget.readOnly,
      obscureText: widget.obscureText,
      maxLines: _getOrientationAwareMaxLines(),
      minLines: _getOrientationAwareMinLines(),
      // Theme-aware cursor color using primary color for visibility
      cursorColor: widget.cursorColor ?? themeColors.primary,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      validator: widget.validator,
      autovalidateMode: widget.autoValidateMode,
      enabled: widget.enabled,
      focusNode: widget.focusNode,
      onTap: widget.onTap,
      onChanged: widget.onChange,
      textCapitalization: widget.textCapitalization,
      inputFormatters: formatters,
      autofocus: widget.autofocus,
      enableSuggestions: widget.enableSuggestions,
      autocorrect: widget.autocorrect,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      scrollPadding: widget.scrollPadding ?? const EdgeInsets.all(20),
      textDirection: widget.textDirection,
    );

    // Add semantic label if provided
    if (widget.semanticLabel != null) {
      textField = Semantics(
        label: widget.semanticLabel,
        child: textField,
      );
    }

    return textField;
  }

  /// Build suffix icon with clear button and password toggle
  Widget? _buildSuffixIcon() {
    final List<Widget> icons = [];
    final themeColors = context.mp;

    // Add clear button if enabled and field is not empty
    // Uses theme-aware subtitle color for subtle appearance
    if (widget.showClearButton && widget.controller.text.isNotEmpty) {
      icons.add(
        GestureDetector(
          onTap: () {
            widget.controller.clear();
            widget.onClear?.call();
            widget.onChange?.call('');
          },
          child: widget.clearButtonIcon ??
              Icon(
                Icons.clear,
                // Theme-aware clear button color using subtitle color
                color: widget.suffixIconColor ?? themeColors.subtitleColor,
                size: 20,
              ),
        ),
      );
    }

    // Add password toggle or custom suffix icon
    if (widget.type == MPTextFieldType.DEFAULT) {
      if (widget.suffixIcon != null) {
        icons.add(widget.suffixIcon!);
      }
    } else {
      // Password field - add toggle icon
      // Default icons will use theme-aware colors through InputDecoration
      icons.add(
        GestureDetector(
          onTap: _togglePasswordView,
          child: widget.suffixIcon ??
              (widget.obscureText
                  ? _defaultSuffixIconEyeClose
                  : _defaultSuffixIconEyeOpen),
        ),
      );
    }

    if (icons.isEmpty) return null;
    if (icons.length == 1) return icons.first;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        icons.length,
        (index) => Padding(
          padding: EdgeInsets.only(left: index > 0 ? 8 : 0),
          child: icons[index],
        ),
      ),
    );
  }

  /// Get orientation-aware padding
  EdgeInsets _getOrientationAwarePadding() {
    if (_isLandscape) {
      // More compact padding in landscape mode
      return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
    }
    return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
  }

  /// Get orientation-aware constraints
  BoxConstraints _getOrientationAwareConstraints() {
    if (_isLandscape) {
      // Reduce height in landscape mode
      return const BoxConstraints(minHeight: 40);
    }
    return const BoxConstraints(minHeight: 48);
  }

  /// Get orientation-aware font size
  double _getOrientationAwareFontSize() {
    final baseFontSize =
        widget.textStyle?.fontSize ?? MpUiKit.textStyle?.fontSize ?? 16;
    if (_isLandscape) {
      // Slightly smaller font in landscape mode
      return baseFontSize * 0.95;
    }
    return baseFontSize;
  }

  /// Get orientation-aware max lines
  int? _getOrientationAwareMaxLines() {
    if (widget.type == MPTextFieldType.PASSWORD ||
        widget.type == MPTextFieldType.BORDER_PASSWORD) {
      return 1; // Password fields always single line
    }

    final baseMaxLines = widget.textStyle?.maxLines;
    if (_isLandscape && baseMaxLines != null && baseMaxLines > 1) {
      // Reduce max lines in landscape mode for multi-line fields
      return (baseMaxLines * 0.7).ceil().clamp(1, baseMaxLines);
    }
    return baseMaxLines;
  }

  /// Get orientation-aware min lines
  int? _getOrientationAwareMinLines() {
    final baseMinLines =
        widget.textStyle?.minLines ?? MpUiKit.textStyle?.minLines;
    if (_isLandscape && baseMinLines != null && baseMinLines > 1) {
      // Reduce min lines in landscape mode for multi-line fields
      return (baseMinLines * 0.7).ceil().clamp(1, baseMinLines);
    }
    return baseMinLines;
  }

  /// Build counter text
  String? _buildCounterText() {
    final currentLength = widget.controller.text.length;
    final maxLength = widget.maxLength;

    if (maxLength != null) {
      return '$currentLength/$maxLength';
    } else {
      return currentLength.toString();
    }
  }

  void settingSuffixIcon() {
    if (widget.type == MPTextFieldType.PASSWORD ||
        widget.type == MPTextFieldType.BORDER_PASSWORD) {
      if (widget.obscureText == true) {
        widget.suffixIcon =
            (widget.suffixIconEyeClose ?? _defaultSuffixIconEyeClose);
      } else {
        widget.suffixIcon =
            (widget.suffixIconEyeOpen ?? _defaultSuffixIconEyeOpen);
      }
    }
  }

  // Theme-aware border methods
  // Creates borders with appropriate colors based on state and theme
  InputBorder _getThemeAwareBorder(
    MPThemeUtilities themeColors,
    String borderType,
  ) {
    // Only show borders for BORDER and BORDER_PASSWORD types
    // DEFAULT and PASSWORD types use underline style by default
    if (widget.type != MPTextFieldType.BORDER &&
        widget.type != MPTextFieldType.BORDER_PASSWORD) {
      return InputBorder.none;
    }

    Color borderColor;
    double borderWidth = 1.0;

    // Determine border color based on state
    switch (borderType) {
      case 'enabled':
        // Use adaptive border color for normal state
        borderColor = themeColors.adaptiveBorderColor;
        break;
      case 'focused':
        // Use primary focus color with increased width for emphasis
        borderColor = themeColors.primaryFocus;
        borderWidth = 2.0;
        break;
      case 'error':
        // Use error color for error indication
        borderColor = themeColors.errorColor;
        break;
      case 'focusedError':
        // Use error color with increased width for focused error state
        borderColor = themeColors.errorColor;
        borderWidth = 2.0;
        break;
      case 'disabled':
        // Use disabled color for disabled state
        borderColor = themeColors.disabledColor;
        break;
      default:
        // Default to adaptive border color
        borderColor = themeColors.adaptiveBorderColor;
    }

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(_isLandscape ? 6 : 8),
      borderSide: BorderSide(
        color: borderColor,
        width: borderWidth,
      ),
    );
  }
}

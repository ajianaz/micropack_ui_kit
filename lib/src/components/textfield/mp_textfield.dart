// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';
import 'package:micropack_ui_kit/src/core/styles/mp_text_field_border.dart';

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
    border = border ?? MpUiKit.border;
  }

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
    border = border ?? MpUiKit.border;
  }

  @override
  State<MPTextField> createState() => _MPTextFieldState();
}

class _MPTextFieldState extends State<MPTextField> {
  final Widget _defaultSuffixIconEyeOpen = const Icon(FontAwesomeIcons.eye);
  final Widget _defaultSuffixIconEyeClose =
      const Icon(FontAwesomeIcons.eyeSlash);

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

    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: widget.hintStyle?.toTextStyle(),
        hintMaxLines: widget.hintStyle?.maxLines,
        labelText: widget.label,
        labelStyle: widget.labelStyle?.toTextStyle(),
        label: widget.labelCustom,
        floatingLabelAlignment: widget.floatingLabelAlignment,
        floatingLabelBehavior: widget.floatingLabelBehavior,
        floatingLabelStyle: widget.floatingLabelStyle?.toTextStyle(),
        icon: widget.icon,
        iconColor: widget.iconColor,
        prefixIcon: widget.prefixIcon,
        prefixIconColor: widget.prefixIconColor,
        prefix: widget.prefix,
        prefixText: widget.prefixText,
        prefixStyle: widget.prefixTextStyle?.toTextStyle(),
        suffixIcon: finalSuffixIcon,
        suffixIconColor: widget.suffixIconColor,
        suffix: widget.suffix,
        suffixText: widget.suffixText,
        suffixStyle: widget.suffixTextStyle?.toTextStyle(),
        counterText:
            widget.showCounter ? _buildCounterText() : widget.counterText,
        counterStyle: widget.counterStyle?.toTextStyle(),
        helperText: widget.helperText,
        helperStyle: widget.helperStyle?.toTextStyle(),
        errorText: widget.errorText,
        errorStyle: widget.errorStyle?.toTextStyle(),
        fillColor: widget.fillColor,
        filled: widget.filled,
        border: widget.border?.border?.toBorder() ?? InputBorder.none,
        enabledBorder:
            widget.border?.enableBorder?.toBorder() ?? InputBorder.none,
        errorBorder: widget.border?.errorBorder?.toBorder() ?? InputBorder.none,
        focusedErrorBorder:
            widget.border?.focusedErrorBorder?.toBorder() ?? InputBorder.none,
        focusedBorder:
            widget.border?.focusedBorder?.toBorder() ?? InputBorder.none,
        disabledBorder:
            widget.border?.disableBorder?.toBorder() ?? InputBorder.none,
        contentPadding: widget.padding,
        constraints: widget.constraints,
        focusColor: Colors.transparent,
      ),
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      style: widget.textStyle?.toTextStyle() ?? MpUiKit.textStyle.toTextStyle(),
      textAlign: widget.textAlign,
      readOnly: widget.readOnly,
      obscureText: widget.obscureText,
      maxLines: widget.type == MPTextFieldType.PASSWORD ||
              widget.type == MPTextFieldType.BORDER_PASSWORD
          ? 1
          : widget.textStyle?.maxLines,
      minLines: widget.textStyle?.minLines ?? MpUiKit.textStyle?.minLines,
      cursorColor: widget.cursorColor ?? MpUiKit.colorBrand,
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
      scrollPadding: widget.scrollPadding ?? const EdgeInsets.all(20.0),
      textDirection: widget.textDirection,
    );
  }

  /// Build suffix icon with clear button and password toggle
  Widget? _buildSuffixIcon() {
    final List<Widget> icons = [];

    // Add clear button if enabled and field is not empty
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
                color: widget.suffixIconColor ??
                    MpUiKit.colorText.withValues(alpha: 0.6),
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
          padding: EdgeInsets.only(left: index > 0 ? 8.0 : 0.0),
          child: icons[index],
        ),
      ),
    );
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
}

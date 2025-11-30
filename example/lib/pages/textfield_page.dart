import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class TextFieldPage extends StatefulWidget {
  const TextFieldPage({super.key});

  @override
  State<TextFieldPage> createState() => _TextFieldPageState();
}

class _TextFieldPageState extends State<TextFieldPage> {
  final TextEditingController _defaultController = TextEditingController();
  final TextEditingController _borderController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _borderPasswordController = TextEditingController();
  final TextEditingController _validationController = TextEditingController();
  final TextEditingController _iconController = TextEditingController();
  final TextEditingController _formatterController = TextEditingController();

  @override
  void dispose() {
    _defaultController.dispose();
    _borderController.dispose();
    _passwordController.dispose();
    _borderPasswordController.dispose();
    _validationController.dispose();
    _iconController.dispose();
    _formatterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Field'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MPText.head('Basic Text Fields'),
            SizedBox(height: 16.h),
            
            // Default Text Field
            MPText.label('Default Text Field'),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.all(8.r),
              child: MPTextField(
                _defaultController,
                label: 'Username',
                hint: 'Enter your username',
                icon: Icon(Icons.person, color: MpUiKit.colorText.withValues(alpha: 0.6)),
                onChange: (value) => print('Default field changed: $value'),
              ),
            ),
            
            SizedBox(height: 16.h),
            
            // Border Text Field
            MPText.label('Border Text Field'),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.all(8.r),
              child: MPTextField.border(
                _borderController,
                label: 'Email',
                hint: 'Enter your email address',
                prefixIcon: Icon(Icons.email, color: MpUiKit.colorText.withValues(alpha: 0.6)),
                suffixText: '@example.com',
                helperText: 'Please enter a valid email address',
                onChange: (value) => print('Border field changed: $value'),
              ),
            ),
            
            SizedBox(height: 24.h),
            
            MPText.head('Password Fields'),
            SizedBox(height: 16.h),
            
            // Password Text Field
            MPText.label('Password Field'),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.all(8.r),
              child: MPTextField.password(
                _passwordController,
                label: 'Password',
                hint: 'Enter your password',
                helperText: 'Password must be at least 8 characters',
                onChange: (value) => print('Password field changed: $value'),
              ),
            ),
            
            SizedBox(height: 16.h),
            
            // Border Password Text Field
            MPText.label('Border Password Field'),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.all(8.r),
              child: MPTextField.borderPassword(
                _borderPasswordController,
                label: 'Confirm Password',
                hint: 'Confirm your password',
                helperText: 'Please re-enter your password',
                onChange: (value) => print('Border password field changed: $value'),
              ),
            ),
            
            SizedBox(height: 24.h),
            
            MPText.head('Validation & Advanced Features'),
            SizedBox(height: 16.h),
            
            // Validation Field
            MPText.label('Field with Validation'),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.all(8.r),
              child: MPTextField(
                _validationController,
                label: 'Phone Number',
                hint: 'Enter your phone number',
                keyboardType: TextInputType.phone,
                prefixIcon: Icon(Icons.phone, color: MpUiKit.colorText.withValues(alpha: 0.6)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone number is required';
                  }
                  if (value.length < 10) {
                    return 'Phone number must be at least 10 digits';
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'Phone number can only contain digits';
                  }
                  return null;
                },
                onChange: (value) => print('Validation field changed: $value'),
              ),
            ),
            
            SizedBox(height: 16.h),
            
            // Field with Icons and Custom Elements
            MPText.label('Field with Custom Icons'),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.all(8.r),
              child: MPTextField.border(
                _iconController,
                label: 'Search',
                hint: 'Search for items...',
                prefixIcon: Icon(Icons.search, color: MpUiKit.colorText.withValues(alpha: 0.6)),
                suffixIcon: Icon(Icons.mic, color: MpUiKit.colorText.withValues(alpha: 0.6)),
                filled: true,
                fillColor: Colors.grey.shade100,
                onChange: (value) => print('Icon field changed: $value'),
              ),
            ),
            
            SizedBox(height: 16.h),
            
            // Field with Input Formatter
            MPText.label('Field with Input Formatter'),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.all(8.r),
              child: MPTextField.border(
                _formatterController,
                label: 'Credit Card',
                hint: 'XXXX-XXXX-XXXX-XXXX',
                prefixIcon: Icon(Icons.credit_card, color: MpUiKit.colorText.withValues(alpha: 0.6)),
                keyboardType: TextInputType.number,
                inputFormatter: [
                  // Credit card formatter (XXXX-XXXX-XXXX-XXXX)
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  CardNumberInputFormatter(),
                ],
                onChange: (value) => print('Formatter field changed: $value'),
              ),
            ),
            
            SizedBox(height: 16.h),
            
            // Disabled Field
            MPText.label('Disabled Field'),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.all(8.r),
              child: MPTextField.border(
                TextEditingController(text: 'This field is disabled'),
                label: 'Disabled Field',
                enabled: false,
              ),
            ),
            
            SizedBox(height: 16.h),
            
            // Read Only Field
            MPText.label('Read Only Field'),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.all(8.r),
              child: MPTextField.border(
                TextEditingController(text: 'This field is read only'),
                label: 'Read Only Field',
                readOnly: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom input formatter for credit card numbers
class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (text.length > 16) {
      text = text.substring(0, 16);
    }
    
    String formatted = '';
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) {
        formatted += '-';
      }
      formatted += text[i];
    }
    
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(
        offset: formatted.length,
      ),
    );
  }
}

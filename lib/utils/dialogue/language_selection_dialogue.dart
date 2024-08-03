import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/constants/app_colors.dart';
import '../widgets/custom_button.dart';

class LanguageSelectionDialog extends StatefulWidget {
  const LanguageSelectionDialog({super.key});

  @override
  _LanguageSelectionDialogState createState() =>
      _LanguageSelectionDialogState();
}

class _LanguageSelectionDialogState extends State<LanguageSelectionDialog> {
  String _selectedLanguage = 'English'; // Default language

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Language'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<String>(
            title: const Text('English'),
            value: 'English',
            groupValue: _selectedLanguage,
            onChanged: (value) {
              setState(() {
                _selectedLanguage = value!;
              });
            },
          ),
          RadioListTile<String>(
            title: const Text('Amharic'),
            value: 'Amharic',
            groupValue: _selectedLanguage,
            onChanged: (value) {
              setState(() {
                _selectedLanguage = value!;
              });
            },
          ),
        ],
      ),
      actions: [
        CustomButton(
          padding: 12.h,
          onTap: () => Navigator.of(context).pop(_selectedLanguage),
          lable: "Submit",
          backgroundColor: AppColors.primaryColor,
        )
        // ElevatedButton(
        //   onPressed: () {
        //     Navigator.of(context).pop(_selectedLanguage);
        //   },
        //   child: const Text('Submit'),
        // ),
      ],
    );
  }
}

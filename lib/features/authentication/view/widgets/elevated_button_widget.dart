import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call_app/core/responsive/responsive.dart';
import 'package:video_call_app/core/theme/theme.dart';
import 'package:video_call_app/features/authentication/controller/authentication_controller.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({
    super.key,
    required this.authProvider,
    required this.onPressed,
    required this.label,
  });
  final VoidCallback onPressed;
  final String label;
  final AuthenticationController authProvider;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationController>(builder: (context, value, _) {
      return ElevatedButton(
        onPressed: onPressed,
        style: elevatedButtonStyle,
        child: value.loading
            ? const Center(child: CircularProgressIndicator(color: Colors.teal))
            : Text(
                label,
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: Responsive.text * 20,
                    fontWeight: FontWeight.bold),
              ),
      );
    });
  }
}

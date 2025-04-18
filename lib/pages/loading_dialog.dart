import 'package:flutter/material.dart';

void showLoadingDialog(BuildContext context, {String? message}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => Dialog(
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 48,
              height: 48,
              child: CircularProgressIndicator(
                strokeWidth: 4,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromRGBO(136, 117, 255, 1),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              message ?? 'Loading...',
              style: TextStyle(
                color: Colors.grey[200],
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void hideLoadingDialog(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}

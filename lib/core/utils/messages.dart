import 'package:flutter/material.dart';
import 'package:practical_test/features/shared/widget/loading_dialog.dart';

Function showLoadingDialog(BuildContext context, {String? message}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      child: LoadingDialog(message: message),
    ),
  );
  return () => Navigator.pop(context);
}

showToastMessage(
  BuildContext context,
  String message, {
  Icon? icon,
  Color? color,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      duration: Duration(seconds: 2),
      content: Row(
        children: [
          if (icon != null) ...[icon, const SizedBox(width: 10)],
          Text(message),
        ],
      ),
    ),
  );
}

Future<bool> showYesOrNoDialog(
  BuildContext context,
  String title,
  String message,
) async {
  bool ok = false;

  await showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("No"),
        ),
        TextButton(
          onPressed: () {
            ok = true;
            Navigator.pop(context);
          },
          child: Text("Si"),
        ),
      ],
    ),
  );

  return ok;
}

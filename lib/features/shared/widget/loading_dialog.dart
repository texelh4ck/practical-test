import 'package:flutter/cupertino.dart';

class LoadingDialog extends StatelessWidget {
  final String? message;

  const LoadingDialog({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [CupertinoActivityIndicator(), Text(message ?? "")],
      ),
    );
  }
}

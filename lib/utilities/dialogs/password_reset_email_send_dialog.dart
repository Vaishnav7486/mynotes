import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mynotesapp/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSendDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: 'Password reset',
    content:
        'We have now send your password reset link. Please check your mail for more details.',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}

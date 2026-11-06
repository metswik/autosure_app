import 'package:firebase_core/firebase_core.dart';

/// Converts Firebase Storage failures into actionable messages for app users.
String storageErrorMessage(Object error) {
  if (error is FirebaseException) {
    final code = error.code.split('/').last;
    switch (code) {
      case 'unauthorized':
        return 'Firebase Storage denied access. Check Firebase Console > Storage > Rules and allow the signed-in user to read and write this upload path.';
      case 'unauthenticated':
        return 'Your sign-in has expired. Sign in again and retry the upload.';
      case 'bucket-not-found':
      case 'project-not-found':
        return 'The Firebase Storage bucket was not found. Confirm Storage is enabled and the bucket matches lib/firebase_options.dart.';
      case 'quota-exceeded':
        return 'Firebase Storage quota has been exceeded. Check the Firebase project plan and storage usage.';
      case 'retry-limit-exceeded':
        return 'The upload could not complete after repeated retries. Check your internet connection and try again.';
      case 'canceled':
        return 'The upload was cancelled.';
      default:
        final message = error.message?.trim();
        return message == null || message.isEmpty
            ? 'Firebase Storage error (${error.code}). Check your Firebase Storage configuration and try again.'
            : message;
    }
  }

  return error.toString().replaceFirst(RegExp(r'^Exception: '), '');
}

class AppError {
  final String message;
  final AppErrorCode errorCode;

  AppError({
    required this.message,
    required this.errorCode,
  });

  @override
  String toString() =>
      'AppError{message: $message, errorCode: ${errorCode.value}}';
}

enum AppErrorCode {
  firestoreError('firestoreError'),
  validationError('validationError'),
  unknownError('unknownError');

  final String value;
  const AppErrorCode(this.value);
}

extension AppErrorCodeMessage on AppErrorCode {
  String get message {
    switch (this) {
      case AppErrorCode.firestoreError:
        return 'Firestore connection error';
      case AppErrorCode.validationError:
        return 'Validation error';

      case AppErrorCode.unknownError:
        return 'Unmapped error $this';
    }
  }
}

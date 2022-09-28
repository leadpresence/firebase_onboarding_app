
import 'package:firebase_auth/firebase_auth.dart';

enum AuthenticationError {
  invalidEmail,
  userDisabled,
  userNotFound,
  wrongPassword,
  emailAlreadyInUse,
  invalidCredential,
  operationNotAllowed,
  weakPassword,
  error,
}
AuthenticationError _determineError(FirebaseAuthException exception) {
  switch (exception.code) {
    case 'invalid-email':
      return AuthenticationError.invalidEmail;
    case 'user-disabled':
      return AuthenticationError.userDisabled;
    case 'user-not-found':
      return AuthenticationError.userNotFound;
    case 'wrong-password':
      return AuthenticationError.wrongPassword;
    case 'email-already-in-use':
    case 'account-exists-with-different-credential':
      return AuthenticationError.emailAlreadyInUse;
    case 'invalid-credential':
      return AuthenticationError.invalidCredential;
    case 'operation-not-allowed':
      return AuthenticationError.operationNotAllowed;
    case 'weak-password':
      return AuthenticationError.weakPassword;
    case 'ERROR_MISSING_GOOGLE_AUTH_TOKEN':
    default:
      return AuthenticationError.error;
  }
}

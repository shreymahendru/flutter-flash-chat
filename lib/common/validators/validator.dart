// import 'dart:async';

// import 'package:flash_chat/common/validators.dart';

// mixin Validator {
//   bool get isValidationEnabled;

//   final emailValidator = StreamTransformer<String, String>.fromHandlers(
//     handleData: (email, sink) {
//       // if (this.isValidationEnabled)

//       if (Validators.isValidEmail(email)) {
//         sink.add(email);
//       } else {
//         sink.addError("Email is invalid");
//       }
//     },
//   );

//   final passwordValidator = StreamTransformer<String, String>.fromHandlers(
//     handleData: (password, sink) {
//       if (Validators.isValidPassword(password)) {
//         sink.add(password);
//       } else {
//         sink.addError("Password is invalid");
//       }
//     },
//   );
// }

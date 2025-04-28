import 'package:chat_gpt_sdk_lululala/src/utils/constants.dart';
import 'dart:developer' as dev;

class Logger {
  bool isLogging = false;

  Logger();

  static Logger create({required bool isLogging}) {
    final logger = Logger();
    logger.isLogging = isLogging;
    return logger;
  }

  void log(String message) {
    if (isLogging) dev.log(message, name: kOpenAI);
  }

  void error(Object? err, StackTrace? t, {String? message = 'error'}) {
    if (isLogging) dev.log('$message', error: err, stackTrace: t);
  }
}

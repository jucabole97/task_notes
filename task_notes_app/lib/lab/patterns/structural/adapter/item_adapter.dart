abstract class Logger {
  void log(String message);
}

class ExternalLogger {
  void writeLog(String msg) {
    print("[ExternalLib] $msg");
  }
}

class LoggerAdapter implements Logger {
  final ExternalLogger _external;

  LoggerAdapter(this._external);

  @override
  void log(String message) {
    _external.writeLog("Adaptado -> $message");
  }
}

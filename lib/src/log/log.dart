/*
 * @Descripttion: 日志模块
 * @version: 1.0
 * @Author: Matthew
 * @Date: 2021-06-15 09:28:33
 * @LastEditTime: 2021-06-16 23:10:34
 */
import 'package:logger/logger.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

// 日志输出类
class LogOut extends LogOutput {
  final bool consoleOutput;
  final bool writeLocalFile;
  final String logFileName;
  final int fileLimitSize;
  LogOut({this.consoleOutput, this.writeLocalFile, this.logFileName, this.fileLimitSize});

  @override
  void output(OutputEvent event) {
    if (consoleOutput) event.lines.forEach(print);
    if (writeLocalFile) writeLogFile(event.lines);
    // event.lines.forEach(writeLogFile);
    if (writeLocalFile) readLogFile();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> getLocalFile() async {
    final path = await _localPath;
    return File('$path/$logFileName.log');
  }

  Future renameLocalFile() async {
    final path = await _localPath;
    String oldName = '$logFileName.log';
    String newName = logFileName + '_old.log';
    await File('$path/$oldName').rename('$path/$newName');
  }

  void writeLogFile(List<String> lines) async {
    final fileName = '$logFileName.log';
    final path = await _localPath;
    final size = await getFileSize('$path/$fileName');
    final newFile = checkSize(size);
    if (newFile) {
      // 日志文件大小到阈值
      // xxxxlog重命名xxxxlog_old
      await renameLocalFile();
      // 继续在xxxxlog中写日志
    }
    final logFile = await getLocalFile();
    final line = lines[1] ?? '';
    logFile.writeAsString(line, mode: FileMode.append);
  }

  Future<int> getFileSize(String path) async {
    final stat = await FileStat.stat(path);
    // stat.accessed stat.modified stat.changed
    return stat.size;
  }

  bool checkSize(int size) {
    return (size > fileLimitSize);
  }

  Future<String> readLogFile() async {
    try {
      final file = await getLocalFile();
      final contents = await file.readAsString();
      print(contents);
      return contents;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }
}

// 日志类
class Log {
  // output 配置参数
  static bool _consoleOutput;
  static bool get consoleOutput => _consoleOutput;
  static bool _writeLocalFile;
  static bool get writeLocalFile => _writeLocalFile;
  static String _logFileName;
  static String get logFileName => _logFileName;
  static int _fileLimitSize;
  static int get fileLimitSize => _fileLimitSize;
  // log 配置参数
  static int _methodCount;
  static int get methodCount => _methodCount;
  static int _errorMethodCount;
  static int get errorMethodCount => _errorMethodCount;
  static int _lineLength;
  static int get lineLength => _lineLength;
  static bool _colors;
  static bool get colors => _colors;
  static bool _printEmojis;
  static bool get printEmojis => _printEmojis;
  static bool _printTime;
  static bool get printTime => _printTime;

  static Logger logger;
  static LogOut output = LogOut(consoleOutput: consoleOutput, writeLocalFile: writeLocalFile, logFileName: logFileName, fileLimitSize: fileLimitSize);
  static Logger get _logger {
    if (logger == null) {
      logger = Logger(
          printer: PrettyPrinter(
              methodCount: methodCount, // number of method calls to be displayed
              errorMethodCount: errorMethodCount, // number of method calls if stacktrace is provided
              lineLength: lineLength, // width of the output
              colors: colors, // Colorful log messages
              printEmojis: printEmojis, // Print an emoji for each log message
              printTime: printTime // Should each log print contain a timestamp
              ),
          output: output);
    }
    return logger;
  }

  static setParms(
      {int methodCount = 0,
      int errorMethodCount = 8,
      int lineLength = 50,
      bool colors = true,
      bool printEmojis = false,
      bool printTime = false,
      bool consoleOutput = true,
      bool writeLocalFile = true,
      String logFileName = 'flutterlogxxx',
      int fileLimitSize = 1024}) {
    _methodCount = methodCount;
    _errorMethodCount = errorMethodCount;
    _lineLength = lineLength;
    _colors = colors;
    _printEmojis = printEmojis;
    _printTime = printTime;
    _consoleOutput = consoleOutput;
    _writeLocalFile = writeLocalFile;
    _logFileName = logFileName;
    _fileLimitSize = fileLimitSize;
  }

  static verbose(dynamic message) {
    var logger = _logger;
    logger.v(message);
  }

  static debug(dynamic message) {
    var logger = _logger;
    logger.d(message);
  }

  static info(dynamic message) {
    var logger = _logger;
    logger.i(message);
  }

  static warning(dynamic message) {
    var logger = _logger;
    logger.w(message);
  }

  static error(dynamic message) {
    var logger = _logger;
    logger.e(message);
  }

  static wtf(dynamic message) {
    var logger = _logger;
    logger.wtf(message);
  }

  static Future<String> openConsole() async {
    final content = await output.readLogFile();
    return content;
  }
}

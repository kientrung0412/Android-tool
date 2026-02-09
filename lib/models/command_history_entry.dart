class CommandHistoryEntry {
  CommandHistoryEntry({
    required this.command,
    required this.output,
    required this.exitCode,
    required this.isError,
    required this.timestamp,
  });

  final String command;
  final String output;
  final int? exitCode;
  final bool isError;
  final DateTime timestamp;

  Map<String, dynamic> toJson() => {
        'command': command,
        'output': output,
        'exitCode': exitCode,
        'isError': isError,
        'timestamp': timestamp.toIso8601String(),
      };

  static CommandHistoryEntry fromJson(Map<String, dynamic> json) {
    return CommandHistoryEntry(
      command: json['command'] as String? ?? '',
      output: json['output'] as String? ?? '',
      exitCode: json['exitCode'] as int?,
      isError: json['isError'] as bool? ?? false,
      timestamp: DateTime.tryParse(json['timestamp'] as String? ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  String get timestampLabel {
    final y = timestamp.year.toString().padLeft(4, '0');
    final m = timestamp.month.toString().padLeft(2, '0');
    final d = timestamp.day.toString().padLeft(2, '0');
    final hh = timestamp.hour.toString().padLeft(2, '0');
    final mm = timestamp.minute.toString().padLeft(2, '0');
    final ss = timestamp.second.toString().padLeft(2, '0');
    return '$y-$m-$d $hh:$mm:$ss';
  }
}

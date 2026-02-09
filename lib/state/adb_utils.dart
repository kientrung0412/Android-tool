import '../models/command_spec.dart';

List<CommandSpec> sortByRecent(
  List<CommandSpec> specs,
  List<String> recent,
) {
  if (recent.isEmpty) return specs;
  final index = <String, int>{};
  for (int i = 0; i < recent.length; i++) {
    index[recent[i]] = i;
  }
  final sorted = List<CommandSpec>.from(specs);
  sorted.sort((a, b) {
    final ai = index[a.command];
    final bi = index[b.command];
    if (ai == null && bi == null) return 0;
    if (ai == null) return 1;
    if (bi == null) return -1;
    return ai.compareTo(bi);
  });
  return sorted;
}

List<String> parseArgs(String input) {
  final List<String> args = [];
  final StringBuffer current = StringBuffer();
  bool inQuotes = false;

  for (int i = 0; i < input.length; i++) {
    final char = input[i];
    if (char == '"') {
      inQuotes = !inQuotes;
      continue;
    }
    if (char == ' ' && !inQuotes) {
      if (current.isNotEmpty) {
        args.add(current.toString());
        current.clear();
      }
    } else {
      current.write(char);
    }
  }

  if (current.isNotEmpty) {
    args.add(current.toString());
  }

  return args;
}

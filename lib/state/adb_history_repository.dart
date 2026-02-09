import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../models/command_history_entry.dart';

class HistoryRepository {
  Future<File> _file() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/command_history.json');
  }

  Future<File> _connectIpFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/adb_connect_ips.json');
  }

  Future<List<CommandHistoryEntry>> load() async {
    try {
      final file = await _file();
      if (!await file.exists()) return [];
      final raw = await file.readAsString();
      final data = jsonDecode(raw);
      if (data is! List) return [];
      return data
          .whereType<Map<String, dynamic>>()
          .map(CommandHistoryEntry.fromJson)
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> save(List<CommandHistoryEntry> entries) async {
    final file = await _file();
    final raw = jsonEncode(entries.map((e) => e.toJson()).toList());
    await file.writeAsString(raw);
  }

  Future<List<String>> loadConnectIps() async {
    try {
      final file = await _connectIpFile();
      if (!await file.exists()) return [];
      final raw = await file.readAsString();
      final data = jsonDecode(raw);
      if (data is! List) return [];
      return data.whereType<String>().toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> saveConnectIps(List<String> ips) async {
    final file = await _connectIpFile();
    await file.writeAsString(jsonEncode(ips));
  }
}

import 'dart:io';

Future<List<String>> scanSubnet(String prefix) async {
  const port = 5555;
  const timeout = Duration(milliseconds: 220);
  const batchSize = 50;
  final found = <String>[];

  final pending = <Future<void>>[];
  for (int i = 1; i <= 254; i++) {
    final host = '$prefix.$i';
    pending.add(probeHost(host, port, timeout).then((open) {
      if (open) {
        found.add(host);
      }
    }));
    if (pending.length >= batchSize) {
      await Future.wait(pending);
      pending.clear();
    }
  }
  if (pending.isNotEmpty) {
    await Future.wait(pending);
  }
  return found;
}

Future<bool> probeHost(
  String host,
  int port,
  Duration timeout,
) async {
  Socket? socket;
  try {
    socket = await Socket.connect(host, port, timeout: timeout);
    return true;
  } on Exception {
    return false;
  } finally {
    socket?.destroy();
  }
}

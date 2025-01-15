import 'package:gamify_todo/2%20General/accessible.dart';
import 'package:gamify_todo/5%20Service/server_manager.dart';

class AppHelper {
  void addCreditByProgress(Duration? progress) async {
    if (progress == null) return;

    loginUser!.creditProgress += progress;

    while (loginUser!.creditProgress.inHours >= 1) {
      loginUser!.userCredit += 1;
      loginUser!.creditProgress -= const Duration(hours: 1);
    }

    await ServerManager().updateUser(userModel: loginUser!);
  }
}

import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:whowhats/reusable/miscellaneous/globals.dart';

class LoginController extends ControllerMVC {
  static LoginController? _this;
  factory LoginController() {
    _this ??= LoginController._();
    return _this!;
  }
  LoginController._();

  Future<String?> login(String email, String mdp, bool mdpIsSelected) async {
    if (Globals.logged) {}
  }
}

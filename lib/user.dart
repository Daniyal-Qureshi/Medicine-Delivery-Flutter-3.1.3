import 'package:hive/hive.dart';

class User {
  static void setUserEmail(String email) async {
    var user = await Hive.openBox('User');
    await user.put("email", email);
  }

  static String getUserEmail() {
    var user = Hive.box('User');
    return user.get("email");
  }
}

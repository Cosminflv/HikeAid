import 'package:running_app/config/theme.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> showErrorToast(String msg) async {
  await Fluttertoast.cancel();
  await Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: errorColor,
    textColor: buttonContentColor,
    fontSize: 16.0,
  );
}

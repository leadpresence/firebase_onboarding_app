import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mlog/core/core_utils.dart';
import '../../theme/color.dart';
import '../root_app.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  /// value to hold verification state
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    /// Check registered user is verified and set value to that
    isEmailVerified =
        UtilsProvider().auth.currentUser!.emailVerified ? true : false;

    /// send email for verification
    if (!isEmailVerified) {
      sendEmailVerification();
    }

    /// period state to check every 3 secs
    timer = Timer.periodic(
        const Duration(seconds: 3), (timer) => doCheckEmailIsVerified());
    super.initState();
  }

  /// To send email
  Future sendEmailVerification() async {
    try {
      await UtilsProvider().auth.currentUser?.sendEmailVerification();
    } catch (e) {
      BotToast.showText(text: "An Error occurred \n ${e.toString()}");
    }
  }

  /// to check verification state and set value to that
  Future doCheckEmailIsVerified() async {
    /// reload registered user state
    await UtilsProvider().auth.currentUser!.reload();
    setState(() {
      isEmailVerified = UtilsProvider().auth.currentUser!.emailVerified;
    });
    /// Cancel timer once user is verified hence no longer reloads user
    if(isEmailVerified) timer?.cancel();
  }

  @override
  void dispose() {
    /// cancel timer when you leave screen
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      /// if s verified go to the home screen  else show user a message
      ? RootApp(
          key: widget.key,
        )
      : Scaffold(
          backgroundColor: white,
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(color: primary, CupertinoIcons.flag),
                Text(
                  "Check your email & Verify account ",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 18),
                  maxLines: 2,
                ),
              ],
            ),
          ),
        );
}

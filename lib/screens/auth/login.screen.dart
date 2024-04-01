import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milunch_pos/utilities/texts_constants.dart';
import 'package:milunch_pos/view_models/auth.vm.dart';
import 'package:pinput/pinput.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, p1) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/logo/1024.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: SizedBox(),
            )),
            Expanded(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 21),
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      Texts.hello(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ubuntu(fontSize: 30, )
                    ),
                    const SizedBox(height: 8),
                    Text(
                     Texts.loginText(),
                      style: GoogleFonts.ubuntu(fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Pinput(
                      onCompleted: (pin) => SecurityViewModel().handleLogin(context, int.parse(pin)),
                      showCursor: true,
                      autofocus: true,
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

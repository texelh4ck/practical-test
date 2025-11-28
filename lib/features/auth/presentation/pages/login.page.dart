import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:practical_test/config/theme/theme.dart';
import 'package:practical_test/core/constants/const.dart';
import 'package:practical_test/core/constants/enums.dart';
import 'package:practical_test/core/utils/data_state.dart';
import 'package:practical_test/core/utils/messages.dart';
import 'package:practical_test/features/auth/domain/usecases/sign_in.dart';
import 'package:practical_test/features/shared/widget/app_icon.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _iEmail = TextEditingController();
  final _iPassword = TextEditingController();
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentGeometry.directional(0, -1.4),
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 350, sigmaY: 350),
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                color: Colors.lightGreen.withAlpha(100),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Center(
              child: Column(
                spacing: 15,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'app-icon',
                    transitionOnUserGestures: true,
                    child: AppIcon(),
                  ),
                  Text(APP_NAME, style: theme.textTheme.titleLarge),
                  _buildForm(),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton.icon(
                          onPressed: _btSignInWithGoogle,
                          label: Text("Google"),
                          icon: SvgPicture.asset(
                            'lib/assets/icons/google.svg',
                            width: 20,
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton.icon(
                          onPressed: _btSignInWithFacebook,
                          label: Text("Facebook"),
                          icon: SvgPicture.asset(
                            'lib/assets/icons/facebook.svg',
                            width: 20,
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: _btCreateAccount,
                          child: Text("Create Account"),
                        ),
                      ),
                      Expanded(
                        child: FilledButton(
                          onPressed: _btSignInWithEmail,
                          child: Text("Sign In"),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: _btForgotPassword,
                    child: Text("Forgot Password"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          TextField(
            controller: _iEmail,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              label: Text("Email"),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 15),
          TextField(
            obscureText: !_showPassword,
            controller: _iPassword,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.password),
              label: Text("Password"),
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
                icon: Icon(
                  _showPassword
                      ? Icons.remove_red_eye
                      : Icons.remove_red_eye_outlined,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _btCreateAccount() {}

  _btSignInWithEmail() {}
  _btSignInWithGoogle() async {
    SignInUseCase usecase = GetIt.instance.get();
    final state = await usecase(AuthMethod.google);
    if (state is DataFailed) {
      showToastMessage(context, state.exception.toString());
    }
    Navigator.pushNamedAndRemoveUntil(context, '/products', (route) => false);
  }

  _btSignInWithFacebook() async {
    SignInUseCase usecase = GetIt.instance.get();
    final state = await usecase(AuthMethod.facebook);
    if (state is DataFailed) {
      showToastMessage(context, state.exception.toString());
    }
  }

  void _btForgotPassword() {}
}

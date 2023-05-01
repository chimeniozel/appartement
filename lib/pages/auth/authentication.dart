import 'package:flutter/material.dart';
import '../../theme/color.dart';
import '../../widgets/auth_tab.dart';
import '../../widgets/login_form.dart';
import '../../widgets/register_form.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  String active = "login";

  void setActive(String val) {
    setState(() {
      active = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  ClipRect(
                    child: Transform.scale(
                      scale: 1.5,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/pattern.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    child: Container(
                      constraints: const BoxConstraints(minWidth: 200.0),
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.18,
                      color: primaryColor,
                      child: const Text(
                        "Bienvenue",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              AuthTab(
                active: active,
                setActive: setActive,
              ),
              const SizedBox(
                height: 40.0,
              ),
              AnimatedCrossFade(
                firstChild: const LoginForm(),
                secondChild: const RegisterForm(),
                crossFadeState: active == "register"
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Termes & Conditions",
                  style: TextStyle(color: primaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

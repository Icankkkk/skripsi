import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:discuss_app/config/app_asset.dart';
import 'package:discuss_app/config/app_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../config/session.dart';
import '../controller/c_user.dart';
import '../model/user.dart';
import '../source/user_source.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();

  login(BuildContext context) {
    UserSource.login(controllerUsername.text, controllerPassword.text)
        .then((responseBody) {
      if (responseBody['success']) {
        var mapUser = Map<String, dynamic>.from(responseBody['data']);
        User user = User.fromJson(mapUser);
        Session.setUser(user);
        context.read<CUser>().data = user;

        DInfo.dialogSuccess(context, 'Berhasil Login');
        DInfo.closeDialog(context, actionAfterClose: () {
          context.go(AppRoute.home);
        });
      } else {
        DInfo.snackBarError(context, 'Gagal Login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Color(0xffa9d2fe)],
          ),
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DView.spaceHeight(90),
                  Image.asset(
                    AppAsset.logo,
                    width: 280,
                  ),
                  Card(
                    margin: const EdgeInsets.all(32),
                    elevation: 8,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          DView.textTitle('Login Dulu!'),
                          DView.spaceHeight(8),
                          const Divider(),
                          DView.spaceHeight(4),
                          DInput(
                            controller: controllerUsername,
                            title: "Username",
                            validator: (value) =>
                                value == '' ? "Username gaboleh kosong" : null,
                          ),
                          DView.spaceHeight(),
                          DInputPassword(
                            controller: controllerPassword,
                            title: "Password",
                            obsecureCharacter: '*',
                            validator: (value) =>
                                value == '' ? "Password gaboleh kosong" : null,
                          ),
                          DView.spaceHeight(20),
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () => login(context),
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 24,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Belum punya akun ?",
                          style: TextStyle(
                            color: Colors.black87,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.push(AppRoute.register);
                          },
                          child: const Text(
                            "Daftar dulu disini!",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

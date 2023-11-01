import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:discuss_app/source/user_source.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();

  register(BuildContext context) {
    UserSource.register(controllerUsername.text, controllerPassword.text)
        .then((responseBody) {
      if (responseBody['success']) {
        DInfo.dialogSuccess(context, 'Berhasil mendaftar');
        DInfo.closeDialog(context, actionAfterClose: () {
          context.pop();
        });
      } else {
        if (responseBody['message'] == 'username') {
          DInfo.snackBarError(context, 'Username sudah dipakai');
        } else {
          DInfo.snackBarError(context, 'Gagal mendaftar');
        }
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
                  Card(
                    margin: const EdgeInsets.all(32),
                    color: Colors.white,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          DView.textTitle('Daftar Akun'),
                          DView.spaceHeight(8),
                          const Divider(),
                          DView.spaceHeight(4),
                          DInput(
                            controller: controllerUsername,
                            title: 'Username',
                            isRequired: true,
                            validator: (value) =>
                                value == '' ? "Username wajib diisi" : null,
                          ),
                          DView.spaceHeight(),
                          DInputPassword(
                            controller: controllerPassword,
                            title: 'Password',
                            isRequired: true,
                            validator: (value) =>
                                value == '' ? "Password wajib diisi" : null,
                            obsecureCharacter: '*',
                          ),
                          DView.spaceHeight(20),
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () => register(context),
                              child: const Text(
                                "Daftar",
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
                          "Sudah punya akun ?",
                          style: TextStyle(
                            color: Colors.black87,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: const Text(
                            "Login disini!",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

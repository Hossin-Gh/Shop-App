import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/authentication/auth_bloc.dart';
import 'package:flutter_application_1/bloc/authentication/auth_event.dart';
import 'package:flutter_application_1/bloc/authentication/auth_state.dart';
import 'package:flutter_application_1/constans/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScr extends StatelessWidget {
  LoginScr({super.key});

  final _usernameCntroller = TextEditingController(text: 'amirahmad');
  final _passwordCntroller = TextEditingController(text: '12345678');

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: CustomColor.blue,
        body: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/icon_application.png',
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'اپل شاپ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'sb',
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _usernameCntroller,
                      decoration: const InputDecoration(
                        // contentPadding: rtrt,
                        labelText: 'نام کاربری',
                        labelStyle: TextStyle(
                          fontFamily: 'sm',
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 3,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide: BorderSide(
                            color: CustomColor.blue,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _passwordCntroller,
                      decoration: const InputDecoration(
                        // contentPadding: rtrt,
                        labelText: 'رمز عبور',
                        labelStyle: TextStyle(
                          fontFamily: 'sm',
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 3,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide: BorderSide(
                            color: CustomColor.blue,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthIinitiateState) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColor.blue,
                              textStyle: const TextStyle(
                                fontFamily: 'sb',
                                fontSize: 18,
                              ),
                              minimumSize: const Size(200, 48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              BlocProvider.of<AuthBloc>(context).add(
                                AuthLoginRequestEvent(
                                  _usernameCntroller.text,
                                  _passwordCntroller.text,
                                ),
                              );
                            },
                            child: const Text(
                              'ورود به حساب کاربری',
                            ),
                          );
                        }
                        if (state is AuthLoadingState) {
                          return const CircularProgressIndicator();
                        }
                        if (state is AuthResponseState) {
                          Text widget =const Text('');
                          state.respons.fold(
                            (l) {
                              widget = Text(l);
                            },
                            (r) {
                              widget = Text(r);
                            },
                          );
                          return widget;
                        }
                        return const Text('خطای نامشخص !');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




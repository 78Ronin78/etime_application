import 'package:etime_application/helpers/size_config.dart';
import 'package:etime_application/repository/firebase_auth.dart';
import 'package:etime_application/widgets/custom_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyRegister = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;
  late String _email;
  late String _regEmail;
  late String _regPassword;
  late String _confirmPassword;
  bool userAuth = false;
  late String _password;
  String errorMsg = "";
  late String _verificationID;
  int numScreen = 1;
  bool isLoad = false;
  final _pinPutController = TextEditingController();
  bool codeSumbit = false;
  bool _obscurePassword = true;
  bool codeVerify = true;

  setPage(value) {
    setState(() {
      numScreen = value;
    });
  }

  void reg() async {
    if (_regPassword == _confirmPassword) {
      try {
        CustomSnackBar(
          context,
          const Text('Пожалуйста подождите...'),
          Color.fromARGB(255, 10, 13, 66),
        );
        await _auth
            .createUserWithEmailAndPassword(
                email: _regEmail, password: _regPassword)
            .then((value) {
          Navigator.pushNamed(context, 'registrationScreen');
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          CustomSnackBar(
            context,
            const Text('Пароль слишком простой'),
            Color.fromARGB(255, 249, 22, 112),
          );
          print('Пароль слишком простой');
        } else if (e.code == 'email-already-in-use') {
          CustomSnackBar(
            context,
            const Text('Данный email уже занят'),
            Color.fromARGB(255, 249, 22, 112),
          );
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    } else {
      CustomSnackBar(
        context,
        const Text('Пароли не совпадают'),
        Color.fromARGB(255, 249, 22, 112),
      );
    }
  }

  void _validateRegisterInput() async {
    final FormState? form = _formKeyRegister.currentState;
    if (_formKeyRegister.currentState?.validate() != null) {
      form?.save();
      reg();
    }
  }

  String? emailValidator(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (value == null) return 'Введите E-Mail';
    if (!regex.hasMatch(value))
      return 'Почта введена некоректно';
    else {
      return null;
    }
  }

  void _validateAuth() async {
    final FormState? form = _formKey.currentState;
    if (_formKey.currentState?.validate() != null) {
      CustomSnackBar(
        context,
        const Text('Выполняется вход, пожалуйста подождите'),
        Color.fromARGB(255, 10, 13, 66),
      );
      form?.save();
      try {
        bool result = await fbAuth.auth(_email, _password);
        if (result) {
          print('Document exists on the database');
          Navigator.pushNamedAndRemoveUntil(
              context, 'tabNavigator', (Route<dynamic> route) => false);
        } else {
          Navigator.pushNamed(context, 'registrationScreen');
        }
      } on Exception catch (e) {
        print(e);
        CustomSnackBar(
          context,
          Text(e.toString()),
          Color.fromARGB(255, 249, 22, 112),
        );
      }
    }
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget emailForm() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Вход',
            ),
            InkWell(
              onTap: () {
                setState(() {
                  print('Нажали на кнопку');
                  numScreen = 2;
                });
                setPage(numScreen);
              },
              child: Row(
                children: [
                  Text(
                    'Регистрация',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  SvgPicture.asset(
                    'assets/svg/arrow.svg',
                    width: 6,
                    height: 10,
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 25, left: 10, right: 10, bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white,
          ),
          child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Электронная почта',
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                onSaved: (input) {
                  _email = input!;
                },
                validator: emailValidator,
                decoration: InputDecoration(
                  //errorStyle: validateText,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                  prefixIcon: Container(
                    transform: Matrix4.translationValues(-10.0, 0.0, 0.0),
                    // child: SvgPicture.asset(
                    //   'assets/svg/mail.svg',
                    //   fit: BoxFit.scaleDown,
                    //   width: 15,
                    //   height: 12,
                    // ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFC5CEE0)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFC5CEE0)),
                  ),
                  hintText: 'Example@mail.com',
                  //hintStyle: hintText
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text('Пароль'),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                obscureText: _obscurePassword,
                onSaved: (input) => _password = input!,
                validator: (input) {
                  if (input == null) {
                    return "Неверный пароль";
                  } else {
                    if (input.length < 6) {
                      return "Пароль слишком короткий";
                    } else {
                      return null;
                    }
                  }
                },
                decoration: InputDecoration(
                  //errorStyle: validateText,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                  suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      child: SvgPicture.asset('assets/svg/eye.svg',
                          width: 15, height: 15, fit: BoxFit.scaleDown)),
                  prefixIcon: Container(
                    transform: Matrix4.translationValues(-10.0, 0.0, 0.0),
                    child: SvgPicture.asset(
                      'assets/svg/key.svg',
                      fit: BoxFit.scaleDown,
                      width: 15,
                      height: 12,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFC5CEE0)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFC5CEE0)),
                  ),
                  hintText: 'Введите пароль',
                  //hintStyle: hintText
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Text.rich(TextSpan(
                  text: 'Нажимая кнопку "Войти" вы подтверждаете согласие с  ',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Условиями пользования',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.purpleAccent[700],
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            //_launchURL(AGREEMENT);
                          }),
                    TextSpan(
                        text: ' и ',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Политикой конфиденциальности',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.purpleAccent[700],
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  //_launchURL(POLITICIANS);
                                })
                        ])
                  ])),
              SizedBox(
                height: 25.0,
              ),
              TextButton(onPressed: _validateAuth, child: Text('Войти')),
              SizedBox(
                height: 14,
              ),
              Center(
                  child: TextButton(
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => PasswordRecoveryScreen()));
                },
                child: Text(
                  'Забыли пароль?',
                  //style: title3.copyWith(fontSize: 16),
                ),
              )),
              SizedBox(
                height: 25,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: Color(0xFFE7EBF2),
              ),
              SizedBox(
                height: 20,
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget regUserEmail() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Регистрация',
              // style: title,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  print('Нажали на кнопку 2');
                  numScreen = 1;
                });
              },
              child: Row(
                children: [
                  Text(
                    'Вход',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  SvgPicture.asset(
                    'assets/svg/arrow.svg',
                    width: 6,
                    height: 10,
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 25, left: 10, right: 10, bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white,
          ),
          child: Form(
            key: _formKeyRegister,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Электронная почта',
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                onSaved: (input) {
                  _regEmail = input!;
                },
                validator: emailValidator,
                decoration: InputDecoration(
                  //errorStyle: validateText,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                  prefixIcon: Container(
                    transform: Matrix4.translationValues(-10.0, 0.0, 0.0),
                    child: SvgPicture.asset(
                      'assets/svg/mail.svg',
                      fit: BoxFit.scaleDown,
                      width: 15,
                      height: 12,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFC5CEE0)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFC5CEE0)),
                  ),
                  hintText: 'Example@mail.com',
                  //hintStyle: hintText
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'Пароль',
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                obscureText: true,
                onSaved: (input) => _regPassword = input!,
                validator: (input) {
                  if (input == null) {
                    return "Неверный пароль";
                  } else {
                    if (input.length < 6) {
                      return "Не менее 6 символов";
                    } else {
                      return null;
                    }
                  }
                },
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                  suffixIcon: InkWell(
                      onTap: () {},
                      child: SvgPicture.asset('assets/svg/eye.svg',
                          width: 15, height: 15, fit: BoxFit.scaleDown)),
                  prefixIcon: Container(
                    transform: Matrix4.translationValues(-10.0, 0.0, 0.0),
                    child: SvgPicture.asset(
                      'assets/svg/key.svg',
                      fit: BoxFit.scaleDown,
                      width: 15,
                      height: 12,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFC5CEE0)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFC5CEE0)),
                  ),
                  hintText: 'Введите пароль',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                obscureText: true,
                onSaved: (input) => _confirmPassword = input!,
                validator: (input) {
                  if (input == null) {
                    return "Неверный пароль";
                  } else {
                    if (input.length < 6) {
                      return "Не менее 6 символов";
                    } else {
                      return null;
                    }
                  }
                },
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                  suffixIcon: InkWell(
                      onTap: () {},
                      child: SvgPicture.asset('assets/svg/eye.svg',
                          width: 15, height: 15, fit: BoxFit.scaleDown)),
                  prefixIcon: Container(
                    transform: Matrix4.translationValues(-10.0, 0.0, 0.0),
                    child: SvgPicture.asset(
                      'assets/svg/key.svg',
                      fit: BoxFit.scaleDown,
                      width: 15,
                      height: 12,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFC5CEE0)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFC5CEE0)),
                  ),
                  hintText: 'Повторите пароль',
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              TextButton(
                  onPressed: _validateRegisterInput,
                  child: Text('Зарегистрироваться')),
              SizedBox(
                height: 14,
              ),
              Center(
                  child: TextButton(
                onPressed: () {},
                child: Text(
                  'Забыли пароль?',
                ),
              )),
              SizedBox(
                height: 25,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: Color(0xFFE7EBF2),
              ),
              SizedBox(
                height: 20,
              ),
            ]),
          ),
        ),
      ],
    );
  }

  getPage() {
    switch (numScreen) {
      case 1:
        return emailForm();
      case 2:
        return regUserEmail();
      // case 4:
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    //final mediaQuery = MediaQuery.of(context).size.height - 110;
    return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Color.fromARGB(255, 10, 13, 66),
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.only(left: 22, right: 22),
                padding: EdgeInsets.only(bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 200.0.toAdaptive(context),
                      child:
                          Center(child: Image.asset("assets/logo/applogo.png")),
                    ),
                    getPage(),
                  ],
                ),
              ),
            )));
  }
}

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etime_application/helpers/config_color.dart';
import 'package:etime_application/helpers/links.dart';
import 'package:etime_application/helpers/size_config.dart';
import 'package:etime_application/models/profile_model.dart';
import 'package:etime_application/repository/firebase_auth.dart';
import 'package:etime_application/widgets/InputText.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:url_launcher/url_launcher.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firebaseDB = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Stream users = Stream.empty();
  String _name = '';
  String _surname = '';
  String _phone = '';
  String city = '';
  int _gender = 0;
  int _currentSliderValue = 0;
  String dropdownValue = 'Укажите город';
  TextEditingController age = TextEditingController();
  TextEditingController _city = TextEditingController();

  var maskFormatter = new MaskTextInputFormatter(
      mask: '+7 (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});

  bool cityError = false;

  @override
  void initState() {
    super.initState();
    _currentSliderValue = 20;
    setState(() {
      age.text = _currentSliderValue.toString();
    });
  }

  void _validateSaveUserInfo() async {
    final FormState? form = _formKey.currentState;
    if (_formKey.currentState!.validate() && city != null) {
      form!.save();
      FireBaseAuth.addUser(
          name: _name,
          surname: _surname,
          phone: _phone,
          age: _currentSliderValue.toInt(),
          gender: _gender,
          city: city,
          uid: _auth.currentUser!.uid,
          context: context);
      print('Выполняется условие 1');
    } else if (!_formKey.currentState!.validate()) {
      print('Выполняется условие 2');
      print('Выполняется условие 2 ${_formKey.currentState!.validate()}');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Заполните все поля')));
    }
    /*if (_formKey.currentState.validate() && city == null) {
      print('$_name');
      print('Выполняется условие 2');
      _scaffoldKey?.currentState
          ?.showSnackBar(SnackBarScope.show('Выберите город'));
    }
    if (city == null || _name != null) {
      print('Выполняется условие 3');
      _scaffoldKey?.currentState
          ?.showSnackBar(SnackBarScope.show('Заполните все поля'));
      setState(() {
        cityError = true;
      });
    }*/
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color.fromARGB(255, 10, 13, 66),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 1.2,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Flexible(
                  child: Container(),
                ),
                Container(
                  height: 200.0.toAdaptive(context),
                  child: Center(child: Image.asset("assets/logo/applogo.png")),
                ),
                Flexible(
                  child: Container(),
                ),
                Text(
                  'Создание профиля',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 20, left: 10, right: 20, bottom: 13),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        //color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Укажите имя',
                          style: TextStyle(color: Colors.white),
                        ),
                        primaryInput(
                          hint: 'Введите имя',
                          onSaved: (input) {
                            setState(() {
                              _name = input!;
                              print('Имя в onsaved: $_name');
                            });
                          },
                          validateText: 'Введите имя',
                          prefix: Container(
                            transform:
                                Matrix4.translationValues(-10.0, 0.0, 0.0),
                            child: SvgPicture.asset(
                              'assets/svg/profile.svg',
                              fit: BoxFit.scaleDown,
                              width: 15,
                              height: 12,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Укажите фамилию',
                          style: TextStyle(color: Colors.white),
                        ),
                        primaryInput(
                          hint: 'Введите фамилию',
                          onSaved: (input) {
                            setState(() {
                              _surname = input!;
                              print('фамилия в onsaved: $_surname');
                            });
                          },
                          validateText: 'Введите фамилию',
                          prefix: Container(
                            transform:
                                Matrix4.translationValues(-10.0, 0.0, 0.0),
                            child: SvgPicture.asset(
                              'assets/svg/profile.svg',
                              fit: BoxFit.scaleDown,
                              width: 15,
                              height: 12,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Укажите номер телефона без 8 или +7',
                          style: TextStyle(color: Colors.white),
                        ),
                        primaryInput(
                          inputFormatters: [maskFormatter],
                          textInputType: TextInputType.number,
                          hint: '+7 (XXX) XXX-XX-XX',
                          onSaved: (input) {
                            setState(() {
                              _phone = input!;
                              print('телефон в onsaved: $_name');
                            });
                          },
                          validateText: 'Введите номер телефона',
                          prefix: Container(
                            transform:
                                Matrix4.translationValues(-10.0, 0.0, 0.0),
                            child: SvgPicture.asset(
                              'assets/svg/profile.svg',
                              fit: BoxFit.scaleDown,
                              width: 15,
                              height: 12,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Укажите город',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        primaryInput(
                          enabled: true,
                          error: cityError,
                          controller: _city,
                          onSaved: (input) {
                            setState(() {
                              city = input!;
                              print('Город в onsaved: $city');
                            });
                          },
                          validateText: 'Город не выбран',
                          hint: 'Введите город',
                          //city == null ? 'Введите город' : city,
                          prefix: Container(
                            transform:
                                Matrix4.translationValues(-10.0, 0.0, 0.0),
                            child: SvgPicture.asset(
                              'assets/svg/city.svg',
                              fit: BoxFit.scaleDown,
                              width: 15,
                              height: 12,
                            ),
                          ),
                        ),

                        //Text('Выберите город', style: validateText),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Укажите возраст',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              _currentSliderValue.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          height: 10,
                          child: SliderTheme(
                            data: SliderThemeData(
                              activeTrackColor:
                                  Color.fromRGBO(197, 206, 224, 1),
                              inactiveTrackColor:
                                  Color.fromRGBO(197, 206, 224, 1),
                              thumbColor: ColorConfig.primaryColor,
                              trackHeight: 1,
                              overlappingShapeStrokeColor: Colors.red,
                              thumbShape: RoundSliderThumbShape(
                                enabledThumbRadius: 10,
                              ),
                            ),
                            child: Slider(
                              value: _currentSliderValue.roundToDouble(),
                              min: 18,
                              max: 99,
                              focusNode: FocusNode(),
                              onChangeEnd: (value) {
                                print(value);
                              },
                              onChanged: (double value) {
                                print(value);
                                setState(() {
                                  _currentSliderValue = value.ceil();
                                  age.text = value.ceil().toString();
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 38,
                        ),
                        Text('Выберите пол',
                            style: TextStyle(color: Colors.white)),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            _buildMan(),
                            _buildWoman(),
                          ],
                        ),
                        SizedBox(
                          height: 26,
                        ),
                        Text.rich(TextSpan(
                            text:
                                'Регистрируясь" вы подтверждаете согласие с  ',
                            style: TextStyle(fontSize: 16, color: Colors.white),
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
                                      _launchURL(AGREEMENT);
                                    }),
                              TextSpan(
                                  text: ' и ',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Политикой конфиденциальности',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.purpleAccent[700],
                                            decoration:
                                                TextDecoration.underline),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            _launchURL(POLITICIANS);
                                          })
                                  ])
                            ])),
                        SizedBox(
                          height: 25.0,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              color: Color.fromARGB(255, 249, 22, 112),
                            ),
                            margin: EdgeInsets.only(top: 20),
                            height: 56,
                            width: MediaQuery.of(context).size.width,
                            child: TextButton(
                                onPressed: () {
                                  _validateSaveUserInfo();
                                },
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Container(),
                                      ),
                                      Text('Создать профиль',
                                          style: TextStyle(color: Colors.white))
                                    ],
                                  ),
                                ))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildMan() {
    return Row(
      children: [
        Container(
          width: 18,
          height: 28,
          margin: EdgeInsets.only(
            left: 43,
          ),
          child: Radio(
            activeColor: ColorConfig.primaryColor,
            fillColor: MaterialStateColor.resolveWith(
                (states) => ColorConfig.primaryColor),
            groupValue: _gender,
            value: Gender.man.index,
            onChanged: (int? value) {
              setState(() {
                _gender = value!;
                print("Пол: $_gender");
              });
            },
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          child: Text(
            'Мужчина',
            style: TextStyle(color: Colors.white).copyWith(fontSize: 16),
          ),
        )
      ],
    );
  }

  Row _buildWoman() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 18,
          height: 28,
          margin: EdgeInsets.only(
            left: 43,
          ),
          child: Radio(
            activeColor: ColorConfig.primaryColor,
            fillColor: MaterialStateColor.resolveWith(
                (states) => ColorConfig.primaryColor),
            groupValue: _gender,
            value: Gender.woman.index,
            onChanged: (int? value) {
              setState(() {
                _gender = value!;
                print("Пол: $_gender");
              });
            },
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
            child: Text(
          'Девушка',
          style: TextStyle(color: Colors.white).copyWith(fontSize: 16),
        ))
      ],
    );
  }
}

import 'dart:developer';
import 'dart:io';

import 'package:e_commerse/services/global_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import '../../consts/colors.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/SignUpScreen';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  bool _obscureText = true;
  String _emailAddress = '';
  String _password = '';
  String _fullName = '';
  int? _phoneNumber;
  File? _pickedImage;
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  GlobalMethods _globalMethods = GlobalMethods();

  void _submitForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      try {
        await _auth.createUserWithEmailAndPassword(
            email: _emailAddress.toLowerCase().trim(),
            password: _password.trim());
      } on FirebaseException catch (error) {
        _globalMethods.authErrorHandle(error.message.toString(), context);
        print(error);
      }
    }
  }

  void _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
  }

  void _removeImage() {
    setState(() {
      _pickedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.95,
            child: RotatedBox(
              quarterTurns: 2,
              child: WaveWidget(
                config: CustomConfig(
                  gradients: [
                    [ColorsConsts.gradiendFStart, ColorsConsts.gradiendLStart],
                    [ColorsConsts.gradiendFEnd, ColorsConsts.gradiendLEnd],
                  ],
                  durations: [19440, 10800],
                  heightPercentages: [0.20, 0.25],
                  blur: MaskFilter.blur(BlurStyle.solid, 10),
                  gradientBegin: Alignment.bottomLeft,
                  gradientEnd: Alignment.topRight,
                ),
                waveAmplitude: 0,
                size: Size(
                  double.infinity,
                  double.infinity,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 30),
                    child: CircleAvatar(
                      backgroundColor: ColorsConsts.gradiendLEnd,
                      radius: 70,
                      child: CircleAvatar(
                        backgroundColor: ColorsConsts.gradiendFEnd,
                        radius: 65,
                        backgroundImage: _pickedImage == null
                            ? null
                            : FileImage(_pickedImage!),
                      ),
                    ),
                  ),
                  Positioned(
                    child: RawMaterialButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text(
                              'Choose option',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: ColorsConsts.gradiendLStart,
                              ),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _pickImage(ImageSource.camera);
                                    Navigator.of(context).pop();
                                  },
                                  splashColor: Colors.purpleAccent,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.camera,
                                          color: Colors.purpleAccent,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Camera',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: ColorsConsts.title,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _pickImage(ImageSource.gallery);
                                    Navigator.of(context).pop();
                                  },
                                  splashColor: Colors.purpleAccent,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.image,
                                          color: Colors.purpleAccent,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Gallery',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: ColorsConsts.title,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _removeImage();
                                    Navigator.of(context).pop();
                                  },
                                  splashColor: Colors.purpleAccent,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.remove_circle,
                                            color: Colors.red),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Remove',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.red,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      fillColor: ColorsConsts.gradiendLEnd,
                      child: Icon(Icons.add_a_photo),
                      padding: const EdgeInsets.all(15),
                      shape: CircleBorder(),
                    ),
                    top: 110,
                    left: 110,
                  )
                ]),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            key: ValueKey('name'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'name cannot be null';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_emailFocusNode),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                filled: true,
                                prefixIcon: Icon(Icons.person),
                                labelText: 'Full name',
                                fillColor: Theme.of(context).backgroundColor),
                            onSaved: (value) {
                              _fullName = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            key: ValueKey('email'),
                            focusNode: _emailFocusNode,
                            validator: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_passwordFocusNode),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                filled: true,
                                prefixIcon: Icon(Icons.email),
                                labelText: 'Email Address',
                                fillColor: Theme.of(context).backgroundColor),
                            onSaved: (value) {
                              _emailAddress = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            key: ValueKey('Password'),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 7) {
                                return 'Please enter a valid Password';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            focusNode: _passwordFocusNode,
                            decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                filled: true,
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: Icon(_obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                                labelText: 'Password',
                                fillColor: Theme.of(context).backgroundColor),
                            onSaved: (value) {
                              _password = value!;
                            },
                            obscureText: _obscureText,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_phoneNumberFocusNode),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            key: ValueKey('phone number'),
                            focusNode: _phoneNumberFocusNode,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a valid phone number';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            onEditingComplete: _submitForm,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                filled: true,
                                prefixIcon: Icon(Icons.phone_android),
                                labelText: 'Phone number',
                                fillColor: Theme.of(context).backgroundColor),
                            onSaved: (value) {
                              _phoneNumber = int.parse(value!);
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 10),
                            ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: BorderSide(
                                        color: ColorsConsts.backgroundColor),
                                  ),
                                )),
                                onPressed: _submitForm,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Sign up',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.person,
                                      size: 18,
                                    )
                                  ],
                                )),
                            SizedBox(width: 20),
                          ],
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

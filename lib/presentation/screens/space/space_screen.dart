// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rootscards/config/colors.dart';
import 'package:rootscards/extensions/build_context.dart';
import 'package:rootscards/presentation/screens/widgets/get_started_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sizer/sizer.dart';

class SpaceScreen extends StatefulWidget {
  static const String routeName = "space_screen";
  const SpaceScreen({super.key});

  @override
  State<SpaceScreen> createState() => _SpaceScreenState();
}

class _SpaceScreenState extends State<SpaceScreen> {
  final TextEditingController _spaceNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// ignore: prefer_final_fields
  bool _busy = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "Start",
                  style: context.textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                    fontSize: 45,
                  ),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                const Text(
                  "We need you to create your space",
                ),
                Form(
                  key: _formKey,
                  child: AutofillGroup(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 0.5.h,
                        ),
                        TextFormField(
                          onFieldSubmitted: (_) => _createSpace(
                            _spaceNameController.text.trim(),
                          ),
                          keyboardType: TextInputType.text,
                          controller: _spaceNameController,
                          textInputAction: TextInputAction.go,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please provide a space name";
                            }
                            return null;
                          },
                          style: const TextStyle(),
                          autofillHints: const [AutofillHints.email],
                          decoration: InputDecoration(
                            prefixIcon:
                                Image.asset("assets/images/message-icon.png"),
                            hintText: "enter your space name",
                            hintStyle: const TextStyle(color: Colors.black26),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(7),
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  7,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.56,
                        ),
                        GetStartedButton(
                          onTap: () {
                            if(_formKey.currentState!.validate()){
                              _createSpace(_spaceNameController.text.trim());
                            debugPrint(_spaceNameController.text.trim());
                            setState(() {
                              _busy = !_busy;
                            });
                            }
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 95,
                        ),
                        const Text(
                          "\nrootcards.com",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )
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

  Future<void> _createSpace(String spaceName) async {
    if (_busy) return;
    setState(() => _busy = true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? bearerToken = prefs.getString('authid');

    if (bearerToken == null) {
      debugPrint('Bearer token not found in shared preferences');
      return;
    }

    String apiUrl = 'https://api.idonland.com/rootscard/index';

    Map<String, String> requestBody = {
      'spaceName': spaceName,
    };

    try {
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $bearerToken',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: json.encode(requestBody),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        String status = responseData["status"];
        if (status == "200") {
          debugPrint('Space Created Successful: $responseData');
          String authid = responseData['data']['authid'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('authid', authid);
          ScaffoldMessenger.of(context).showMaterialBanner(
            MaterialBanner(
              backgroundColor: Colors.white,
              shadowColor: Colors.green,
              elevation: 2,
              leading: Icon(
                Icons.check,
                color: Colors.green,
              ),
              content: RichText(
                text: TextSpan(
                  text: "Successful",
                 style: TextStyle(
                      color: BLACK,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                  children: const [
                    TextSpan(
                      text: "\nwe sent next steps to your email",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.normal,
                          fontSize: 11),
                    ),
                  ],
                ),
              ),
              actions: const [
                Icon(
                  Icons.close,
                ),
              ],
            ),
          );
          Future.delayed(Duration(seconds: 3), () {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          });
          setState(() => _busy = false);
        }
        debugPrint('Space Creation Failed: $responseData');
        String errorMessage = responseData['data']['message'];
        ScaffoldMessenger.of(context).showMaterialBanner(
          MaterialBanner(
            backgroundColor: Colors.white,
            shadowColor: Colors.red,
            elevation: 2,
            leading: Icon(
              Icons.error,
              color: Colors.red,
            ),
            content: Text(errorMessage),
            actions: const [
              Icon(
                Icons.close,
              ),
            ],
          ),
        );
        Future.delayed(Duration(seconds: 3), () {
          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
        });
        setState(() => _busy = false);
      } else {
        ScaffoldMessenger.of(context).showMaterialBanner(
          MaterialBanner(
            backgroundColor: Colors.white,
            shadowColor: Colors.red,
            elevation: 2,
            leading: Icon(
              Icons.error,
              color: Colors.red,
            ),
            content: Text("Something went wrong"),
            actions: const [
              Icon(
                Icons.close,
              ),
            ],
          ),
        );
        Future.delayed(Duration(seconds: 3), () {
          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
        });

        debugPrint(
            'Authentication failed. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          backgroundColor: Colors.white,
          shadowColor: Colors.red,
          elevation: 2,
          leading: Icon(
            Icons.error,
            color: Colors.red,
          ),
          content: Text("Failed to authenticate"),
          actions: const [
            Icon(
              Icons.close,
            ),
          ],
        ),
      );
      Future.delayed(Duration(seconds: 3), () {
        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
      });

      debugPrint('Failed to authenticate: $e');
    }
  }
}

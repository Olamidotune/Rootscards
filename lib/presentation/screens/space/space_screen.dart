import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
                          onFieldSubmitted: (_) =>
                              _createSpace(_spaceNameController.text),
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
                            _createSpace(_spaceNameController.text);
                            setState(() {
                              _busy = !_busy;
                            });
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
      'spaceName': _spaceNameController.text.trim(),
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
        // Authentication successful
        Map<String, dynamic> responseData = json.decode(response.body);
        debugPrint('Authentication successful: $responseData');
        // Perform further actions as needed
      } else {
        // Authentication failed
        debugPrint(
            'Authentication failed. Status Code: ${response.statusCode}');
        // Handle authentication failure
      }
    } catch (e) {
      debugPrint('Failed to authenticate: $e');
      // Handle exceptions
    }
  }
}

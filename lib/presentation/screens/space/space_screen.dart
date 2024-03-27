import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:rootscards/extensions/build_context.dart';
import 'package:rootscards/presentation/screens/widgets/get_started_button.dart';

import 'package:sizer/sizer.dart';

class SpaceScreen extends StatefulWidget {
  static const String routeName = "space_screen";
  const SpaceScreen({super.key});

  @override
  State<SpaceScreen> createState() => _SpaceScreenState();
}

class _SpaceScreenState extends State<SpaceScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// ignore: prefer_final_fields
  // bool _busy = false;

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
                SizedBox(
                  height: 4.h,
                ),
                Form(
                  key: _formKey,
                  child: AutofillGroup(
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text("Email"),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (EmailValidator.validate(value?.trim() ?? "")) {
                              return null;
                            }
                            return "Please provide a valid email address";
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
                          SizedBox(height: MediaQuery.of(context).size.height /2,),
                        GetStartedButton(),
                        SizedBox(height: MediaQuery.of(context).size.height /95,),
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
}

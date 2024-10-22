// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rootscards/blocs/otp/otp_bloc.dart';
import 'package:rootscards/config/colors.dart';
import 'package:rootscards/config/dimensions.dart';
import 'package:rootscards/helper/helper_function.dart';
import 'package:rootscards/src/presentation/screens/interests/interest.dart';
import 'package:rootscards/src/shared/widgets/custom_snackbar.dart';
import 'package:rootscards/src/shared/widgets/button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpScreen extends StatefulWidget {
  static const String routeName = "sign_in_auth_screen";

  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _busy = false;
  String? email;

  @override
  void initState() {
    super.initState();
    _getEmail();
  }

  @override
  Widget build(BuildContext context) {
    final double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
            ),
          ),
          title: Text(
            "OTP",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.info_outline),
            ),
          ]),
      body: BlocListener<OtpAuthBloc, OtpAuthState>(
        listener: (context, state) {
          if (state is OtpLoadingState) {
            setState(() => _busy = true);
          } else {
            setState(() => _busy = false);
          }
          if (state is OtpFailedState) {
            CustomSnackbar.show(context, state.message, isError: true);
          }
          if (state is OtpErrorState) {
            CustomSnackbar.show(context, state.errorMessage, isError: true);
          }

          if (state is DeviceAuthenticationSuccess) {
            CustomSnackbar.show(context, "OTP Verified", isError: false);
            Navigator.of(context).popAndPushNamed(InterestScreen.routeName);
          }
        },
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: SafeArea(
            child: Container(
              height: height,
              padding: EdgeInsets.only(
                top: .01.sh,
                left: 20,
                right: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSpacing.verticalSpaceMedium,
                  Text(
                    "Enter Confirmation Code",
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontFamily: "DarkerGrotesque", fontSize: 28.sp),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                  AppSpacing.verticalSpaceSmall,
                  Text("Enter the 4-digit OTP code we've just sent to",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.grey,
                          )),
                  Text(email ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold)),
                  AppSpacing.verticalSpaceHuge,
                  Center(
                    child: PinCodeTextField(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      appContext: context,
                      length: 4,
                      controller: _otpController,
                      dialogConfig: DialogConfig(
                        dialogTitle: 'Enter OTP',
                        dialogContent: 'Enter the code sent to your email',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                      animationType: AnimationType.fade,
                      onCompleted: (otpValue) {
                        if (!_busy) {
                          context.read<OtpAuthBloc>().add(
                              DeviceAuthenticationRequested(
                                  _otpController.text));
                        }
                        debugPrint('Entered OTP: $otpValue');
                      },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(50, 60)),
                        fieldHeight: 50,
                        fieldWidth: 70,
                        activeFillColor: BLACK,
                        inactiveFillColor: GREY.withOpacity(0.1),
                        selectedFillColor: BLACK,
                        activeColor: BLACK,
                        inactiveColor: GREY,
                        selectedColor: BLACK,
                      ),
                    ),
                  ),
                  AppSpacing.verticalSpaceMedium,
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Didn't receive OTP?",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.grey,
                            ),
                        children: [
                          TextSpan(
                              text: " Resend",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: .4.sh,
                  ),
                  Button(
                      busy: _busy,
                      pill: true,
                      disabledTextColor: Colors.black,
                      "Confirm",
                      onPressed: _busy
                          ? null
                          : () {
                              context.read<OtpAuthBloc>().add(
                                  DeviceAuthenticationRequested(
                                      _otpController.text));
                            }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _getEmail() async {
    String? savedEmail = await HelperFunction.getUserEmailfromSF();
    setState(() {
      email = savedEmail;
    });
  }
}

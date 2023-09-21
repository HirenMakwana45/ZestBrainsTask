import 'package:country_code_picker/country_code_picker.dart';
import 'package:fino_wise/Api/Signin_api.dart';
import 'package:fino_wise/Core/Utils/image_constant.dart';
import 'package:fino_wise/Model/Login_model.dart';
import 'package:fino_wise/Persistence/Dashboard_screen.dart';
import 'package:fino_wise/Widgets/custom_imageview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginModel? _loginModel;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

// Function For Google Signin

  Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential authResult =
            await _auth.signInWithCredential(credential);
        final User? user = authResult.user;

        if (user != null) {
          // Check if user is new or existing
          assert(!user.isAnonymous);
          assert(await user.getIdToken() != null);

          final User currentUser = _auth.currentUser!;
          assert(user.uid == currentUser.uid);

          Fluttertoast.showToast(
            msg: 'Google Login Successfully',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xff00C8BC),
            textColor: Colors.white,
            fontSize: 16.0,
          );

          print('Google Sign-In succeeded: $user');

          return '$user';
        }
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'Google Login Failed',
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print(error);
      return null;
    }
  }

  String phoneNumber = "";
  String countryCode = "";
  String message = "";
  String Otpcount = "";

  String token = "";

  void tokenpreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool("isLogin", true);
      prefs.setString('logintoken', token).toString();
    });
  }

  //Otp Dialog
  _showOtpDialog(BuildContext context) {
    TextEditingController _otpController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter OTP'),
          content: PinCodeTextField(
            keyboardType: TextInputType.phone,
            appContext: context,
            length: 4,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.underline,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
            ),
            animationDuration: Duration(milliseconds: 300),
            controller: _otpController,
            onCompleted: (v) {
              print("Completed: $v");

              setState(() {
                Otpcount = v;
                print("Otp Is ==>" + v);
              });
              setState(() {
                print("Value Phone" + phoneNumber);
                print("Value Country Code" + countryCode);

                SigninApi()
                    .apiSignin(
                        Country_Code: countryCode,
                        Mobile_No: phoneNumber,
                        Otp: Otpcount,
                        Deviceid: "109915461646451231916",
                        Device_Type: "android")
                    .then((value) {
                  setState(() {
                    _loginModel = value;
                    print("--- Login Api Calling ---");
                    print(_loginModel);

                    token = _loginModel!.data!.token.toString();
                    message = _loginModel!.message.toString();

                    if (message == "Login successfully") {
                      setState(() {
                        tokenpreference();
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: const DashboardScreen()));
                      });
                    } else {
                      Fluttertoast.showToast(
                        msg: 'Something Went Wrong',
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Color(0xff00C8BC),
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }

                    print("The Token Is " + token);
                  });
                });
              });
            },
            onChanged: (value) {
              print(value);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xff00C8BC),
      body: Column(children: [
        Container(
          height: h * 0.35,
          decoration: const BoxDecoration(color: Color(0xff00C8BC)),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            CustomImageView(
              margin: EdgeInsets.only(top: h * 0.03),
              imagePath: ImageConstant.icsplashlogo,
              scale: 4,
            )
          ]),
        ),
        // Container(
        //   margin: EdgeInsets.only(bottom: h * 0.007),
        //   height: h * 0.03,
        //   width: double.infinity,
        //   decoration: BoxDecoration(
        //       color: Color.fromARGB(255, 223, 255, 253),
        //       borderRadius: BorderRadius.only(
        //           topLeft: Radius.circular(30),
        //           topRight: Radius.circular(30))),
        // ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(children: [
                  Container(
                    margin: EdgeInsets.only(top: w * 0.06, left: w * 0.04),
                    child: Row(
                      children: [
                        Text(
                          "Mobile number",
                          style: TextStyle(
                              color: const Color(0xff171717).withOpacity(0.5),
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        )),
                        child: CountryCodePicker(
                          flagWidth: 20,
                          padding: const EdgeInsets.all(0),
                          showDropDownButton: true,
                          onChanged: (CountryCode code) {
                            setState(() {
                              countryCode = code.dialCode!;
                            });
                          },
                          initialSelection: 'IN',
                          favorite: const ['+91', 'IN'],
                          showCountryOnly: false,
                          showOnlyCountryWhenClosed: false,
                          alignLeft: false,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey, width: 1.0))),
                          child: TextFormField(
                            validator: (val) {
                              if (!validation(val!).isValidPhone) {
                                return ' Please Enter Mobile NO';
                              }
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                            ],
                            // maxLength: 10,
                            onChanged: (value) {
                              setState(() {
                                phoneNumber = value;
                              });
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: h * 0.03,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: const Color(0xff00C8BC)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _showOtpDialog(context);
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        height: h * 0.07,
                        width: w * 0.8,
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      )),
                  SizedBox(
                    height: h * 0.03,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: Divider(indent: 20, thickness: 1.0)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'With',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        ),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 1.0,
                        endIndent: 20,
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: const Color(0xffDC4E41)),
                      onPressed: () {
                        setState(() {
                          signInWithGoogle();
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        height: h * 0.07,
                        width: w * 0.8,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomImageView(
                              // alignment: Alignment.centerLeft,
                              svgPath: ImageConstant.icgoogle,
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: w * 0.07),
                                  child: const Text(
                                    "Google",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(
                              flex: 2,
                            )
                          ],
                        ),
                      )),
                ]),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

// Validation Class
extension validation on String {
  bool get isValidPhone {
    final phoneRegExp = RegExp(r"[0-9]{10}$");
    return phoneRegExp.hasMatch(this);
  }
}

import 'package:fino_wise/Core/Utils/image_constant.dart';
import 'package:fino_wise/Widgets/custom_imageview.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: h * 0.4,
              decoration: BoxDecoration(color: Color(0xff00C8BC)),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                CustomImageView(
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
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Container(
                margin: EdgeInsets.all(w * 0.02),
                child: Column(children: [
                  Container(
                    margin: EdgeInsets.only(top: w * 0.06),
                    child: Row(
                      children: [
                        Text(
                          "Mobile number",
                          style: TextStyle(
                              color: Color(0xff171717).withOpacity(0.5),
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Color(0xff00C8BC)),
                      onPressed: () {},
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        height: h * 0.07,
                        width: w * 0.8,
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Color(0xffDC4E41)),
                      onPressed: () {},
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        height: h * 0.07,
                        width: w * 0.8,
                        child: Row(
                          children: [
                            CustomImageView(),
                            Text(
                              "Google",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                          ],
                        ),
                      ))
                ]),
              ),
            )
          ],
        ),
      ]),
    );
  }
}

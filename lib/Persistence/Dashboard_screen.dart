import 'package:fino_wise/Core/Utils/image_constant.dart';
import 'package:fino_wise/Widgets/custom_imageview.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      // Appbar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Builder(builder: (context) {
          return ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)),
            child: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xff00C8BC),
              title: const Text(
                "Trade Recommendations",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
              actions: [
                Container(
                  margin: EdgeInsets.only(right: w * 0.05),
                  child: const Icon(
                    Icons.filter_list_outlined,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          );
        }),
      ),

      // Body
      body: Column(children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.only(
            left: w * 0.04,
            right: w * 0.04,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
              boxShadow: [
                const BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 5),
                  blurRadius: 6.0,
                )
              ]),
          child: Container(
            margin: EdgeInsets.only(top: w * 0.02, bottom: w * 0.02),

            // Tabbar
            child: TabBar(
              splashBorderRadius: BorderRadius.circular(50),
              splashFactory: NoSplash.splashFactory,
              dividerColor: Colors.transparent,
              controller: tabController,
              indicator: BoxDecoration(
                border: const Border(bottom: BorderSide.none),
                borderRadius: BorderRadius.circular(50),
                color: const Color(0xff00C8BC),
              ),
              labelColor: Colors.white,
              labelPadding: EdgeInsets.all(0),
              unselectedLabelColor: const Color(0xff545454),
              tabs: [
                Container(
                    margin: EdgeInsets.only(
                        left: w * 0.032,
                        right: w * 0.032,
                        top: w * 0.025,
                        bottom: w * 0.025),
                    child: const Text(
                      "Ongoing Trades",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                          fontSize: 13),
                    )),
                Container(
                    margin: EdgeInsets.only(
                        left: w * 0.032,
                        right: w * 0.032,
                        top: w * 0.025,
                        bottom: w * 0.025),
                    child: const Text(
                      "Expire Trades",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                          fontSize: 13),
                    )),
              ],
            ),
          ),
        ),
        Expanded(
          child: TabBarView(controller: tabController, children: [
            // OnGoing Trades Tab
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextFormField(
                    // onChanged: (value) => _runFilter(value),

                    cursorColor: const Color.fromARGB(255, 0, 0, 0),
                    // cursorHeight: 18,
                    style: const TextStyle(
                        color: Color(0XFF212121),
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                    decoration: InputDecoration(
                      counterStyle: const TextStyle(color: Color(0XFFFFFFFF)),
                      suffixIcon: CustomImageView(
                        svgPath: ImageConstant.icsearch,
                        color: const Color(0XFF9E9E9E),
                        fit: BoxFit.none,
                      ),
                      hintText: 'Search by stock or mentor name',
                      hintStyle: const TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Color(0XFF9E9E9E),
                      ),
                      fillColor: const Color(0XFFF6F6F6),
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 255, 255, 255)),
                        borderRadius: BorderRadius.circular(13.0),
                      ),
                      isDense: true,
                    ),
                  ),
                  SizedBox(
                    height: h * 0.016,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Color(0xff00C8BC),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  left: w * 0.06,
                                  top: h * 0.014,
                                  bottom: h * 0.014,
                                ),
                                child: const Text(
                                  "data",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                "25-5-2022",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                              ),
                              CustomImageView(
                                margin: EdgeInsets.only(
                                    right: w * 0.04, left: w * 0.03),
                                svgPath: ImageConstant.icrightarrow,
                              )
                            ],
                          )
                        ]),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 206, 206, 206)
                                .withOpacity(
                                    0.8), // Semi-transparent black color

                            offset: const Offset(4, 4),
                            blurRadius: 24.0,

                            spreadRadius: 1.0,
                          ),
                        ],
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8))),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: w * 0.2),
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 16),
                          child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Type:",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "Inter",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "Entry:",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "Inter",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "Exit:",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "Inter",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                )
                              ]),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: w * 0.03),
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Equity:",
                                  style: TextStyle(
                                      color: Color(0xff000000),
                                      fontFamily: "Inter",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: w * 0.12),
                                  child: const Text(
                                    "₹ " + "150",
                                    style: TextStyle(
                                        color: Color(0xff000000),
                                        fontFamily: "Inter",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: w * 0.15),
                                  child: const Text(
                                    "₹ " + "350 - " + "₹ " + "550",
                                    style: TextStyle(
                                        color: Color(0xff000000),
                                        fontFamily: "Inter",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ]),
                        ),
                        SizedBox(
                          height: h * 0.016,
                        ),
                        Container(
                          margin: EdgeInsets.only(right: w * 0.14),
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Stop Loss:",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "Inter",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: w * 0.09),
                                  child: const Text(
                                    "Stock Name:",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "Inter",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: w * 0.067),
                                  child: const Text(
                                    "Action:",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "Inter",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ]),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: w * 0.04),
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "₹ " + "250",
                                  style: TextStyle(
                                      color: Color(0xff000000),
                                      fontFamily: "Inter",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: w * 0.16),
                                  child: const Text(
                                    "Relience",
                                    style: TextStyle(
                                        color: Color(0xff000000),
                                        fontFamily: "Inter",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: w * 0.11),
                                  child: const Text(
                                    "Buy",
                                    style: TextStyle(
                                        color: Color(0xff000000),
                                        fontFamily: "Inter",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ]),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: w * 0.14),
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 16),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Status:",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "Inter",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: w * 0.147),
                                  child: const Text(
                                    "Posted by:",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "Inter",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ]),
                        ),
                        SizedBox(
                          height: h * 0.005,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: w * 0.14, bottom: w * 0.04),
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: const Color.fromARGB(
                                          255, 209, 236, 234)),
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: w * 0.04,
                                        right: w * 0.04,
                                        top: w * 0.005,
                                        bottom: w * 0.005),
                                    child: const Text(
                                      "Open",
                                      style: TextStyle(
                                          color: Color(0xff00C8BC),
                                          fontFamily: "Inter",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: const Color.fromARGB(
                                          255, 209, 236, 234)),
                                  margin: EdgeInsets.only(left: w * 0.1),
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: w * 0.04,
                                        right: w * 0.04,
                                        top: w * 0.005,
                                        bottom: w * 0.005),
                                    child: const Text(
                                      "James S. Lawson",
                                      style: TextStyle(
                                          color: Color(0xff00C8BC),
                                          fontFamily: "Inter",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ]),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Expired Trades Tab
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextFormField(
                    // onChanged: (value) => _runFilter(value),

                    cursorColor: const Color.fromARGB(255, 0, 0, 0),
                    // cursorHeight: 18,
                    style: const TextStyle(
                        color: Color(0XFF212121),
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                    decoration: InputDecoration(
                      counterStyle: const TextStyle(color: Color(0XFFFFFFFF)),
                      suffixIcon: CustomImageView(
                        svgPath: ImageConstant.icsearch,
                        color: const Color(0XFF9E9E9E),
                        fit: BoxFit.none,
                      ),
                      hintText: 'Search by stock or mentor name',
                      hintStyle: const TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Color(0XFF9E9E9E),
                      ),
                      fillColor: const Color(0XFFF6F6F6),
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 255, 255, 255)),
                        borderRadius: BorderRadius.circular(13.0),
                      ),
                      isDense: true,
                    ),
                  ),
                  SizedBox(
                    height: h * 0.016,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Color(0xff00C8BC),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  left: w * 0.06,
                                  top: h * 0.014,
                                  bottom: h * 0.014,
                                ),
                                child: const Text(
                                  "data",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                "25-5-2022",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                              ),
                              CustomImageView(
                                margin: EdgeInsets.only(
                                    right: w * 0.04, left: w * 0.03),
                                svgPath: ImageConstant.icrightarrow,
                              )
                            ],
                          )
                        ]),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 206, 206, 206)
                                .withOpacity(
                                    0.8), // Semi-transparent black color

                            offset: const Offset(4, 4),
                            blurRadius: 24.0,

                            spreadRadius: 1.0,
                          ),
                        ],
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8))),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: w * 0.2),
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 16),
                          child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Type:",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "Inter",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "Entry:",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "Inter",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "Exit:",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "Inter",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                )
                              ]),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: w * 0.03),
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Equity:",
                                  style: TextStyle(
                                      color: Color(0xff000000),
                                      fontFamily: "Inter",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: w * 0.12),
                                  child: const Text(
                                    "₹ " + "150",
                                    style: TextStyle(
                                        color: Color(0xff000000),
                                        fontFamily: "Inter",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: w * 0.15),
                                  child: const Text(
                                    "₹ " + "350 - " + "₹ " + "550",
                                    style: TextStyle(
                                        color: Color(0xff000000),
                                        fontFamily: "Inter",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ]),
                        ),
                        SizedBox(
                          height: h * 0.016,
                        ),
                        Container(
                          margin: EdgeInsets.only(right: w * 0.14),
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Stop Loss:",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "Inter",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: w * 0.09),
                                  child: const Text(
                                    "Stock Name:",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "Inter",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: w * 0.067),
                                  child: const Text(
                                    "Action:",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "Inter",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ]),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: w * 0.04),
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "₹ " + "250",
                                  style: TextStyle(
                                      color: Color(0xff000000),
                                      fontFamily: "Inter",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: w * 0.16),
                                  child: const Text(
                                    "Relience",
                                    style: TextStyle(
                                        color: Color(0xff000000),
                                        fontFamily: "Inter",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: w * 0.11),
                                  child: const Text(
                                    "Buy",
                                    style: TextStyle(
                                        color: Color(0xff000000),
                                        fontFamily: "Inter",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ]),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: w * 0.14),
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 16),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Status:",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "Inter",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: w * 0.147),
                                  child: const Text(
                                    "Posted by:",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "Inter",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ]),
                        ),
                        SizedBox(
                          height: h * 0.005,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: w * 0.14, bottom: w * 0.04),
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: const Color.fromARGB(
                                          255, 209, 236, 234)),
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: w * 0.04,
                                        right: w * 0.04,
                                        top: w * 0.005,
                                        bottom: w * 0.005),
                                    child: const Text(
                                      "Open",
                                      style: TextStyle(
                                          color: Color(0xff00C8BC),
                                          fontFamily: "Inter",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: const Color.fromARGB(
                                          255, 209, 236, 234)),
                                  margin: EdgeInsets.only(left: w * 0.1),
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: w * 0.04,
                                        right: w * 0.04,
                                        top: w * 0.005,
                                        bottom: w * 0.005),
                                    child: const Text(
                                      "James S. Lawson",
                                      style: TextStyle(
                                          color: Color(0xff00C8BC),
                                          fontFamily: "Inter",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ]),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ]),
        )
      ]),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}

import 'package:fino_wise/Api/Tradelist_api.dart';
import 'package:fino_wise/Core/Utils/image_constant.dart';
import 'package:fino_wise/Model/Tradelist_model.dart';
import 'package:fino_wise/Widgets/custom_imageview.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  TradeListModel? _tradeListModel;
  bool _isDataAvailable = true;
  List<Userdata> _allUsers = [];
  List<Userdata> _foundUsers = [];

  String Filtertrade = "ongoing";
  String Token = "";
// 91 06 94 69 53
  @override
  void initState() {
    tokenpreference();
    setState(() {
      Future.delayed(
        const Duration(milliseconds: 500),
        () {
          TradeAPI();
        },
      );
    });
    tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  // Search Filter

  void _runFilter(String enteredKeyword) {
    List<Userdata> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user.name!.toLowerCase().contains(enteredKeyword.toLowerCase()) ||
              user.action!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              user.stock!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              user.status!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              user.user!.name!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              user.type!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();

      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      print("FOUND??" + _foundUsers.toString());
      _foundUsers = results;
    });
  }

  int getItemCount() {
    return _foundUsers.isNotEmpty
        ? _foundUsers.length
        : _tradeListModel!.data!.length;
  }

  // Local Get Data
  void tokenpreference() async {
    print("1");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      Token = prefs.getString('logintoken').toString();

      print("Yes Token Received $Token");
    });
  }

  // Trading List Api
  TradeAPI() {
    setState(() {
      print("2");
      TradeListApi()
          .apiTradlist(
              Filters: Filtertrade,
              Limit: "",
              Offset: "",
              bearerToken: Token.toString())
          .then((value) {
        setState(() {
          _tradeListModel = value;

          _isDataAvailable = false;
          _allUsers = _tradeListModel!.data!;

          _foundUsers = _allUsers;

          print("--- TradeList Api Calling ---");
        });
      });
    });
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
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 5),
                  blurRadius: 6.0,
                )
              ]),
          child: Container(
            margin: EdgeInsets.only(top: w * 0.02, bottom: w * 0.02),

            // Tabbar
            child: TabBar(
              physics: NeverScrollableScrollPhysics(),
              onTap: (value) {
                print(value);

                setState(() {
                  if (value == 0) {
                    Filtertrade = "ongoing";
                  } else {
                    Filtertrade = "expired";
                  }

                  print("Filter Is ==>" + Filtertrade);
                  TradeAPI();
                });
              },
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
              labelPadding: const EdgeInsets.all(0),
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
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
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
                    _isDataAvailable
                        ? Center(
                            heightFactor: h * 0.02,
                            child: const CircularProgressIndicator.adaptive(
                              backgroundColor: Color(0xff00C8BC),
                              // valueColor: Colors.white,
                            ),
                          )
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: _tradeListModel!.data!.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        color: Color(0xff00C8BC),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8))),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                  left: w * 0.04,
                                                  top: h * 0.014,
                                                  bottom: h * 0.014,
                                                ),
                                                child: Text(
                                                  _tradeListModel!
                                                      .data![index].name
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Poppins",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                _tradeListModel!
                                                    .data![index].postedDate!
                                                    .toString()
                                                    .split(" ")[0],
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12),
                                              ),
                                              CustomImageView(
                                                margin: EdgeInsets.only(
                                                    right: w * 0.04,
                                                    left: w * 0.02),
                                                svgPath:
                                                    ImageConstant.icrightarrow,
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
                                            color: const Color.fromARGB(
                                                    255, 206, 206, 206)
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
                                          margin:
                                              EdgeInsets.only(right: w * 0.2),
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16, top: 16),
                                          child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Type:",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily: "Inter",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  "Entry:",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily: "Inter",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  "Exit:",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily: "Inter",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ]),
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.only(right: w * 0.03),
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16),
                                          child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _tradeListModel!
                                                      .data![index].type!
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Color(0xff000000),
                                                      fontFamily: "Inter",
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: w * 0.12),
                                                  child: Text(
                                                    "₹ ${_tradeListModel!.data![index].entryPrice!}",
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xff000000),
                                                        fontFamily: "Inter",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: w * 0.15),
                                                  child: Text(
                                                    "₹ ${_tradeListModel!.data![index].exitPrice!} - ₹ ${_tradeListModel!.data![index].exitHigh!}",
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xff000000),
                                                        fontFamily: "Inter",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                )
                                              ]),
                                        ),
                                        SizedBox(
                                          height: h * 0.016,
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.only(right: w * 0.14),
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Stop Loss:",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily: "Inter",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: w * 0.09),
                                                  child: const Text(
                                                    "Stock Name:",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontFamily: "Inter",
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: w * 0.087),
                                                  child: const Text(
                                                    "Action:",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontFamily: "Inter",
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                )
                                              ]),
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.only(right: w * 0.04),
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16),
                                          child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "₹ ${_tradeListModel!.data![index].stopLossPrice!}",
                                                  style: const TextStyle(
                                                      color: Color(0xff000000),
                                                      fontFamily: "Inter",
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: w * 0.16),
                                                  child: Text(
                                                    _tradeListModel!
                                                        .data![index].stock!
                                                        .toString()
                                                        .split(" ")[0],
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xff000000),
                                                        fontFamily: "Inter",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: w * 0.13),
                                                  child: Text(
                                                    _tradeListModel!
                                                        .data![index].action!
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xff000000),
                                                        fontFamily: "Inter",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                )
                                              ]),
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.only(right: w * 0.14),
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16, top: 16),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Status:",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily: "Inter",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: w * 0.147),
                                                  child: const Text(
                                                    "Posted by:",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontFamily: "Inter",
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                        SizedBox(
                                          height: h * 0.005,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: w * 0.14,
                                              bottom: w * 0.04),
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              209,
                                                              236,
                                                              234)),
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: w * 0.04,
                                                        right: w * 0.04,
                                                        top: w * 0.005,
                                                        bottom: w * 0.005),
                                                    child: Text(
                                                      _tradeListModel!
                                                          .data![index].status
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0xff00C8BC),
                                                          fontFamily: "Inter",
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              209,
                                                              236,
                                                              234)),
                                                  margin: EdgeInsets.only(
                                                      left: w * 0.1),
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: w * 0.04,
                                                        right: w * 0.04,
                                                        top: w * 0.005,
                                                        bottom: w * 0.005),
                                                    child: Text(
                                                      _tradeListModel!
                                                          .data![index]
                                                          .user!
                                                          .name
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0xff00C8BC),
                                                          fontFamily: "Inter",
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          )
                  ],
                ),
              ),
            ),

            // Expired Trades Tab
            Container(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) => _runFilter(value),

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
                    _isDataAvailable
                        ? Center(
                            heightFactor: h * 0.02,
                            child: const CircularProgressIndicator.adaptive(
                              backgroundColor: Color(0xff00C8BC),
                              // valueColor: Colors.white,
                            ),
                          )
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: getItemCount(),
                            itemBuilder: (context, index) {
                              final result = _foundUsers.isNotEmpty
                                  ? _foundUsers[index]
                                  : Userdata(
                                      name: _tradeListModel!.data![index].name
                                          .toString(),
                                      action: _tradeListModel!
                                          .data![index].action
                                          .toString(),
                                      stock: _tradeListModel!.data![index].stock
                                          .toString(),
                                      status: _tradeListModel!
                                          .data![index].status
                                          .toString(),
                                      type: _tradeListModel!.data![index].type!
                                        ..toString());
                              return Column(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        color: Color(0xff00C8BC),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8))),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                  left: w * 0.04,
                                                  top: h * 0.014,
                                                  bottom: h * 0.014,
                                                ),
                                                child: Text(
                                                  softWrap: true,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.fade,
                                                  result.name.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Poppins",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 10),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                _tradeListModel!
                                                    .data![index].postedDate!
                                                    .toString()
                                                    .split(" ")[0],
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12),
                                              ),
                                              CustomImageView(
                                                margin: EdgeInsets.only(
                                                    right: w * 0.04,
                                                    left: w * 0.02),
                                                svgPath:
                                                    ImageConstant.icrightarrow,
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
                                            color: const Color.fromARGB(
                                                    255, 206, 206, 206)
                                                .withOpacity(
                                                    0.8), // Semi-transparent black color

                                            offset: const Offset(4, 4),
                                            blurRadius: 10.0,

                                            spreadRadius: 1.0,
                                          ),
                                        ],
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(8))),
                                    child: Column(
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.only(right: w * 0.2),
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16, top: 16),
                                          child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Type:",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily: "Inter",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  "Entry:",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily: "Inter",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  "Exit:",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily: "Inter",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ]),
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.only(right: w * 0.03),
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16),
                                          child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  result.type!.toString(),
                                                  style: const TextStyle(
                                                      color: Color(0xff000000),
                                                      fontFamily: "Inter",
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: w * 0.12),
                                                  child: Text(
                                                    "₹ ${_tradeListModel!.data![index].entryPrice!}",
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xff000000),
                                                        fontFamily: "Inter",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: w * 0.08),
                                                  child: Text(
                                                    "₹ ${_tradeListModel!.data![index].exitPrice!} - ₹ ${_tradeListModel!.data![index].exitHigh!}",
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xff000000),
                                                        fontFamily: "Inter",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                )
                                              ]),
                                        ),
                                        SizedBox(
                                          height: h * 0.016,
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.only(right: w * 0.14),
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Stop Loss:",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily: "Inter",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: w * 0.09),
                                                  child: const Text(
                                                    "Stock Name:",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontFamily: "Inter",
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: w * 0.087),
                                                  child: const Text(
                                                    "Action:",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontFamily: "Inter",
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                )
                                              ]),
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.only(right: w * 0.04),
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16),
                                          child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "₹ ${_tradeListModel!.data![index].stopLossPrice!}",
                                                  style: const TextStyle(
                                                      color: Color(0xff000000),
                                                      fontFamily: "Inter",
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: w * 0.16),
                                                  child: Text(
                                                    result.stock!
                                                        .toString()
                                                        .split(" ")[0],
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xff000000),
                                                        fontFamily: "Inter",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: w * 0.13),
                                                  child: Text(
                                                    result.action!.toString(),
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xff000000),
                                                        fontFamily: "Inter",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                )
                                              ]),
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.only(right: w * 0.14),
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16, top: 16),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Status:",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily: "Inter",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: w * 0.147),
                                                  child: const Text(
                                                    "Posted by:",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontFamily: "Inter",
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                        SizedBox(
                                          height: h * 0.005,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: w * 0.14,
                                              bottom: w * 0.04),
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              209,
                                                              236,
                                                              234)),
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: w * 0.04,
                                                        right: w * 0.04,
                                                        top: w * 0.005,
                                                        bottom: w * 0.005),
                                                    child: Text(
                                                      result.status.toString(),
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0xff00C8BC),
                                                          fontFamily: "Inter",
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              209,
                                                              236,
                                                              234)),
                                                  margin: EdgeInsets.only(
                                                      left: w * 0.1),
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: w * 0.04,
                                                        right: w * 0.04,
                                                        top: w * 0.005,
                                                        bottom: w * 0.005),
                                                    child: Text(
                                                      _tradeListModel!
                                                          .data![index]
                                                          .user!
                                                          .name
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0xff00C8BC),
                                                          fontFamily: "Inter",
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  )
                                ],
                              );
                            },
                          )
                  ],
                ),
              ),
            ),
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

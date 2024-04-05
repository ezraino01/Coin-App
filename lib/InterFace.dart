import 'package:cryptomania/UserModel.dart';
import 'package:cryptomania/tab_view/Market_view.dart';
import 'package:cryptomania/tab_view/Portfolio_view.dart';
import 'package:cryptomania/tab_view/Profile_view.dart';
import 'package:cryptomania/tab_view/Trade_view.dart';
import 'package:cryptomania/tab_view/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InterFace extends StatefulWidget {
final Users users;
  const InterFace({super.key, required this.users, });
  @override
  State<InterFace> createState() => _DepositAndWithdrawalState();
}

class _DepositAndWithdrawalState extends State<InterFace> {
  @override
  Widget build(BuildContext context) {
    double Height = MediaQuery.of(context).size.height;
    double Width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyanAccent,
        ),
        body: TabBarView(children: [
          HomeView(),
          Portfolio(),
          Reward(),
          Market(),
          Profile(users: widget.users,),
        ]),
        bottomSheet: const TabBar(tabs: [
          Tab(
            icon: Icon(Icons.home),
            text: 'Home',
          ),
          Tab(
            icon: Icon(Icons.pie_chart_rounded),
            text: 'Portfolio',
          ),
          Tab(
            icon: Icon(Icons.card_giftcard),
            text: 'Trade',
          ),
          Tab(
            icon: Icon(Icons.show_chart),
            text: 'Market',
          ),
          Tab(
            icon: Icon(Icons.person),
            text: 'Profile',
          ),
        ]),
      ),
    );
  }
}

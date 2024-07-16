import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Terms extends StatefulWidget {
  const Terms({super.key});

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {

  @override
  Widget build(BuildContext context) {
    final Height = MediaQuery.of(context).size.height;
    final Width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(onTap: (){
          Navigator.pop(context);
        },child: Icon(Icons.arrow_back_ios_new)),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms and Conditions\n'
                    'Thank you for using the Zraino Tech platform and\n'
                    'the products, services and features we make available\n'
                    'to you as part of the platform\n'
                    '(collectively, the “Service”).\n\n'
                    'Our Service The Service allows you to discover,\n'
                    'watch and share videos and other content, provides a forum\n'
                    'for people to connect, inform, and inspire others across the globe,\n'
                    'and acts as a distribution platform for\n'
                    'original content creators and advertisers large and small.\n'
                    'We provide lots of information about our products\n'
                    'and how to use them in our Help Center. Amongst other things,\n'
                    'you can find out about YouTube Kids, the YouTube\n'
                    'Partner Program and YouTube Paid Memberships and Purchases.\n'
                    'You can also read all about enjoying content on other\n'
                    'devices like your television, your games console, or even Google Home.',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

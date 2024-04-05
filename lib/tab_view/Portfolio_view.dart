import 'package:flutter/material.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({super.key});

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  @override
  Widget build(BuildContext context) {
    double Height=MediaQuery.of(context).size.height;
    double Width=MediaQuery.of(context).size.width;
    return Scaffold(
      body:  Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: Height * 0.26,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  onPressed: () {},
                  child: Container(
                    height: Height * 0.07,
                    width: Width * 0.36,
                    decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                          'Deposit NGN',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        )),
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  child: Container(
                    height: Height * 0.07,
                    width: Width * 0.36,
                    decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                          'Withdraw NGN',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

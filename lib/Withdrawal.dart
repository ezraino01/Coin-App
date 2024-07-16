

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Withdrawal extends StatefulWidget {
  const Withdrawal({super.key});

  @override
  State<Withdrawal> createState() => _DepositState();
}

class _DepositState extends State<Withdrawal> {
  String input = '';

  void addToInput(String number) {
    setState(() {
      input += number;
    });
  }

  void removeLastNumber() {
    setState(() {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: (){Navigator.pop(context);},
            child: Icon(Icons.arrow_back_ios_new)),
        title: Text('Withdraw NGN'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'enter emount NGN',
              style: TextStyle(color: Colors.black45),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              '\$${input}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Min \$100 - Max \$10,000',
              style: TextStyle(color: Colors.black45),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Current Balance: \$20,000',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      addToInput('1');
                    },
                    child: Text('1',style: TextStyle(fontSize: 25),)),
                TextButton(
                    onPressed: () {
                      addToInput('2');
                    },
                    child: Text('2',style: TextStyle(fontSize: 25),)),
                TextButton(
                    onPressed: () {
                      addToInput('3');
                    },
                    child: Text('3',style: TextStyle(fontSize: 25),)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      addToInput('4');
                    },
                    child: Text('4',style: TextStyle(fontSize: 25),)),
                TextButton(
                    onPressed: () {
                      addToInput('5');
                    },
                    child: Text('5',style: TextStyle(fontSize: 25),)),
                TextButton(
                    onPressed: () {
                      addToInput('6');
                    },
                    child: Text('6',style: TextStyle(fontSize: 25),)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      addToInput('7');
                    },
                    child: Text('7',style: TextStyle(fontSize: 25),)),
                TextButton(
                    onPressed: () {
                      addToInput('8');
                    },
                    child: Text('8',style: TextStyle(fontSize: 25),)),
                TextButton(
                    onPressed: () {
                      addToInput('9');
                    },
                    child: Text('9',style: TextStyle(fontSize: 25),)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      addToInput('.');
                    },
                    child: Text('.',style: TextStyle(fontSize: 25),)),
                TextButton(
                    onPressed: () {
                      addToInput('0');
                    },
                    child: Text('0',style: TextStyle(fontSize: 25),)),
                TextButton(
                    onPressed: () {
                      removeLastNumber();
                    },
                    child: Icon(Icons.backspace)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                onPressed: () {},
                child: Text(
                  'Withdraw NGN',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                color: Colors.green,
                minWidth: double.infinity,
                height: 50,
                shape: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

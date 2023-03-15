import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  dynamic displaytxt = 20;
  Widget calcbutton(String btntxt, Color btncolor, Color txtcolor){
    return Container(
      child: ElevatedButton(
          onPressed: (){
            calculation(btntxt);
          },
          child: Text('$btntxt',
            style: TextStyle(
              fontSize: 35,
              color: txtcolor,
            ),
          ),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          backgroundColor: btncolor,
          padding: EdgeInsets.all(20),
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Color(0xFFD782BA),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 5,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection:Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('$text',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xFFD782BA),
                        fontSize: 100,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('c', Colors.lightGreen, Colors.white),
                calcbutton('±', Colors.lightGreen, Colors.white),
                calcbutton('%', Colors.lightGreen, Colors.white),
                calcbutton('/', Colors.orange, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('7', Colors.lightGreen, Colors.black),
                calcbutton('8', Colors.lightGreen, Colors.black),
                calcbutton('9', Colors.lightGreen, Colors.black),
                calcbutton('x', Colors.orange, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('4', Colors.lightGreen, Colors.black),
                calcbutton('5', Colors.lightGreen, Colors.black),
                calcbutton('6', Colors.lightGreen, Colors.black),
                calcbutton('-', Colors.orange, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('1', Colors.lightGreen, Colors.black),
                calcbutton('2', Colors.lightGreen, Colors.black),
                calcbutton('3', Colors.lightGreen, Colors.black),
                calcbutton('+', Colors.orange, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: (){
                    calculation('0');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    backgroundColor: Colors.grey,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 90, 15),
                        child: Text("0",
                          style: TextStyle(
                            fontSize: 35,
                            color:  Colors.black,

                          ),
                        ),
                    ),
                  ),
                calcbutton('.', Colors.grey, Colors.white),
                calcbutton('=', Colors.orange, Colors.white),
              ],
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

  dynamic text ='0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {


    if(btnText  == 'AC') {
      text ='0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';

    } else if( opr == '=' && btnText == '=') {

      if(preOpr == '+') {
        finalResult = add();
      } else if( preOpr == '-') {
        finalResult = sub();
      } else if( preOpr == 'x') {
        finalResult = mul();
      } else if( preOpr == '/') {
        finalResult = div();
      }

    } else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {

      if(numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if(opr == '+') {
        finalResult = add();
      } else if( opr == '-') {
        finalResult = sub();
      } else if( opr == 'x') {
        finalResult = mul();
      } else if( opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    }
    else if(btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if(btnText == '.') {
      if(!result.toString().contains('.')) {
        result = result.toString()+'.';
      }
      finalResult = result;
    }

    else if(btnText == '+/-') {
      result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-'+result.toString();
      finalResult = result;

    }

    else {
      result = result + btnText;
      finalResult = result;
    }


    setState(() {
      text = finalResult;
    });

  }


  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }


  String doesContainDecimal(dynamic result) {

    if(result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if(!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }

}




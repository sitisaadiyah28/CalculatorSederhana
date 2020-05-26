import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(

  debugShowCheckedModeBanner: false,
  home: CalculatorPage(),
));

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}


class _CalculatorPageState extends State<CalculatorPage> {
  final double _padding = 16.0;
  int value1, value2;
  String operator;
  var sbValue = new StringBuffer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sbValue.write("0");
    operator = "";
  }
  void appendValue(String str) => setState( () {
    bool isDoCalculate = false;
    String strValue = sbValue.toString();
    String lastCharacter = strValue.substring(strValue.length-1);

    if(str == "0" && (lastCharacter =="/" || lastCharacter =="x" || lastCharacter =="+" || lastCharacter =="-")){
      return;
    }
    else if(str == "0" && sbValue.toString() == "0"){
      return;
    }
    else if(str == "="){
      isDoCalculate = true;
    } else if(str == "/" || str == "x" || str == "-" || str=="+"){
      if(operator.isEmpty){
        operator = str;
      }else{
        isDoCalculate = true;
      }
    }

    if(!isDoCalculate){
      if(sbValue.toString() == "0" && str != "0"){
        sbValue.clear();
      }
      sbValue.write(str);
    }else{
      List<String> values = sbValue.toString().split(operator);
      if(values.length ==2 && values[0].isNotEmpty && values[1].isNotEmpty){
        value1 = int.parse(values[0]);
        value2 = int.parse(values[1]);
        sbValue.clear();
        int total = 0;
        switch(operator){
          case "/":
            total = value1 ~/ value2;
            break;
          case "x":
            total = value1 * value2;
            break;
          case "-":
            total = value1 - value2;
            break;
          case "+":
            total = value1+value2;

        }
        sbValue.write(total);
        if(str == "/" || str == "x" || str == "-" || str=="+"){
          operator = str;
          sbValue.write(str);
        }
        else{
          operator = "";
        }
      }
      else{
        String strValue = sbValue.toString();
        String lastCharacter = strValue.substring(strValue.length-1);
        if(str == "/" || str == "x" || str == "-" || str == "+"){
          operator = "";
          sbValue.clear();
          sbValue.write(strValue.substring(0, strValue.length-1)+ "" + str);
          operator = str;
        }
        else if(str == "=" && (lastCharacter == "/" || lastCharacter == "x" || lastCharacter == "-" || lastCharacter == "+")){
          operator = "";
          sbValue.clear();
          sbValue.write(strValue.substring(0, strValue.length-1));
        }
      }
    }

  });

  void clearValue() => setState((){
    operator = "";
    sbValue.clear();
    sbValue.write("0");
  });

  void deleteValue() => setState((){
    String strValue = sbValue.toString();
    if(strValue.length > 0) {
      String lastCharacter = strValue.substring(strValue.length - 1);
      if(lastCharacter == "/" || lastCharacter == "x" || lastCharacter == "-" || lastCharacter == "+"){
        operator = "";
      }
      strValue = strValue.substring(0, strValue.length-1);
      sbValue.clear();
      sbValue.write(strValue.length == 0 ? "0" :strValue);
    }
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.pink[200],
        title: Text('Calculator Ku', style: TextStyle(
          color: Colors.white, fontSize: 20.0
        ),),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            key: Key("expanded_atas"),
            flex: 1,
            child: Container(
              key: Key("expanded_container_atas"),
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.all(16.0),
              child: Stack(
                alignment: Alignment.bottomRight,
                  children: <Widget>[
                    AutoSizeText(
                      sbValue.toString(),
                      style: Theme.of(context).textTheme.display2,
                      maxLines: 1,
                    )
                  ],
              ),
            ),
          ),
          Expanded(
            key: Key("expanded_bawah"),
            flex: 1,
            child: Column(
              key: Key("expanded_container_bawah"),
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                          child: RaisedButton(
                            color: Colors.white,
                            highlightColor: Colors.pink,
                            child: Text(
                              "C", style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold,fontSize: 24.0),
                            ),
                            onPressed: (){
                              clearValue();
                            },
                          ),
                      ),
                      Expanded(
                        flex: 1,
                        child: RaisedButton(
                          color: Colors.white,
                          highlightColor: Colors.pink,
                          child: Icon(
                            Icons.backspace,
                            color: Colors.pink,
                          ),
                          onPressed: (){
                              deleteValue();
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: RaisedButton(
                          onPressed: (){
                              appendValue("x");
                          },
                          color: Colors.white,
                          highlightColor: Colors.pink[600],
                          child: Text(
                            "x", style: TextStyle(fontSize: 24.0, color: Colors.black, fontWeight: FontWeight.bold,),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: RaisedButton(
                          onPressed: (){
                            appendValue("7");
                          },
                          color: Colors.white,
                          highlightColor: Colors.pink[600],
                          child: Text("7", style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold,
                            fontSize: 24.0
                          ),),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: RaisedButton(
                          onPressed: (){
                            appendValue("8");
                          },
                          color: Colors.white,
                          highlightColor: Colors.pink[600],
                          child: Text("8", style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold,
                              fontSize: 24.0
                          ),),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: RaisedButton(
                          onPressed: (){
                            appendValue("9");
                          },
                          color: Colors.white,
                          highlightColor: Colors.pink[600],
                          child: Text("9", style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold,
                              fontSize: 24.0
                          ),),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: RaisedButton(
                          onPressed: (){
                            appendValue("/");
                          },
                          color: Colors.white,
                          highlightColor: Colors.pink[600],
                          child: Text("/", style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold,
                              fontSize: 24.0
                          ),),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: RaisedButton(
                          onPressed: (){
                            appendValue("4");
                          },
                          color: Colors.white,
                          highlightColor: Colors.pink[600],
                          child: Text("4", style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold,
                              fontSize: 24.0
                          ),),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: RaisedButton(
                          onPressed: (){
                            appendValue("5");
                          },
                          color: Colors.white,
                          highlightColor: Colors.pink[600],
                          child: Text("5", style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold,
                              fontSize: 24.0
                          ),),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: RaisedButton(
                          onPressed: (){
                            appendValue("6");
                          },
                          color: Colors.white,
                          highlightColor: Colors.pink[600],
                          child: Text("6", style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold,
                              fontSize: 24.0
                          ),),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: RaisedButton(
                          onPressed: (){
                            appendValue("+");
                          },
                          color: Colors.white,
                          highlightColor: Colors.pink[600],
                          child: Text("+", style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold,
                              fontSize: 24.0
                          ),),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: RaisedButton(
                          onPressed: (){
                            appendValue("1");
                          },
                          color: Colors.white,
                          highlightColor: Colors.pink[600],
                          child: Text("1", style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold,
                              fontSize: 24.0
                          ),),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: RaisedButton(
                          onPressed: (){
                            appendValue("2");
                          },
                          color: Colors.white,
                          highlightColor: Colors.pink[600],
                          child: Text("2", style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold,
                              fontSize: 24.0
                          ),),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: RaisedButton(
                          onPressed: (){
                            appendValue("3");
                          },
                          color: Colors.white,
                          highlightColor: Colors.pink[600],
                          child: Text("3", style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold,
                              fontSize: 24.0
                          ),),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: RaisedButton(
                          onPressed: (){
                            appendValue("-");
                          },
                          color: Colors.white,
                          highlightColor: Colors.pink[600],
                          child: Text("-", style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold,
                              fontSize: 24.0
                          ),),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: RaisedButton(
                          onPressed: (){
                            appendValue("0");
                          },
                          color: Colors.white,
                          highlightColor: Colors.pink[600],
                          child: Text("0", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24.0),),
                        ),
                      ),

                      Expanded(
                        flex: 1,
                        child: RaisedButton(
                          color: Colors.white,
                          highlightColor: Colors.pink[600],
                          child: Text(
                            "=", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24.0),
                          ),
                          onPressed: (){
                            appendValue("=");
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],

            ),
          ),
        ],
      ),
    );
  }
}




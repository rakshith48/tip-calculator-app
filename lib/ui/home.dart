import 'package:flutter/material.dart';
import 'hexcolor.dart';

class TipCalc extends StatefulWidget{
    @override
    _TipCalc createState () => _TipCalc();
}
class _TipCalc extends State<TipCalc>{
    
    int _tipPercentage = 0;
    int _personCounter = 1;
    double _billAmount = 0.0;
    Color _purple = HexColor("#76448A");
    
    @override
    Widget build(BuildContext context){
        return Scaffold(
            body: Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
                alignment: Alignment.center,
                color: Colors.white,
                child: ListView(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.all(20.0),
                    children: <Widget> [
                        Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                color: _purple,
                                borderRadius: BorderRadius.circular(15.0)
                            ),
                            child: Center(
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget> [
                                    Text("Total per person", style: TextStyle(
                                        color: Colors.cyanAccent,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15.0,
                                    ),),
                                    Padding(
                                        padding: EdgeInsets.only(top: 20.0),
                                        child: Text("\$ ${calculateTotalPerPerson(_billAmount, _personCounter)}", style: TextStyle(
                                        color: Colors.cyanAccent,
                                        fontSize: 35,
                                        fontWeight:FontWeight.bold,
                                    ),),),

                                ],
                            )
                            ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 20.0),
                            padding: EdgeInsets.all(12.0),
                            decoration:BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                    color: Colors.blueGrey.shade100,
                                    style: BorderStyle.solid
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Column(
                                children: <Widget> [
                                    TextField(
                                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                                        style: TextStyle(
                                            color: _purple,
                                        ),
                                        decoration: InputDecoration(
                                            prefixText: "Bill Amount",
                                            prefixIcon: Icon(Icons.attach_money),
                                        ),
                                        onChanged: (String value) {
                                            try{
                                                _billAmount = double.parse(value);
                                            }catch(exception){
                                                _billAmount = 0.0;
                                            }
                                        },
                                    ),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget> [
                                            Text("Split", style: TextStyle(
                                                color: Colors.grey.shade700
                                            ),),
                                            Row(
                                                children: <Widget> [
                                                    InkWell(
                                                        onTap: () {
                                                            setState(() {
                                                                if (_personCounter > 1){
                                                                    _personCounter--;
                                                                }else{

                                                                }
                                                            });
                                                        },
                                                        child: Container(
                                                            width: 40.0,
                                                            height: 40.0,
                                                            margin: EdgeInsets.all(10.0),
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(7.0),
                                                                color: _purple,
                                                            ),
                                                            child: Center(
                                                                child: Text("-", style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 17.0
                                                            ),),),
                                                        ),
                                                    ),
                                                    Text("$_personCounter", style: TextStyle(
                                                        color: _purple,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 17.0
                                                    ),),
                                                    InkWell(
                                                        onTap: () {
                                                            setState(() {
                                                                _personCounter++;
                                                            });
                                                        },
                                                        child: Container(
                                                            width: 40.0,
                                                            height: 40.0,
                                                            margin: EdgeInsets.all(10.0),
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(7.0),
                                                                color: _purple,
                                                            ),
                                                            child: Center(
                                                                child: Text("+", style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 17.0
                                                            ),),),
                                                        ),
                                                    ),
                                                ],
                                            ),
                                        ],
                                    ),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget> [
                                            Text("Tip", style: TextStyle(
                                                color: Colors.grey.shade700,
                                            ),),
                                            Padding( 
                                                padding: EdgeInsets.all(18.0),
                                                child: Text("\$${calculateTotalTip(_billAmount, _personCounter, _tipPercentage)}", style: TextStyle(
                                                color: _purple,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                            ),),),
                                        ],
                                    ),
                                    Column(
                                        children: <Widget> [
                                            Text("$_tipPercentage %", style: TextStyle(
                                                color: _purple,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                            ),),
                                            Slider(
                                                min: 0, max: 100,
                                                activeColor: _purple,
                                                inactiveColor: Colors.grey,
                                                divisions: 20,
                                                value: _tipPercentage.toDouble(), onChanged: (double value){
                                                setState((){
                                                    _tipPercentage = value.round();
                                                });
                                            }),
                                        ],
                                    ),
                                ],
                            ),
                        ),
                    ],
                ),
            ),
        );
    }
    calculateTotalPerPerson(double billAmount, int splitBy){
        double totalPerPerson = (calculateTotalTip(billAmount, splitBy, _tipPercentage) + billAmount)/splitBy;
        return totalPerPerson.toStringAsFixed(2);
    }
    calculateTotalTip(double billAmount, int splitBy, int tipPercent){
        double totalTip = 0.0;

        if (billAmount < 0 || billAmount.toString().isEmpty || billAmount == null){

        }else{
            totalTip = billAmount*tipPercent/100;
        }

        return totalTip.toStringAsFixed(2);
    }
}
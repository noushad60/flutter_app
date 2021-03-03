import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiceGame extends StatefulWidget {
  @override
  _DiceGameState createState() => _DiceGameState();
}

class _DiceGameState extends State<DiceGame> {
  var random = Random.secure();
  var dices= [
    'images/d1.png',
    'images/d2.png',
    'images/d3.png',
    'images/d4.png',
    'images/d5.png',
    'images/d6.png',
    'images/d7.jpg',
  ];
  var index1=6;
  var index2=6;
  int score=0;
  int highest=0;
  _changeDice(){
      setState(() {
        index1= random.nextInt(6);
        index2= random.nextInt(6);
        int temp = index1 + index2 + 2;
        if(temp==7){
          game_over= true;
          game_flag =false;
          if(highest<score){
            highest= score;
            high_score_flag=true;
          }
        }
        else score += temp;

      });
  }
  bool high_score_flag=false;
  bool game_flag= false;
  bool game_over= false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dice Game'),
        actions: [
          Text('Highest Score: $highest', style: TextStyle(fontSize: 20),),
        ],
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(high_score_flag)Text('New Highest Score: $highest'),
              ],
            ),
            SizedBox(height: 50,),
            if(game_flag & !game_over)Text('Score: $score', style: TextStyle(fontSize: 30),),
            SizedBox(height: 50,),
            if(game_flag & !game_over)Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [

                Image.asset(dices[index1], height: 150, width: 150,),
                Image.asset(dices[index2], height: 150, width: 150,),
              ],
            ),
            if(game_over)Text('Your Score: $score'),
            SizedBox(height: 40,),
            if(!game_flag)RaisedButton(
              elevation: 15,
              textColor: Colors.white,
              color: Colors.blue,
              child: Text('New Game'),
              onPressed: (){
                setState(() {
                  game_flag=true;
                  game_over =false;
                  high_score_flag=false;
                  index1=6;
                  index2=6;
                  score=0;
                });
              }
            ),
            SizedBox(height: 10,),
            if(game_flag & !game_over)RaisedButton(
              elevation: 15,
              textColor: Colors.white,
              color: Colors.blue,
              child: Text('Rolling'),
                onPressed: _changeDice,
            )
          ],
        ),
      ),
    );
  }
}

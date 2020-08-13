


import 'package:flutter_svg/flutter_svg.dart';
import 'package:audioplayers/audio_cache.dart';

import 'package:flutter/material.dart';

class LetterView extends StatelessWidget {

  final String letter;
  AudioCache audioPlayer = AudioCache();

   LetterView({//constructor
    Key key,
    @required this.letter,
  })  : assert(letter != null),
        super(key: key);

/*
  final String name;
  final ColorSwatch color;
  final IconData iconLocation;

  const LetterView({//constructor
    Key key,
    @required this.name,
    @required this.color,
    @required this.iconLocation,
  })  : assert(name != null),
        assert(color != null),
        assert(iconLocation != null),
        super(key: key);
*/

  @override
  Widget build(BuildContext context) {

    audioPlayer.play("apc.wav");


    SvgPicture letter_choice;

    switch ((letter.toUpperCase())){

      case 'A':

        letter_choice =SvgPicture.asset('assets/a.svg');

        break;

      case 'B':

        letter_choice =SvgPicture.asset('assets/b.svg');

        break;

      case 'C':

        letter_choice =SvgPicture.asset('assets/c.svg');

        break;

      case 'D':

        letter_choice =SvgPicture.asset('assets/d.svg');

        break;

      case 'E':

        letter_choice =SvgPicture.asset('assets/e.svg');

        break;

      case 'F':

        letter_choice =SvgPicture.asset('assets/f.svg');

        break;

      case 'G':

        letter_choice =SvgPicture.asset('assets/g.svg');

        break;

      case 'H':

        letter_choice =SvgPicture.asset('assets/h.svg');

        break;

      case 'I':

        letter_choice =SvgPicture.asset('assets/i.svg');

        break;

      case 'J':

        letter_choice =SvgPicture.asset('assets/j.svg');

        break;

      case 'K':

        letter_choice =SvgPicture.asset('assets/k.svg');

        break;

      case 'L':

        letter_choice =SvgPicture.asset('assets/l.svg');

        break;

      case 'M':
         letter_choice =SvgPicture.asset('assets/m.svg');

      break;

      case 'O':

        letter_choice =SvgPicture.asset('assets/o.svg');

        break;
      case 'P':

        letter_choice =SvgPicture.asset('assets/p.svg');

        break;

      case 'Q':

        letter_choice =SvgPicture.asset('assets/q.svg');

        break;
      case 'R':

        letter_choice =SvgPicture.asset('assets/r.svg');

        break;

      case 'S':

        letter_choice =SvgPicture.asset('assets/s.svg');

        break;

      case 'T':

        letter_choice =SvgPicture.asset('assets/t.svg');

        break;
      case 'U':

        letter_choice =SvgPicture.asset('assets/u.svg');

        break;

        case 'V':

        letter_choice =SvgPicture.asset('assets/v.svg');

        break;

      case 'W':
        letter_choice =SvgPicture.asset('assets/w.svg');
        break;


      case 'X':
        letter_choice =SvgPicture.asset('assets/x.svg');
        break;


      case 'Y':
        letter_choice =SvgPicture.asset('assets/y.svg');
        break;


      case 'Z':
        letter_choice =SvgPicture.asset('assets/z.svg');


    }


    return Center(


     child: MaterialApp(

       home: Scaffold(
backgroundColor: Colors.white,
         body: SizedBox.expand(// let your widget expand to take the available space regardless of size

           child: letter_choice,
         ),
       ),

     ),
    );
  }
}
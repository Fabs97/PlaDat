import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:frontend/models/student.dart';
import 'package:frontend/screens/company_student_list/local_widgets/student_card.dart';
import 'package:frontend/widgets/appbar.dart';
import 'package:frontend/widgets/drawer.dart';

class StudentCardsList extends StatefulWidget {
  StudentCardsList({Key key}) : super(key: key);

  @override
  _StudentCardsListState createState() => _StudentCardsListState();
}

class _StudentCardsListState extends State<StudentCardsList> {
  List<Student> students = [
    Student(id: 1),
    Student(id: 1),
    Student(id: 1),
    Student(id: 1),
    Student(id: 1),
  ];
  CardController _cardController;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar.createAppBar(context, "PlaDat"),
      drawer: CustomDrawer.createDrawer(context),
      body: Column(
        children: [
          Container(
            height: size.height * .9,
            child: TinderSwapCard(
              // swipeUp: true,
              // swipeDown: true,
              animDuration: 400,
              orientation: AmassOrientation.BOTTOM,
              totalNum: students.length,
              stackNum: 3,
              maxWidth: size.width * .9,
              maxHeight: size.height * .9,
              minWidth: size.width * .8,
              minHeight: size.height * .8,
              cardBuilder: (context, index) =>
                  StudentCard(student: students[index]),
              cardController: _cardController = CardController(),
              swipeCompleteCallback: (orientation, index) {
                if (orientation == CardSwipeOrientation.LEFT) {
                  // I don't like this placement
                  print("I don't like this placement");
                } else if (orientation == CardSwipeOrientation.RIGHT) {
                  // I like this placement
                  print("I like this placement");
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

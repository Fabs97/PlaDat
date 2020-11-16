import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:frontend/models/student.dart';
import 'package:frontend/screens/company_student_list/local_widgets/student_card.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/widgets/appbar.dart';
import 'package:frontend/models/match.dart';
import 'package:frontend/widgets/drawer.dart';
import 'package:frontend/widgets/tinder_button.dart';

class StudentCardsList extends StatefulWidget {
  StudentCardsList({Key key}) : super(key: key);

  @override
  _StudentCardsListState createState() => _StudentCardsListState();
}

class _StudentCardsListState extends State<StudentCardsList> {
  List<Student> students;
  CardController _cardController;

  final int placementId = 1;
  @override
  void initState() {
    APIService.route(ENDPOINTS.Recomendations, "/recommendation/id/seeStudents",
            urlArgs: placementId)
        .then((studentsList) => setState(() {
              students = studentsList.cast<Student>();
              print(students);
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar.createAppBar(context, "PlaDat"),
      drawer: CustomDrawer.createDrawer(context),
      body: Column(
        children: [
          Container(
            height: size.height * .8,
            child: students == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : TinderSwapCard(
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
                      APIService.route(ENDPOINTS.Matches, "/matching",
                          body: Match(
                            studentID: students[index].id,
                            placementID: placementId,
                            placementAccept:
                                orientation == CardSwipeOrientation.LEFT
                                    ? false
                                    : true,
                          )).then((match) {
                        print(match);
                      });
                    },
                  ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TinderButton(
                  label: "Discard",
                  cardController: _cardController,
                  discardButton: true),
              TinderButton(
                  label: "I'm interested",
                  cardController: _cardController,
                  discardButton: false),
            ],
          )
        ],
      ),
    );
  }
}

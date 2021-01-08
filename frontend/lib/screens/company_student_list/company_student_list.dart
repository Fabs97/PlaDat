import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:frontend/models/placement.dart';
import 'package:frontend/models/student.dart';
import 'package:frontend/screens/company_student_list/local_widgets/student_card.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/utils/custom_theme.dart';
import 'package:frontend/utils/routes_generator.dart';
import 'package:frontend/widgets/appbar.dart';
import 'package:frontend/models/match.dart';
import 'package:frontend/widgets/drawer.dart';
import 'package:frontend/widgets/match_alert.dart';
import 'package:frontend/widgets/tinder_button.dart';

class StudentCardsList extends StatefulWidget {
  StudentCardsList({Key key}) : super(key: key);

  @override
  _StudentCardsListState createState() => _StudentCardsListState();
}

class _StudentCardsListState extends State<StudentCardsList> {
  List<Placement> _placements;
  CardController _cardController;
  Placement _placement;
  Map<int, List<Student>> recommendationMap = {};
  final _employerID = AuthService().loggedAccountInfo.id;

  @override
  void initState() {
    APIService.route(ENDPOINTS.Employers, "/employer/:employerId/placements",
            urlArgs: _employerID)
        .then((placementsList) {
      if (placementsList != null && placementsList.isNotEmpty) {
        setState(() {
          _placements = placementsList;
          _placement = _placements[0] ?? null;
          for (int i = 0; i < _placements.length; i++) {
            if (_placements[i].status == 'CLOSED')
              _placements.remove(_placements[i]);
          }
          _requestRecomendations();
        });
      } else {
        Nav.currentState.popAndPushNamed("/new-placement");
      }
    });
    super.initState();
  }

  onChangeDropdownItem(Placement selectedPlacement) {
    if (selectedPlacement == null) return;
    setState(() {
      _placement = selectedPlacement;
      if (!recommendationMap.containsKey(selectedPlacement.id)) {
        _requestRecomendations();
      }
    });
  }

  _requestRecomendations() {
    APIService.route(ENDPOINTS.Recomendations, "/recommendation/id/seeStudents",
            urlArgs: _placement.id)
        .then((studentsList) => setState(() {
              recommendationMap[_placement.id] = studentsList.cast<Student>();
            }));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar.createAppBar(context, "PlaDat"),
      drawer: CustomDrawer.createDrawer(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size.width * .85,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.0),
              boxShadow: [CustomTheme().boxShadow],
            ),
            child: _placements == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : (_placements.isEmpty
                    ? Center(
                        child: Text("No placements found, please create one"),
                      )
                    : DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: DropdownButton<Placement>(
                            disabledHint: Text("No placements found!"),
                            icon: Icon(
                              Icons.arrow_drop_down,
                            ),
                            iconEnabledColor: CustomTheme().primaryColor,
                            iconDisabledColor: CustomTheme().secondaryColor,
                            value: _placement,
                            items: _placements?.map((placement) {
                                  return DropdownMenuItem<Placement>(
                                    value: placement,
                                    child: Text(
                                      'Placement #${placement.id}',
                                      style: TextStyle(
                                          color: CustomTheme().primaryColor),
                                    ),
                                  );
                                })?.toList() ??
                                [],
                            onChanged: onChangeDropdownItem,
                          ),
                        ),
                      )),
          ),
          ...(_placement != null &&
                  recommendationMap[_placement.id] != null &&
                  recommendationMap[_placement.id].isNotEmpty
              ? [
                  Container(
                    height: size.height * .8,
                    child: _placement != null &&
                            recommendationMap[_placement.id] != null
                        ? TinderSwapCard(
                            // swipeUp: true,
                            // swipeDown: true,
                            animDuration: 400,
                            orientation: AmassOrientation.BOTTOM,
                            totalNum: recommendationMap[_placement.id].length,
                            stackNum: 3,
                            maxWidth: size.width * .9,
                            maxHeight: size.height * .9,
                            minWidth: size.width * .8,
                            minHeight: size.height * .8,
                            cardBuilder: (context, index) => StudentCard(
                                student: recommendationMap[_placement.id]
                                    [index]),
                            cardController: _cardController = CardController(),
                            swipeCompleteCallback: (orientation, index) {
                              if (orientation != CardSwipeOrientation.RECOVER)
                                APIService.route(ENDPOINTS.Matches, "/matching",
                                    body: Match(
                                      studentID:
                                          recommendationMap[_placement.id]
                                                  [index]
                                              .id,
                                      placementID: _placement.id,
                                      placementAccept: orientation ==
                                              CardSwipeOrientation.LEFT
                                          ? false
                                          : true,
                                    )).then((match) async {
                                  if (match.status == 'ACCEPTED') {
                                    await Nav.currentState
                                        .push(MaterialPageRoute(
                                      builder: (builder) => MatchAlert(
                                        placement: _placement,
                                        object: recommendationMap[_placement.id]
                                            [index],
                                      ),
                                      fullscreenDialog: true,
                                    ));
                                  }
                                  if (recommendationMap[_placement.id]
                                          ?.isNotEmpty ??
                                      false) {
                                    setState(() {
                                      recommendationMap[_placement.id]
                                          .removeAt(index);
                                    });
                                  }
                                });
                            },
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                  Container(
                    width: size.width * .855,
                    height: size.height * .05,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    ),
                  )
                ]
              : [
                  Container(
                    height: size.height * .85,
                    child: Center(
                      child: Text(
                        "No recommendations for this placement (yet!)",
                        style: TextStyle(
                          color: CustomTheme().primaryColor,
                        ),
                      ),
                    ),
                  )
                ])
        ],
      ),
    );
  }
}

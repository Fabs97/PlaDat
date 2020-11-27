import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:frontend/models/placement.dart';
import 'package:frontend/models/match.dart';
import 'package:frontend/screens/student_placement_list/local_widgets/placement_card.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/utils/routes_generator.dart';
import 'package:frontend/widgets/appbar.dart';
import 'package:frontend/widgets/drawer.dart';
import 'package:frontend/widgets/match_alert.dart';
import 'package:frontend/widgets/tinder_button.dart';

class PlacementCardsList extends StatefulWidget {
  PlacementCardsList({Key key}) : super(key: key);

  @override
  _PlacementCardsListState createState() => _PlacementCardsListState();
}

class _PlacementCardsListState extends State<PlacementCardsList>
    with TickerProviderStateMixin {
  List<Placement> placements;

  CardController _cardController;

  final studentId = 1;
  @override
  void initState() {
    APIService.route(
            ENDPOINTS.Recomendations, "/recommendation/id/seePlacements",
            urlArgs: studentId)
        .then((placementsList) => setState(() {
              placements = placementsList.cast<Placement>();
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: size.height * .8,
            child: placements == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : TinderSwapCard(
                    // swipeUp: true,
                    // swipeDown: true,
                    animDuration: 400,
                    orientation: AmassOrientation.BOTTOM,
                    totalNum: placements.length,
                    stackNum: 3,
                    maxWidth: size.width * .9,
                    maxHeight: size.height * .9,
                    minWidth: size.width * .8,
                    minHeight: size.height * .8,
                    cardBuilder: (context, index) =>
                        PlacementCard(placement: placements[index]),
                    cardController: _cardController = CardController(),
                    swipeCompleteCallback: (orientation, index) {
                      APIService.route(ENDPOINTS.Matches, "/matching",
                          body: Match(
                            studentID: studentId,
                            placementID: placements[index].id,
                            studentAccept:
                                orientation == CardSwipeOrientation.LEFT
                                    ? false
                                    : true,
                          )).then((match) async {
                        if (match.status == 'ACCEPTED') {
                          await Nav.navigatorKey.currentState
                              .push(MaterialPageRoute(
                            builder: (builder) => MatchAlert(
                              placement: placements[index],
                              object: null,
                            ),
                            fullscreenDialog: true,
                          ));
                        }
                      });
                    },
                  ),
          ),
          Container(
            width: size.width * .9,
            height: size.height * .05,
            child: Row(
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
            ),
          )
        ],
      ),
    );
  }
}

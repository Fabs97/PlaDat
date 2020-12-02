import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:frontend/models/placement.dart';
import 'package:frontend/models/match.dart';
import 'package:frontend/screens/student_placement_list/local_widgets/placement_card.dart';
import 'package:frontend/screens/student_placement_list/local_widgets/placement_filter.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/utils/routes_generator.dart';
import 'package:frontend/widgets/appbar.dart';
import 'package:frontend/widgets/drawer.dart';
import 'package:frontend/widgets/match_alert.dart';
import 'package:frontend/widgets/tinder_button.dart';
import 'package:smart_select/smart_select.dart';

class PlacementCardsList extends StatefulWidget {
  PlacementCardsList({Key key}) : super(key: key);

  @override
  _PlacementCardsListState createState() => _PlacementCardsListState();
}

class _PlacementCardsListState extends State<PlacementCardsList>
    with TickerProviderStateMixin {
  List<Placement> _placements;
  List<Placement> _filteredPlacements;

  CardController _cardController;

  List<PlacementFilter> _filtersChosen = [];
  final _filters = PlacementFilters.list;

  final studentId = 1;
  @override
  void initState() {
    APIService.route(
            ENDPOINTS.Recomendations, "/recommendation/id/seePlacements",
            urlArgs: studentId)
        .then((placementsList) => setState(() {
              _placements = placementsList.cast<Placement>();
              _filteredPlacements = _placements;
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
          _createFilterButton(size),
          Container(
            height: size.height * .8,
            child: _filteredPlacements == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : TinderSwapCard(
                    // swipeUp: true,
                    // swipeDown: true,
                    animDuration: 400,
                    orientation: AmassOrientation.BOTTOM,
                    totalNum: _filteredPlacements.length,
                    stackNum: 3,
                    maxWidth: size.width * .9,
                    maxHeight: size.height * .9,
                    minWidth: size.width * .8,
                    minHeight: size.height * .8,
                    cardBuilder: (context, index) =>
                        PlacementCard(placement: _filteredPlacements[index]),
                    cardController: _cardController = CardController(),
                    swipeCompleteCallback: (orientation, index) {
                      APIService.route(ENDPOINTS.Matches, "/matching",
                          body: Match(
                            studentID: studentId,
                            placementID: _filteredPlacements[index].id,
                            studentAccept:
                                orientation == CardSwipeOrientation.LEFT
                                    ? false
                                    : true,
                          )).then((match) async {
                        if (match.status == 'ACCEPTED') {
                          await Nav.navigatorKey.currentState
                              .push(MaterialPageRoute(
                            builder: (builder) => MatchAlert(
                              placement: _filteredPlacements[index],
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

  _createFilterButton(Size screenSize) {
    return SizedBox(
      width: screenSize.width * .85,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(2.0, 2.0),
            )
          ],
        ),
        child: SmartSelect<PlacementFilter>.multiple(
          value: _filtersChosen,
          onChange: (chosenFilters) {
            _filtersChosen = chosenFilters.value;
            setState(() {
              if (_filtersChosen.isNotEmpty) {
                // needed to empty the list in order to not insert doubled placements
                _filteredPlacements = [];
                _placements.forEach((placement) {
                  for (var filter in _filtersChosen) {
                    bool res = filter.compare(placement) &&
                        !_filteredPlacements.contains(placement);
                    if (res) {
                      _filteredPlacements.add(placement);
                      break;
                    }
                  }
                });
              } else {
                _filteredPlacements = _placements;
              }
            });
          },
          title: "Filter",
          placeholder: "",
          modalType: S2ModalType.popupDialog,
          modalFilter: false,
          modalHeader: true,
          modalHeaderBuilder: (context, _) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.filter_alt_outlined),
                    Text(
                      "Filter",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.keyboard_arrow_up)
                  ],
                ),
              ),
            );
          },
          modalHeaderStyle: S2ModalHeaderStyle(
            centerTitle: true,
          ),
          choiceGrouped: true,
          choiceItems: S2Choice.listFrom(
            source: _filters,
            value: (_, filter) => filter,
            title: (index, filter) => filter.name,
            group: (index, filter) => filter.category,
          ),
        ),
      ),
    );
  }
}

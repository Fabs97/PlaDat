import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:frontend/models/placement.dart';
import 'package:frontend/models/match.dart';
import 'package:frontend/screens/student_placement_list/local_widgets/placement_card.dart';
import 'package:frontend/screens/student_placement_list/local_widgets/placement_filter.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/utils/custom_theme.dart';
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

  final studentId = AuthService().loggedAccountInfo.id;
  List<PlacementFilter> _filtersChosen = [];
  final _filters = PlacementFilters.list;
  @override
  void initState() {
    APIService.route(
            ENDPOINTS.Recomendations, "/recommendation/id/seePlacements",
            urlArgs: studentId)
        .then((placementsList) => setState(() {
              _placements = placementsList?.cast<Placement>() ?? [];
              _filteredPlacements = _placements;
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar.createAppBar(context, "PlaDat"),
      drawer: CustomDrawer.createDrawer(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _createFilterButton(size, themeData),
          Container(
            height: size.height * .8,
            child: _filteredPlacements == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : TinderSwapCard(
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
                          await Nav.currentState.push(MaterialPageRoute(
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

  _createFilterButton(Size screenSize, ThemeData themeData) {
    final customTheme = CustomTheme();
    return SizedBox(
      width: screenSize.width * .85,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          color: Colors.white,
          boxShadow: [customTheme.boxShadow],
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
          modalStyle: S2ModalStyle(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            ),
          ),
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
                    Icon(
                      Icons.filter_alt_outlined,
                      size: 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text(
                        "Filter",
                        style: TextStyle(
                          color: CustomTheme().primaryColor,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.keyboard_arrow_up,
                        color: CustomTheme().primaryColor)
                  ],
                ),
              ),
            );
          },
          modalConfig: S2ModalConfig(
            barrierColor: Colors.transparent,
            headerStyle: S2ModalHeaderStyle(
              centerTitle: true,
              elevation: 0.0,
              textStyle: themeData.textTheme.bodyText1.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          choiceConfig: S2ChoiceConfig(
            overscrollColor: customTheme.backgroundColor,
          ),
          choiceGrouped: true,
          choiceHeaderStyle: S2ChoiceHeaderStyle(
            backgroundColor: Colors.white,
            textStyle: themeData.textTheme.bodyText1.copyWith(
              fontWeight: FontWeight.w700,
              color: customTheme.primaryColor,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            height: 20,
          ),
          choiceHeaderBuilder: (_, group, __) {
            final style = group.style;
            return Padding(
              padding: style.padding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    group.name,
                    style: style.textStyle,
                  ),
                ],
              ),
            );
          },
          choiceStyle: S2ChoiceStyle(
            showCheckmark: false,
            activeColor: customTheme.secondaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 21.0),
            control: S2ChoiceControl.leading,
            spacing: 21.0,
            titleStyle: themeData.textTheme.bodyText1.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
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

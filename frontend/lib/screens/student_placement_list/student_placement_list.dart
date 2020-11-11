import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:frontend/models/placement.dart';
import 'package:frontend/screens/student_placement_list/local_widgets/placement_card.dart';
import 'package:frontend/widgets/appbar.dart';
import 'package:frontend/widgets/drawer.dart';

class PlacementCardsList extends StatefulWidget {
  PlacementCardsList({Key key}) : super(key: key);

  @override
  _PlacementCardsListState createState() => _PlacementCardsListState();
}

class _PlacementCardsListState extends State<PlacementCardsList>
    with TickerProviderStateMixin {
  List<Placement> placements = [
    Placement(
      id: 1,
      position: "Full Stack Dev",
      workingHours: 20,
      startPeriod: DateTime.now(),
      endPeriod: DateTime.now(),
      salary: 600,
      description: "Lorem ipsum",
      institution: "PoliMi",
      major: "Computer Science",
    ),
    Placement(
      id: 1,
      position: "Full Stack Dev",
      workingHours: 20,
      startPeriod: DateTime.now(),
      endPeriod: DateTime.now(),
      salary: 600,
      description: "Lorem ipsum",
      institution: "PoliMi",
      major: "Computer Science",
    ),
    Placement(
      id: 1,
      position: "Full Stack Dev",
      workingHours: 20,
      startPeriod: DateTime.now(),
      endPeriod: DateTime.now(),
      salary: 600,
      description: "Lorem ipsum",
      institution: "PoliMi",
      major: "Computer Science",
    ),
    Placement(
      id: 1,
      position: "Full Stack Dev",
      workingHours: 20,
      startPeriod: DateTime.now(),
      endPeriod: DateTime.now(),
      salary: 600,
      description: "Lorem ipsum",
      institution: "PoliMi",
      major: "Computer Science",
    ),
    Placement(
      id: 1,
      position: "Full Stack Dev",
      workingHours: 20,
      startPeriod: DateTime.now(),
      endPeriod: DateTime.now(),
      salary: 600,
      description: "Lorem ipsum",
      institution: "PoliMi",
      major: "Computer Science",
    ),
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

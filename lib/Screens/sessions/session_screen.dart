// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';

import 'package:sessions/components/appbar.dart';
import 'package:sessions/components/popup_menus.dart';
import 'package:sessions/constants.dart';

import 'package:sessions/screens/profile/components/utils.dart';
import 'package:sessions/screens/sessions/components/date_pickers.dart';
import 'package:sessions/screens/sessions/create_session.dart';
import 'package:sessions/screens/sessions/search_sessions.dart';
import 'package:sessions/utils/classes.dart';
import 'package:sessions/utils/navigations.dart';

List<PairPopMenu> popUpOptions = [
  PairPopMenu(value: 0, option: "Create Session"),
  PairPopMenu(value: 1, option: "Search All Sessions"),
  PairPopMenu(value: 2, option: "View your Sessions"),
];

class SessionsScreen extends StatefulWidget {
  const SessionsScreen({super.key});

  @override
  State<SessionsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
  void onSelectFun({required int value}) {
    if (value == 0) {
      navigatorPush(CreateSession(), context);
    }
    if (value == 1) {
      navigatorPush(SearchSession(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CurvedAppBar(
        title: "Sessions",
        actions: [
          IconButton(
            onPressed: () {
              navigatorPush(SearchSession(), context);
            },
            icon: Icon(Icons.search),
            splashRadius: 25,
            splashColor: kPrimaryColor,
          ),
          Padding(
            padding: EdgeInsets.only(right: 15, left: 5),
            child: PopUpMenuWidget(
              options: popUpOptions,
              onSelect: onSelectFun,
            ),
          ),
        ],
        leading: SizedBox(),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            CustomCalendarWidget(size: size),
            CustomDraggableSheet(minHeight: size.height * 0.5),
          ],
        ),
      ),
    );
  }
}

class CustomDraggableSheet extends StatefulWidget {
  final double minHeight;

  const CustomDraggableSheet({
    super.key,
    required this.minHeight,
  });
  @override
  _CustomDraggableSheetState createState() => _CustomDraggableSheetState();
}

class _CustomDraggableSheetState extends State<CustomDraggableSheet> {
  late double _currentHeight;
  DraggableScrollableController controller = DraggableScrollableController();
  double maxHeight = 700;

  @override
  void initState() {
    _currentHeight = widget.minHeight - 65;

    controller.addListener(() {
      setState(() {
        _currentHeight = controller.pixels - 80;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    maxHeight = size.height;

    return DraggableScrollableSheet(
      controller: controller,
      minChildSize: 0.5,
      maxChildSize: 1,
      initialChildSize: 0.6,
      builder: (BuildContext context, ScrollController scrollController) {
        //print(_currentHeight);

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            boxShadow: [
              BoxShadow(
                color: kPrimaryColor.withOpacity(0.3),
                blurRadius: 5.0,
                spreadRadius: 3.0,
                offset: Offset(0.0, -2.0),
              ),
            ],
          ),
          child: Column(
            children: [
              SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: size.width * 0.4,
                        right: size.width * 0.4,
                        bottom: 10,
                      ),
                      child: BlurDivider(size: size),
                    ),
                    Container(
                      height: _currentHeight - 10,
                      child: MyExpansionPanelList(),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class MyExpansionPanelList extends StatefulWidget {
  @override
  _MyExpansionPanelListState createState() => _MyExpansionPanelListState();
}

class _MyExpansionPanelListState extends State<MyExpansionPanelList> {
  List<Item> _data = generateItems(8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expansion Panel List'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(5),
          child: ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _data[index].isExpanded = !isExpanded;
              });
            },
            children: _data.map<ExpansionPanel>((Item item) {
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(item.header),
                  );
                },
                body: ListTile(
                  title: Text(item.body),
                ),
                isExpanded: item.isExpanded,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class Item {
  String header;
  String body;
  bool isExpanded;

  Item({required this.header, required this.body, this.isExpanded = false});
}

List<Item> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (int index) {
    return Item(
      header: 'Item $index header',
      body: 'Item $index body Lorem ipsum dolor sit amet.',
    );
  });
}

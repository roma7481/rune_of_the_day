import 'package:flutter/material.dart';
import 'package:rune_of_the_day/app/constants/styles/icons.dart';

class CustomScaffold extends StatelessWidget {
  CustomScaffold.withFab({
    Key key,
    this.drawer,
    @required this.appBar,
    @required this.content,
    @required this.fab,
  });

  CustomScaffold({
    Key key,
    this.drawer,
    @required this.appBar,
    @required this.content,
  }) : this.fab = Container();

  final Widget appBar;
  final Widget content;
  final Widget drawer;
  final Widget fab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(background), fit: BoxFit.cover)),
          child: content),
      floatingActionButton: fab,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:multiavatar_exemple/my_paint.dart';
import 'package:multiavatar_exemple/svg_wrapper.dart';

class HoemPage extends StatefulWidget {
  @override
  _HoemPageState createState() => _HoemPageState();
}

class _HoemPageState extends State<HoemPage> {
  String svgCode = multiavatar('X-SLAYER');
  DrawableRoot svgRoot;
  TextEditingController randomField = TextEditingController();

  _generateSvg() async {
    return SvgWrapper(svgCode).generateLogo().then((value) {
      setState(() {
        svgRoot = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _generateSvg();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF141E30),
              Color(0xFF243B55),
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _avatarPreview(),
                  SizedBox(height: 35.0),
                  _textField(),
                  SizedBox(height: 40.0),
                  Text(
                    "In total, it is possible to generate 12 billion unique avatars.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white60, fontSize: 17.0),
                  ),
                  SizedBox(height: 25.0),
                  _randomButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _avatarPreview() {
    return Container(
      height: 180.0,
      width: 180.0,
      child: svgRoot == null
          ? SizedBox.shrink()
          : CustomPaint(
              painter: MyPainter(svgRoot, Size(180.0, 180.0)),
              child: Container(),
            ),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _textField() {
    return TextField(
      controller: randomField,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white),
      onChanged: (field) {
        if (field.isNotEmpty) {
          setState(() {
            svgCode = multiavatar(field);
          });
          // dev.log(svgCode);
        } else
          setState(() {
            svgCode = multiavatar('X-SLAYER');
          });
        _generateSvg();
      },
      decoration: InputDecoration(
        fillColor: Colors.white10,
        border: InputBorder.none,
        filled: true,
        hintText: "type anything here",
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _randomButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: EdgeInsets.all(8.0),
        color: Colors.white10,
        child: IconButton(
            onPressed: () {
              var l = new List.generate(12, (_) => new Random().nextInt(100));
              randomField.text = l.join();
              setState(() {
                svgCode = multiavatar(randomField.text);
              });
              _generateSvg();
            },
            icon: Icon(
              Icons.refresh,
              size: 30.0,
              color: Colors.white60,
            )),
      ),
    );
  }
}

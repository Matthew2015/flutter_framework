/*
 * @Descripttion: 
 * @version: 1.0
 * @Author: Matthew
 * @Date: 2021-06-25 11:07:28
 * @LastEditTime: 2021-06-25 13:44:00
 */
import 'package:flutter/material.dart';

class FlutterTimeCounter extends StatefulWidget {
  FlutterTimeCounter({Key key, this.weight = 70, this.bgColor = Colors.blue}) : super(key: key);
  final double weight;
  final Color bgColor;
  @override
  _FlutterTimeCounterState createState() => _FlutterTimeCounterState();
}

class _FlutterTimeCounterState extends State<FlutterTimeCounter> {
  int _minDecade = 0;
  int _minUnit = 0;
  int _secDecade = 0;
  int _secUnit = 0;
  void _increment({bool isDecade = true, bool isMin = true}) {
    if (_secDecade >= 6) {
      _secDecade = 0;
    }
    if (isDecade) {
      if (isMin ? _minDecade >= (_minUnit == 0 ? 6 : 5) : ((_minDecade > 0 || _minUnit > 0 || _secUnit > 0) && _secDecade >= 5)) {
        setState(() {
          if (isMin) {
            _minDecade = 0;
          } else {
            _secDecade = 0;
          }
        });
        return;
      }
      setState(() {
        if (isMin) {
          _minDecade++;
        } else {
          _secDecade++;
        }
      });
    } else {
      if ((isMin ? _minUnit : _secUnit) >= 9) {
        setState(() {
          if (isMin) {
            _minUnit = 0;
          } else {
            _secUnit = 0;
          }
        });
        return;
      }
      setState(() {
        if (isMin) {
          _minUnit++;
        } else {
          _secUnit++;
        }
      });
    }
  }

  void _decrement({bool isDecade = true, bool isMin = true}) {
    if (isDecade) {
      if ((isMin ? _minDecade : _secDecade) <= 0) {
        setState(() {
          if (isMin) {
            _minDecade = _minUnit > 0 ? 5 : 6;
          } else {
            _secDecade = (_minDecade > 0 || _minUnit > 0 || _secUnit > 0) ? 5 : 6;
          }
        });
        return;
      }
      setState(() {
        if (isMin) {
          _minDecade--;
        } else {
          _secDecade--;
        }
      });
    } else {
      if ((isMin ? _minUnit : _secUnit) <= 0) {
        setState(() {
          if (isMin) {
            _minUnit = 9;
          } else {
            _secUnit = 9;
          }
        });
        return;
      }
      setState(() {
        if (isMin) {
          _minUnit--;
        } else {
          _secUnit--;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _numberSelectWidget({bool isDecade = true, Color color, double weight, Function up, Function down, int value = 0}) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
          width: weight,
          decoration: BoxDecoration(
              border: Border.all(width: 0.0, color: color),
              color: color,
              borderRadius: isDecade ? BorderRadius.only(topLeft: Radius.circular(10)) : BorderRadius.only(topRight: Radius.circular(10))),
          child: InkWell(
              onTap: () {
                print('up1');
                up();
              },
              child: Icon(
                Icons.keyboard_arrow_up,
                color: Colors.white,
              )),
          padding: EdgeInsets.fromLTRB(24, 8, 24, 8)),
      Container(
        width: weight,
        margin: EdgeInsets.symmetric(vertical: 1),
        color: color,
        child: Center(
          child: Text(
            value.toString(),
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
      ),
      Container(
          width: weight,
          decoration: BoxDecoration(
              border: Border.all(width: 0.0, color: color),
              color: color,
              borderRadius: isDecade ? BorderRadius.only(bottomLeft: Radius.circular(10)) : BorderRadius.only(bottomRight: Radius.circular(10))),
          child: InkWell(
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
            onTap: () {
              print('down');
              down();
            },
          ),
          padding: EdgeInsets.fromLTRB(24, 8, 24, 8)),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
    return Scaffold(
        body: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        margin: EdgeInsets.all(20),
        child: SwitchButton(switchTexts: ['倒计时', '正计时'], themeColor: widget.bgColor),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        _numberSelectWidget(color: widget.bgColor, weight: widget.weight, up: () => {_increment()}, down: () => {_decrement()}, value: this._minDecade),
        _numberSelectWidget(
            color: widget.bgColor,
            weight: widget.weight,
            up: () => {_increment(isDecade: false)},
            down: () => {_decrement(isDecade: false)},
            isDecade: false,
            value: this._minUnit),
        Text(':',
            style: TextStyle(
              fontSize: 32,
              color: widget.bgColor,
            )),
        _numberSelectWidget(color: widget.bgColor, weight: widget.weight, up: () => {_increment(isMin: false)}, down: () => {_decrement(isMin: false)}, value: this._secDecade),
        _numberSelectWidget(
            color: widget.bgColor,
            weight: widget.weight,
            up: () => {_increment(isDecade: false, isMin: false)},
            down: () => {_decrement(isDecade: false, isMin: false)},
            isDecade: false,
            value: this._secUnit),
      ]),
      Container(
          margin: EdgeInsets.all(20),
          child: Material(
              shape: CircleBorder(side: BorderSide(color: widget.bgColor, width: 2, style: BorderStyle.solid)),
              child: IconButton(
                  icon: Icon(
                    Icons.play_arrow,
                    color: widget.bgColor,
                  ),
                  iconSize: 40,
                  onPressed: () {})))
    ])));
  }
}

class SwitchButton extends StatefulWidget {
  SwitchButton({Key key, this.switchTexts, this.themeColor}) : super(key: key);
  final List<String> switchTexts;
  Color themeColor = Colors.green;
  @override
  _switchButtonState createState() => _switchButtonState();
}

class _switchButtonState extends State<SwitchButton> {
  int _selectIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _selectIndexSwitch(int value) {
    setState(() {
      this._selectIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),
              border: Border.all(width: 1, color: widget.themeColor),
              color: this._selectIndex == 0 ? widget.themeColor : null),
          child: TextButton(
            child: Text(widget.switchTexts[0], style: TextStyle(color: this._selectIndex == 0 ? Colors.white : widget.themeColor)),
            onPressed: () {
              print('switch press $_selectIndex');
              _selectIndexSwitch(0);
            },
          ),
        ),
        Container(
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(right: Radius.circular(8)),
              border: Border.all(width: 1, color: widget.themeColor),
              color: this._selectIndex == 1 ? widget.themeColor : null),
          child: TextButton(
            child: Text(widget.switchTexts[1], style: TextStyle(color: this._selectIndex == 1 ? Colors.white : widget.themeColor)),
            onPressed: () {
              print('switch press');
              _selectIndexSwitch(1);
            },
          ),
        ),
      ],
    ));
  }
}

import 'package:flutter/material.dart';

class LoadingButton extends StatefulWidget {
  Function onPressed;
  bool loading;
  String title;
  LoadingButton({this.onPressed, this.loading = false, this.title = 'Done'});
  @override
  LoadingButtonState createState() => LoadingButtonState();
}

class LoadingButtonState extends State<LoadingButton> {
  bool isAnimating = true;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 26),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.red[500], shape: const StadiumBorder()),
            onPressed: () {
              if (!widget.loading) widget.onPressed();
            },
            child: widget.loading
                ? Container(
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    )),
                    width: 30,
                    height: 30,
                  )
                : Text(widget.title,
                    style: TextStyle(fontSize: 20, color: Colors.white)),
          ),
          height: 50,
          width: double.maxFinite),
      // child: AnimatedContainer(
      //     duration: Duration(milliseconds: 100),
      //     onEnd: () => setState(() {
      //           isAnimating = !isAnimating;
      //         }),
      //     width: widget.loading != true ? buttonWidth : 70,
      //     height: 50,
      //     child: isAnimating ? buildButton() : circularContainer()
      //     ),
    );
  }
  // If Button State is init : show Normal submit button
  // Widget buildButton() => ElevatedButton(
  //       style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
  //       onPressed: widget.onPressed,
  //       child: Text(widget.title,style: TextStyle(fontSize: 20, color: Colors.white)),
  //     );

  // Widget circularContainer() {
  //   return Container(
  //     decoration: BoxDecoration(shape: BoxShape.circle, color: primaryColor ),
  //     child: Center(
  //       child: const CircularProgressIndicator( color: Colors.white)
  //     )
  //   );
  // }
}

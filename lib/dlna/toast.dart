import 'package:flutter/material.dart';

class Toast {
  static OverlayEntry? _overlayEntry;
  static bool _showing = false;
  static DateTime _startedTime = DateTime.now();
  static String _msg = "";
  static void toast(
    BuildContext context,
    String msg,
  ) async {
    _msg = msg;
    _startedTime = DateTime.now();

    OverlayState overlayState = Overlay.of(context);
    _showing = true;
    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(
          builder: (BuildContext context) => Positioned(
                top: MediaQuery.of(context).size.height * 2 / 3,
                child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80.0),
                      child: AnimatedOpacity(
                        opacity: _showing ? 1.0 : 0.0,
                        duration: _showing
                            ? const Duration(milliseconds: 100)
                            : const Duration(milliseconds: 400),
                        child: _buildToastWidget(),
                      ),
                    )),
              ));
      overlayState.insert(_overlayEntry!);
    } else {
      _overlayEntry!.markNeedsBuild();
    }
    await Future.delayed(const Duration(milliseconds: 2000));
    if (DateTime.now().difference(_startedTime).inMilliseconds >= 2000) {
      _showing = false;
      _overlayEntry!.markNeedsBuild();
    }
  }

  static _buildToastWidget() {
    return Center(
      child: Card(
        color: Colors.black87,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Text(
            _msg,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

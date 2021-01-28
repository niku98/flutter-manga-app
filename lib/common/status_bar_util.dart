import 'dart:convert';

import 'package:flutter/painting.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';

class NStatusBarStyle {
  StatusBarStyle style;
  bool translucent;
  bool fullscreen;
  bool hidden;
  Color color;

  NStatusBarStyle(
      {this.color, this.translucent, this.fullscreen, this.hidden, this.style});
}

class StatusBarUtil {
  static NStatusBarStyle _current = NStatusBarStyle();
  static NStatusBarStyle _previous = NStatusBarStyle();

  static setTranslucent(bool translucent) {
    _previous.translucent = _current.translucent;

    _current.translucent = translucent;
    FlutterStatusbarManager.setTranslucent(translucent);
  }

  static setStyle(StatusBarStyle style) {
    _previous.style = _current.style;

    _current.style = style;
    FlutterStatusbarManager.setStyle(style);
  }

  static setFullscreen(bool fullscreen) {
    _previous.fullscreen = _current.fullscreen;

    StatusBarUtil._current.fullscreen = fullscreen;
    FlutterStatusbarManager.setFullscreen(fullscreen);
  }

  static setHidden(bool hidden) {
    _previous.hidden = _current.hidden;

    _current.hidden = hidden;
    FlutterStatusbarManager.setHidden(hidden);
  }

  static setColor(Color color, {bool animated = false}) {
    _previous.color = _current.color;

    _current.color = color;
    print(_current.color.toString() + _previous.color.toString());
    FlutterStatusbarManager.setColor(color, animated: animated);
  }

  static restoreCurrent() {
    if (_current.color != null) {
      FlutterStatusbarManager.setColor(_current.color);
    }
    if (_current.translucent != null) {
      FlutterStatusbarManager.setTranslucent(_current.translucent);
    }
    if (_current.fullscreen != null) {
      FlutterStatusbarManager.setFullscreen(_current.fullscreen);
    }
    if (_current.hidden != null) {
      FlutterStatusbarManager.setHidden(_current.hidden);
    }
    if (_current.style != null) {
      FlutterStatusbarManager.setStyle(_current.style);
    }
  }

  static backToPrevious() {
    print(_current.color);
    _current = new NStatusBarStyle(
        color: _previous.color,
        translucent: _previous.translucent,
        hidden: _previous.hidden,
        fullscreen: _previous.fullscreen,
        style: _previous.style);
    _previous = new NStatusBarStyle();

    if (_current.color != null) {
      FlutterStatusbarManager.setColor(_current.color);
    }
    if (_current.translucent != null) {
      FlutterStatusbarManager.setTranslucent(_current.translucent);
    }
    if (_current.fullscreen != null) {
      FlutterStatusbarManager.setFullscreen(_current.fullscreen);
    }
    if (_current.hidden != null) {
      FlutterStatusbarManager.setHidden(_current.hidden);
    }
    if (_current.style != null) {
      FlutterStatusbarManager.setStyle(_current.style);
    }
  }
}

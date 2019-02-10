import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../view/home.dart';
import '../view/video_play/index.dart';

var rootHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomePage(title: '二次Play');
});

var videoPlayHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return VideoPlayPage();
});

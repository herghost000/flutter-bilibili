import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../view/home.dart';
import '../view/video_play/index.dart';
import '../view/test/test_one.dart';

var rootHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomePage(title: '二次Play');
});

var videoPlayHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return VideoPlayPage();
});

var testOneHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return TestOne();
});

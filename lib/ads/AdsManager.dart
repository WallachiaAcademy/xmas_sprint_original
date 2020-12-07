import 'dart:async';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/foundation.dart';
import 'package:xmas_sprint/screens/ScreenManager.dart';
import 'package:xmas_sprint/screens/ScreenState.dart';

const String appId = "ca-app-pub-4462046078416785~7075192000";
const String adUnitId = "ca-app-pub-4462046078416785/8424766848";

class AdsManager {
  static final AdsManager instance = AdsManager._privateConstructor();

  AdsManager._privateConstructor() {
    print("Loading ads! Mode:" + (kReleaseMode ? "RELEASE" : "DEBUG"));
    FirebaseAdMob.instance.initialize(
      appId: kReleaseMode ? appId : FirebaseAdMob.testAppId,
    );
    _whenFinished = () {
      screenManager.switchScreen(ScreenState.kMenuScreen);
    };
  }

  final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['Candy', 'Santa', 'Christmas', 'Run', 'Game'],
    nonPersonalizedAds: true,
    testDevices: <String>[],
  );

  Function _whenFinished;
  InterstitialAd _interstitialAd;
  bool adLoaded = false;
  bool cacheOngoing = false;
  DateTime _lastPlayed = null;

  Future<void> playNewAd(Function whenFinished) async {
    _whenFinished = whenFinished;
    try {
      // Ad not loaded
      if (!adLoaded) {
        // Cache the ad and show the error
        _cacheInterstitial();
        _whenFinished();
      } else {
        bool playAd = false;
        if (_lastPlayed == null) {
          playAd = true;
          _lastPlayed = DateTime.now();
        } else {
          if (DateTime.now().difference(_lastPlayed).inSeconds > 300) {
            playAd = true;
            _lastPlayed = DateTime.now();
          }
        }

        if (playAd) {
          adLoaded = false;
          _interstitialAd?.show();
        }
        else{
          _whenFinished();
        }
      }
    } catch (Exception) {
      _whenFinished();
    }
  }

  Future<void> cacheAd() async {
    await _cacheInterstitial();
  }

  Future<void> _cacheInterstitial() async {
    if (!cacheOngoing) {
      cacheOngoing = true;
      await _interstitialAd?.dispose();
      _interstitialAd = _createInterstitialAd();
      await _interstitialAd.load();
      cacheOngoing = false;
    }
  }

  int timer = 1000;
  InterstitialAd _createInterstitialAd() {
    return InterstitialAd(
      adUnitId: kReleaseMode ? adUnitId : InterstitialAd.testAdUnitId,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        if (event == MobileAdEvent.closed) {
          _cacheInterstitial();
          _whenFinished();
        } else if (event == MobileAdEvent.loaded) {
          timer = 1000;
          adLoaded = true;
        } else if (event == MobileAdEvent.failedToLoad) {
          Timer(Duration(milliseconds: timer), () {
            if (timer < 30000) timer = timer + 1000;
            _cacheInterstitial();
          });
        }
      },
    );
  }
}

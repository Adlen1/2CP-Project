import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/screens/login_page.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  bool _navigated = false;

  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();

    _videoController = VideoPlayerController.asset("assets/intro.mp4")
      ..initialize().then((_) {
        setState(() {}); // trigger rebuild if needed
      });

    _waitForData();
    _startTimeoutChecker();
  }

  void _startTimeoutChecker() async {
    while (mounted && !_navigated) {
      await Future.delayed(Duration(seconds: 22));
      if (_isDataStillLoading()) {
        if (mounted && !_navigated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Connection failed... Please check your internet."),
              backgroundColor: Colors.redAccent,
              duration: Duration(seconds: 5),
            ),
          );
        }
      } else {
        break;
      }
    }
  }

  void _playIntroVideoAndNavigate() async {
    if (_navigated || !_videoController.value.isInitialized) return;
    _navigated = true;

    await Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false, // allow splash to remain under
        transitionDuration: Duration(milliseconds: 10),
        pageBuilder:
            (_, __, ___) => FullScreenVideoPage(controller: _videoController),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  void _waitForData() async {
    await Future.delayed(Duration(seconds: 3));
    while (_isDataStillLoading() || !_videoController.value.isInitialized) {
      await Future.delayed(Duration(milliseconds: 300));
    }
    _playIntroVideoAndNavigate();
  }

  bool _isDataStillLoading() {
    final userData = Provider.of<DataProvider>(context, listen: false).userData;
    final profiles = userData['Profiles'];
    if (profiles == null) return true;

    for (int i = 1; i <= 4; i++) {
      final profile = profiles['Profile_$i'];
      if (profile == null || profile['created'] == null) return true;
    }
    return false;
  }

  @override
  void dispose() {
    super.dispose();

    if (!_navigated) _videoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/intro.jpg"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

class FullScreenVideoPage extends StatefulWidget {
  final VideoPlayerController controller;

  const FullScreenVideoPage({required this.controller});

  @override
  _FullScreenVideoPageState createState() => _FullScreenVideoPageState();
}

class _FullScreenVideoPageState extends State<FullScreenVideoPage> {
  @override
  void initState() {
    super.initState();

    widget.controller.seekTo(Duration.zero);
    widget.controller.play();

    Future.delayed(Duration(seconds: 5), () {
      if (mounted) {
        widget.controller.pause();
        Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
      }
      Future.delayed(Duration(seconds: 2), () {
        widget.controller.dispose();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          widget.controller.value.isInitialized
              ? Center(
                child: SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: SizedBox(
                      width: widget.controller.value.size.width,
                      height: widget.controller.value.size.height,
                      child: VideoPlayer(widget.controller),
                    ),
                  ),
                ),
              )
              : Center(child: CircularProgressIndicator()),
    );
  }
}

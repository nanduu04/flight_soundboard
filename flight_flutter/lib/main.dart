import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flight/sounds.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flight Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'FredokaOne',
      ),
      home: MyHomePage(title: 'Flight Reacts Soundboard'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// Flight's Faces
  List<String> _headshots = [
    'assets/images/1.png',
     'assets/images/1.png',
      'assets/images/1.png',
       'assets/images/1.png',
        'assets/images/1.png',
    // 'assets/images/2.jpg',
    // 'assets/images/3.jpeg',
    // 'assets/images/4.jpg',
    // 'assets/images/5.jpeg',
  ];

  /// Flight's sounds
  final List _sound = FlightSounds().sounds;

  /// Audio Cache
  AudioCache audioCache;
  AudioPlayer audioPlayer;
  int indexIsPlaying;

  @override
  void initState() {
    super.initState();
    initSounds();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GridView.builder(
            shrinkWrap: true,
            itemCount: 15,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              crossAxisCount: 3,
            ),
            itemBuilder: (BuildContext context, int index) => GestureDetector(
              child: Center(
                child: AnimatedContainer(
                  width: indexIsPlaying == index ? 120 : 80,
                  height: indexIsPlaying == index ? 120 : 80,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.bounceOut,
                  decoration: BoxDecoration(
                    color: indexIsPlaying == index
                        ? Colors.red
                        : Colors.black,
                    borderRadius: new BorderRadius.circular(100.0),
                    image: new DecorationImage(
                      image: new AssetImage(_headshots[index % 5]),
                      fit: BoxFit.fill,
                    ),
                    border: new Border.all(
                        color: indexIsPlaying == index
                            ? Colors.black
                            : Colors.transparent,
                        width: 2.0,
                        style: BorderStyle.solid),
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        offset: Offset(0, 10.0),
                        blurRadius: 10.0,
                      )
                    ],
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text('${index + 1}'),
                  ),
                ),
              ),
              onTap: () {
                if (mounted) {
                  setState(() {
                    playSound(_sound[index]);
                    indexIsPlaying = index;
                  });
                }
              },
            ),
            padding: const EdgeInsets.all(20),
          ),
        ],
      ),
    );
  }

  void initSounds() async {
    audioPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: audioPlayer);
    audioCache.loadAll(_sound);
  }

  void playSound(sounds) async {
    var fileName = sounds;
    if (audioPlayer.state == AudioPlayerState.PLAYING) {
      audioPlayer.stop();
    }
    audioPlayer = await audioCache.play(fileName);
  }

  void stopSound(sounds) {
    audioPlayer.stop();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

// Этот код в Flutter используется для фиксации ориентации экрана приложения в портретном режиме
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  /*
    SystemChrome: Это класс из пакета flutter/services.dart, который предоставляет методы для управления системными настройками, такими как ориентация экрана, статус-бар и т.д.

    setPreferredOrientations: Этот метод позволяет задать список допустимых ориентаций для приложения. В данном случае мы передаем ему список, содержащий только портретную ориентацию экрана.

    Ограничение ориентации: После выполнения этого кода пользователь не сможет повернуть устройство в горизонтальное положение. Приложение будет всегда отображаться в портретном режиме, независимо от того, как пользователь держит устройств
   */

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Orientation Builder'),
        actions: [
          IconButton(
              onPressed: () {
                setPortraitAdLandscape();
              },
              icon: Icon(Icons.clear))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: OrientationBuilder(
          builder: (context, orientation) => orientation == Orientation.portrait
              ? buildPortrait()
              : buildLandscape(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final isPortrait =
              MediaQuery.of(context).orientation == Orientation.portrait;
          if (isPortrait) {
            setLandscape();
          } else {
            setPortrait();
          }
        },
        child: Icon(Icons.rotate_left),
      ),
    );
  }

  // set portrait
  Future<void> setPortrait() async =>
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

  // set landscape
  Future<void> setLandscape() async =>
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);

  // set portrait and landscape
/*
  allows the device to rotate between portrait and landscape orientations.
  Passes DeviceOrientation.values as an argument
  . This value represents a list of all possible device orientations,
   including both portrait and landscape modes.


   Enables device rotation: By setting the allowed orientations to all possible values, 
   the device can rotate freely between portrait and landscape modes.
 */
  Future setPortraitAdLandscape() =>
      SystemChrome.setPreferredOrientations(DeviceOrientation.values);

  // build portrait
  Widget buildPortrait() => ListView(
        children: [
          buildImage(),
          const SizedBox(
            height: 20,
          ),
          buildText(),
        ],
      );

  // build landscape
  Widget buildLandscape() => Row(
        children: [
          buildImage(),
          const SizedBox(
            width: 16,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: buildText(),
          ))
        ],
      );

  // build Image
  Widget buildImage() => Image.network(
      scale: 1,
      'https://img.etimg.com/thumb/width-420,height-315,imgsize-77302,resizemode-75,msid-115023620/tech/technology/elon-musk-is-about-to-find-out-what-130-million-for-trump-gets-him/will-elon-musks-1-million-a-day-lottery-shut-down-by-friday-heres-all-you-need-to-know.jpg');

  // build Text
  Widget buildText() => const Column(
        children: [
          Text(
            'Hair Styling',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '''The oldest known depiction of hair styling is hair braiding which dates back about 30,000 years. In history, women's hair was often elaborately and carefully dressed in special ways. From the time of the Roman Empire[citation needed] until the Middle Ages, most women grew their hair as long as it would naturally grow. Between the late 15th century and the 16th century, a very high hairline on the forehead was considered attractive. Around the same time period, European men often wore their hair cropped no longer than shoulder-length. In the early 17th century, male hairstyles grew longer, with waves or curls being considered desirable.''',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ],
      );
}

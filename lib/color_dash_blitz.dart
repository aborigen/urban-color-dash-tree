import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_yandex_games/flutter_yandex_games.dart';

class ColorDashBlitzGame extends StatefulWidget {
  const ColorDashBlitzGame({super.key});

  @override
  State<ColorDashBlitzGame> createState() => _ColorDashBlitzGameState();
}

class _ColorDashBlitzGameState extends State<ColorDashBlitzGame> {
  int _score = 0;
  int _highScore = 0;
  int _level = 1;
  int _timeLeft = 15;
  late String _targetColorName;
  late Color _targetColor;
  bool _isGameRunning = false;
  Timer? _timer;

  final Map<String, Color> _allColors = {
    'Red': Colors.red,
    'Green': Colors.green,
    'Blue': Colors.blue,
    'Yellow': Colors.yellow,
    'Orange': Colors.orange,
    'Purple': Colors.purple,
    'Pink': Colors.pink,
    'Teal': Colors.teal,
    'Cyan': Colors.cyan,
  };
  Map<String, Color> _currentColors = {};

  @override
  void initState() {
    super.initState();
    _initYandexGames();
    _nextRound();
  }

  Future<void> _initYandexGames() async {
    await YandexGames.init();
  }

  void _startGame() {
    setState(() {
      _score = 0;
      _level = 1;
      _timeLeft = 15;
      _isGameRunning = true;
    });
    _nextRound();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _isGameRunning = false;
          if (_score > _highScore) {
            _highScore = _score;
          }
          _timer?.cancel();
        }
      });
    });
  }

  void _nextRound() {
    final random = Random();
    int optionsCount = min(3 + _level, _allColors.length);

    final shuffledKeys = _allColors.keys.toList()..shuffle(random);
    final roundKeys = shuffledKeys.sublist(0, optionsCount);

    _currentColors = {
      for (var key in roundKeys) key: _allColors[key]!
    };

    _targetColorName = roundKeys[random.nextInt(roundKeys.length)];
    _targetColor =
        _currentColors.values.elementAt(random.nextInt(_currentColors.length));

    if (mounted) {
      setState(() {});
    }
  }

  void _checkAnswer(Color selectedColor) {
    if (_isGameRunning) {
      if (selectedColor == _allColors[_targetColorName]) {
        setState(() {
          _score++;
          if (_score > 0 && _score % 5 == 0) {
            _level++;
          }
        });
      }
      _nextRound();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Dash Blitz'),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        final bool isWide = constraints.maxWidth > 600;

        return Center(
          child: _isGameRunning
              ? _buildGameContent(context, isWide)
              : _buildGameOverContent(context),
        );
      }),
    );
  }

  Widget _buildGameContent(BuildContext context, bool isWide) {
    final gameWidgets = <Widget>[
      _buildGameInfo(context),
      _buildColorGrid(),
    ];

    return isWide
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: gameWidgets.map((w) => Expanded(child: w)).toList(),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center, children: gameWidgets);
  }

  Widget _buildGameInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Score: $_score',
                  style: Theme.of(context).textTheme.headlineSmall),
              Text('Level: $_level',
                  style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
          const SizedBox(height: 10),
          Text('High Score: $_highScore',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 20),
          Text(
            'Time Left: $_timeLeft',
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: Colors.red),
          ),
          const SizedBox(height: 40),
          Text(
            _targetColorName,
            style: TextStyle(
              color: _targetColor,
              fontSize: 48,
              fontWeight: FontWeight.bold,
              shadows: const [
                Shadow(
                  blurRadius: 3.0,
                  color: Colors.black45,
                  offset: Offset(2.0, 2.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: _currentColors.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final entry = _currentColors.entries.elementAt(index);
        return ElevatedButton(
          onPressed: () => _checkAnswer(entry.value),
          style: ElevatedButton.styleFrom(
              backgroundColor: entry.value,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              )),
          child: const Text(''),
        );
      },
    );
  }

  Widget _buildGameOverContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _highScore > 0 && _score > 0 ? 'Game Over!' : 'Welcome!',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        const SizedBox(height: 20),
        if (_score > 0 || _highScore > 0) ...[
          Text(
            'Your Score: $_score',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 10),
        ],
        Text(
          'High Score: $_highScore',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(
          height: 40,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            textStyle: Theme.of(context).textTheme.titleLarge,
          ),
          onPressed: _startGame,
          child: const Text('Play Again'),
        ),
      ],
    );
  }
}

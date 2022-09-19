import 'package:flutter/material.dart';
import 'package:quiz_app_template/quiz_brain.dart';

void main() {
  runApp(const PokemonQuiz());
}

class PokemonQuiz extends StatefulWidget {
  const PokemonQuiz({Key? key}) : super(key: key);

  @override
  State<PokemonQuiz> createState() => _PokemonQuizState();
}

class _PokemonQuizState extends State<PokemonQuiz> {

  int score = 0;
  QuizBrain quizBrain = QuizBrain();

  void checkAnswer(String pokemonName) {
    setState(() {
      if (quizBrain.getPokemonName() == pokemonName) {
        score++;
      }

      quizBrain.nextPokemon();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pokemon Quiz'),
        ),
        body: quizBrain.isQuizFinished()
            ? Center(child: Text('Fim do jogo! Você tem: $score pontos'))
            : Padding(
                padding: const EdgeInsets.all(10.0),
          child: Column(
            // cria uma coluna que ocupa todo o eixo secundário
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Expanded(
                child: Center(
                  child: Text('Que Pokémon é este?'),
                ),
              ),
              Expanded(
                flex: 4,
                child: Center(
                  child: Image.network(quizBrain.getPokemonImageUrl()),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                      onPressed: () { checkAnswer('Squirtle'); },
                    child: const Text('Squirtle'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                      onPressed: () { checkAnswer('Caterpie'); },
                    child: const Text('Caterpie'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                      onPressed: () { checkAnswer('Bulbasaur'); },
                    child: const Text('Bulbasaur'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                      onPressed: () { checkAnswer('Charmander'); },
                    child: const Text('Charmander'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


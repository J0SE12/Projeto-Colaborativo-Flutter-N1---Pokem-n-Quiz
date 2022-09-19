import 'pokemon.dart';

class QuizBrain {
  final List<Pokemon> _pokemonList = [
    Pokemon('Bulbasaur', 'https://www.serebii.net/pokemongo/pokemon/001.png'),
    Pokemon('Charmander', 'https://www.serebii.net/pokemongo/pokemon/004.png'),
    Pokemon('Squirtle', 'https://www.serebii.net/pokemongo/pokemon/007.png'),
    Pokemon('Caterpie', 'https://www.serebii.net/pokemongo/pokemon/010.png'),
  ];

  int _current = 0;

  void nextPokemon() {
    if (_current < _pokemonList.length) {
      _current++;
    }
  }

  String getPokemonImageUrl() {
    return _pokemonList[_current].imgUrl;
  }

  String getPokemonName() {
    return _pokemonList[_current].name;
  }

  bool isQuizFinished() {
    return _current >= _pokemonList.length;
  }

}


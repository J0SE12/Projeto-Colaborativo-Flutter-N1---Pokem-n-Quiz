# Pokemon Quiz

Um Quiz Pokemon (dummy, por enquanto...). Esta atividade vale 2 pontos para a N1. Pode ser feito em duplas.

## Começando

Abra o arquivo `main.dart`. Crie um **Stateful Widget** (dica: digite stful). O nome da classe
deverá ser `PokemonQuiz`.

Na função run, adicione a linha: `runApp(const PokemonQuiz());`. Com ela, você conseguirá executar seu projeto. Execute o projeto para certificar-se de que tudo funciona. (Você deve ver uma tela preta).


## Criando o leiaute

Substitua a linha `return Container()` por:
```dart
return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pokemon Quiz'),
        ),
        body: Padding(
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
                  child: Image.network(
                      'https://www.serebii.net/pokemongo/pokemon/001.png'),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Resposta 1'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Resposta 2'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Resposta 3'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Resposta 4'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
```

Execute o código e verifique que você tem uma tela com um pokemon e 4 botões. Assim a interface está pronta e agora devemos preparar o código do quiz.

## Criando a classe Pokemon

Crie um novo arquivo: `pokemon.dart` e nele, crie uma classe Pokemon, que conterá a informação de cada 
Pokémon:

```dart
class Pokemon {
  final String imgUrl;
  final String name;

  Pokemon(this.name, this.imgUrl);
}
```

## Criando a classe QuizBrain

Agora criaremos a classe QuizBrain, que conterá as informações para a execução do quiz. Crie um arquivo
`quiz_brain.dart` e insira o conteúdo a seguir:

```dart
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
}

```

Como no exemplo anterior, aqui criamos uma lista de pokemons (estáticos, por enquanto, no futuro serão
dinâmicos) e métodos para que possamos manipular essa lista.


## Vinculando as classes QuizBrain, Pokemon com a tela principal

Agora, assim como no último super quiz, vamos vincular criar, **dentro da classe `_PokemonQuizState`** (logo abaixo da declaração da classe) uma variável inteira que conterá a pontuação. Ela começa com 0 pois ainda não há nenhum ponto registrado:

```dart
int score = 0;
```

A seguir (logo abaixo) instanciamos a classe `QuizBrain`:
```dart
QuizBrain quizBrain = QuizBrain();
```

Lembre-se de importar, se necessário, o arquivo quiz_brain.dart, no **início** do seu código:
```dart
import 'quiz_brain.dart';
```

### Implementando a "ação" dos botões

Por fim, logo abaixo da instanciação da QuizBrain, vamos criar o método que verifica as respostas.
Esse método vai receber o nome do pokemon por parâmetro (aquele que está no botão) e vai comparar com o nome do pokemon atual, incrementando um ponto em caso positivo e nada, em caso negativo:

```dart
  void checkAnswer(String pokemonName) {
    setState(() {
      if (quizBrain.getPokemonName() == pokemonName) {
        score++;
      }

      quizBrain.nextPokemon();
    });
  }
```

Note a presença de `setState`. Ela é necessária para que o aplicativo saiba que houve mudanças no estado e atualize todos os widgets, caso seja necessário.

### Últimos ajustes

Agora faremos com que os botões acionem `checkAnswer` quando forem pressionados. Para isso, no código de cada `RaisedButton`, onde há: `onPressed: () { }` substitua por: `onPressed: () { checkAnswer('Bulbasaur'); }`. **IMPORTANTE**: vocë deve substituir `<NOME>` pelo nome do pokemon listado no botão.

Por fim, altere a url *hardcoded* do bulbasaur (em `Image.network(...)`) por: `quizBrain.getPokemonImageUrl()`.


## Mostrando a pontuação.

Para mostrar a pontuação, criaremos uma condição de parada. Primeiro, na classe `QuizBrain`, criamos um novo método: `isQuizFinished`, que verificará se o contador pode ser incrementado. Em caso negativo, a resposta do método será true, o que significa que o quiz acabou.

```dart
  bool isQuizFinished() {
    return _current >= _pokemonList.length;
  }
```

Agora, de novo no `main.dart`, logo abaixo do `appBar`, no `body`, devemos incluir uma condição ternária.
Aquelas da forma: `condição ? código se verdadeiro : código se falso`. A condição deverá executar assim. Antes do `Padding`, acrescente a condição ternária: `quizBrain.isQuisFinished() ? Center(...) : ...`
de forma que seu código ficará assim:

```dart
body: quizBrain.isQuizFinished()
            ? Center(child: Text('Fim do jogo! Você tem: $score pontos'))
            : Padding(....
```

Ou seja. Quando o quiz terminar, uma mensagem será mostrada para o usuário, informando seu score.


## Término e entrega

Faça um *push* para o seu repositório gerado. O professor receberá automaticamente a informação de entrega.

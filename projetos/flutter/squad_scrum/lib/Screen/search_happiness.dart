import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SearchHappiness extends StatefulWidget {
  const SearchHappiness({Key? key}) : super(key: key);

  @override
  State<SearchHappiness> createState() => _SearchHappinesState();
}

class _SearchHappinesState extends State<SearchHappiness> {
  double _userRating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesquisa Satisfação'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Informe Algo que Represente a Sua Personalidade na Sprint!',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          const TextField(
            style: TextStyle(fontSize: 15),
            decoration: InputDecoration(
              hintText: 'Resposta',
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          const Text(
            'Sua Nota Para Pessoas?',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),

          RatingBarIndicator(
            rating: _userRating,
            itemBuilder: (context, index) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemCount: 5,
            itemSize: 50.0,
            unratedColor: Colors.amber.withAlpha(50),
            //direction: _isVertical ? Axis.vertical : Axis.horizontal,
          ),

          TextFormField(
            keyboardType: TextInputType.number,
            onChanged: (text){
              _userRating = text == '' ? 0 : double.parse(text);
              setState(() {});
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              //hintText: 'Enter rating',
              labelText: 'Resposta',
            ),
          ),

          // RatingBar.builder(
          //   initialRating: 0,
          //   minRating: 1,
          //   itemCount: 5,
          //   itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          //   itemBuilder: (context, _) => const Icon(
          //     Icons.star,
          //     color: Colors.amber,
          //   ),
          //   onRatingUpdate: (rating) {
          //     print(rating);
          //   },
          // ),
          const SizedBox(
            height: 20,
          ),

          const Text(
            'Sua Nota Para Metodologia?',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          RatingBar.builder(
            initialRating: 0,
            minRating: 1,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
          const SizedBox(
            height: 20,
          ),

          const Text(
            'Sua Nota Para Ferramentas?',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          RatingBar.builder(
            initialRating: 0,
            minRating: 1,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
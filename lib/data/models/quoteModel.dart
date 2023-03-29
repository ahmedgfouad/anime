import 'package:flutter/foundation.dart';

class QuoteModel {
  final String anime;
  final String character;
  final String quote;
  QuoteModel({
   required this.anime,
   required this.character,
   required this.quote,
  });

  factory QuoteModel.fromJson(Map<String,dynamic> json){
    return QuoteModel(
        anime:  json['anime'],
        character:  json['character'],
        quote:  json['quote'],
    );
  }

  Map<String,dynamic>toJson(){
    return {
      'anime' : anime ,
      'character' : character ,
      'quote' : quote ,
    };
  }
}

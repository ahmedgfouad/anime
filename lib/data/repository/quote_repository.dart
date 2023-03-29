import 'package:anime/api_const.dart';
import 'package:anime/data/data_resource/api_service.dart';

import '../models/quoteModel.dart';

class QuoteRepository{
  final apiService =ApiService();

  Future<QuoteModel> getRandomQuote()async{
    final response =await apiService.getData(ApiConstants.getRandomQuotePath);
    return QuoteModel.fromJson(response.data);
  }

  Future<QuoteModel> getRandomQuoteByTitle({required String title})async{
    final response =await apiService.getData(ApiConstants.getRandomQuoteByTitlePath,queryParams: {'title': title});
    return QuoteModel.fromJson(response.data);
  }

  Future<QuoteModel> getRandomQuoteByCharacter({required String name})async{
    final response =await apiService.getData(ApiConstants.getRandomQuoteByCharacterPath,queryParams: {'name' : name});
    return QuoteModel.fromJson(response.data);
  }

  Future<List<QuoteModel>> getTenRandomQuote()async{
    final response =await  apiService.getData(ApiConstants.getTenRandomQuotePath);
   return (response.data as List).map((e) => QuoteModel.fromJson(e)).toList();
  }

  Future<List<QuoteModel>> getTenQuoteByTitle({required String title})async{
    final response =await apiService.getData(ApiConstants.getTenQuoteByTitlePath,queryParams: {'title':title});
    return (response.data as List).map((e) => QuoteModel.fromJson(e)).toList();
  }

  Future<List<QuoteModel>> getTenQuotesByCharacter({required String name})async{
    final response = await apiService.getData(ApiConstants.getTenQuoteByCharacterPath,queryParams: {'name': name});
    return (response.data as List).map((e) => QuoteModel.fromJson(e)).toList();
  }

}
import 'package:anime/data/repository/quote_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../data/data_resource/api_service.dart';
import '../data/models/quoteModel.dart';

class ApiScreen extends StatefulWidget {
  const ApiScreen({Key? key}) : super(key: key);

  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {

  TextEditingController controller =TextEditingController();
  final  quoteRepository =QuoteRepository();
    List<QuoteModel> data_OfRandomQuote=[];
    List<QuoteModel> data_OfRandomQuoteByTitle=[];
    List<QuoteModel> data_OfRandomQuoteByCharacter=[];
    List<QuoteModel> data_OfTenRandomQuotes=[];
    List<QuoteModel> data_OfTenQuotesByTitle=[];
    List<QuoteModel> data_OfTenQuotesByCharacter=[];
    bool isLoading= true ;
    
    void searchByTitle(String title)async{
      data_OfTenQuotesByTitle =data_OfTenQuotesByTitle.where((element) => element.anime.toLowerCase().contains(title.toLowerCase())).toList();
      setState(() {});
    }
   @override
  void initState() {
    getRequest(controller.text);
    super.initState();
  }

  void getRequest(String text)async{
     var dataOfRandomQuote =await quoteRepository.getRandomQuote();
     data_OfRandomQuote.add(dataOfRandomQuote);

     var dataOfRandomQuoteByTitle =await quoteRepository.getRandomQuoteByTitle(title: 'Bleach');
     data_OfRandomQuoteByTitle.add(dataOfRandomQuoteByTitle);

     var dataOfRandomQuoteByCharacter= await quoteRepository.getRandomQuoteByCharacter(name: 'saitama');
     data_OfRandomQuoteByCharacter.add(dataOfRandomQuoteByCharacter);

      data_OfTenRandomQuotes= await quoteRepository.getTenRandomQuote();

      data_OfTenQuotesByTitle =await quoteRepository.getTenQuoteByTitle(title: text);

      data_OfTenQuotesByCharacter =await quoteRepository.getTenQuotesByCharacter(name: 'Saber');

     setState(() {
       isLoading =false;
     });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: isLoading ?const Center(child: CircularProgressIndicator(),) :
      Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: controller,

                decoration: InputDecoration(
                  hintText: "Search",
                 enabledBorder: OutlineInputBorder(
                   borderSide: BorderSide(
                      width: .3,
                   ),
                 ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: (){
                      searchByTitle(controller.text);
                    },
                  ),
                ),
              ),
              SizedBox(height: 20,),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context,index)=>const SizedBox(height: 10,),
                itemCount: data_OfTenRandomQuotes.length,
                itemBuilder: (context ,index)=>Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.lightBlueAccent
                    )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Anime Name ',style: TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.bold),),
                          Text(data_OfTenRandomQuotes[index].anime,style: const TextStyle(color: Colors.red,fontSize: 15,fontWeight: FontWeight.w400)),
                        ],
                      ),
                      const SizedBox(height: 5,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Character Name ',style: TextStyle(color: Colors.blue,fontSize: 17,fontWeight: FontWeight.bold)),
                          Text(data_OfTenRandomQuotes[index].character,style: const TextStyle(color: Colors.red,fontSize: 15,fontWeight: FontWeight.w400)),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      const Text('Quote  ',style: TextStyle(color: Colors.blue,fontSize: 17,fontWeight: FontWeight.bold)),
                     ReadMoreText(
                       data_OfTenRandomQuotes[index].quote,
                       trimLines: 3,
                       colorClickableText: Colors.pink,
                       trimMode: TrimMode.Line,
                       trimCollapsedText: '   Read more',
                       moreStyle: const TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),
                       trimExpandedText: '  Show less',
                       lessStyle: const TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),
                     ),
                    ],
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

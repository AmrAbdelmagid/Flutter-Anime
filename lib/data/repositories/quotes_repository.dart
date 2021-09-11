// import 'package:flutter_bloc_dio_practice/data/models/quote.dart';
// import 'package:flutter_bloc_dio_practice/data/services/quotes_web_services.dart';

// class QuoteRepository {
//   final QuoteWebServices quoteWebServices;

//   QuoteRepository(this.quoteWebServices);

//   Future<String> fetchRandomQuote() async {
//     final quote = await quoteWebServices.getRandomQuote();
//     Quote? myQuote;
//     String? finalQuote = quote['content'];
//     finalQuote = myQuote!.quote;
//     return finalQuote as Future<String>;
//   }
// }

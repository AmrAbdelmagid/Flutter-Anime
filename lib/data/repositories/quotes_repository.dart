import 'package:flutter_bloc_dio_practice/data/models/quote.dart';
import 'package:flutter_bloc_dio_practice/data/services/quotes_web_services.dart';

class QuoteRepository {
  final QuoteWebServices quoteWebServices;

  QuoteRepository(this.quoteWebServices);

  Future<Quote?> fetchRandomQuote() async {
    final quote = await quoteWebServices.getRandomQuote();
    return quote;
  }
}

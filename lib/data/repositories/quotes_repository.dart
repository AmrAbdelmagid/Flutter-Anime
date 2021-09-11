import '../models/quote.dart';
import '../services/quotes_web_services.dart';

class QuoteRepository {
  final QuoteWebServices quoteWebServices;

  QuoteRepository(this.quoteWebServices);

  Future<Quote?> fetchRandomQuote() async {
    final quote = await quoteWebServices.getRandomQuote();
    return quote;
  }
}

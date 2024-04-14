import 'dart:convert';
import 'dart:math';

import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:finsec/features/profile/transfer/family_sheets/papa_sheet_1.dart';
import 'package:finsec/features/sni/candle_sticks.dart';
import 'package:finsec/features/sni/finsec_dada.dart';
import 'package:finsec/logic/stores/state_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:marqueer/marqueer.dart';
import 'package:provider/provider.dart';
import 'package:pull_down_button/pull_down_button.dart';

import 'stock.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({
    super.key,
  });

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class NewsArticle {
  final String title;
  final String description;
  final String urlToImage;

  NewsArticle({required this.title, required this.description, required this.urlToImage});

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? 'title',
      description: json['description'] ?? 'desc',
      urlToImage: json['urlToImage'] ?? 'https://source.unsplash.com/random/200x100',
    );
  }
}

class _StockScreenState extends State<StockScreen> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  double _searchBarHeight = 35;
  int _offset = 0;
  double _opacityRate = 1;
  double _bottomSheetInitialRate = 0.2;
  bool _marqueeVisible = true;
  StockList _stockList = StockList(data: [Stock(open: 0.0, high: 0.0, low: 0.0, last: 0.0, close: 0.0, volume: 0, date: 0, symbol: 0, exchange: 0)]);
  final controller = DraggableScrollableController();
  List<NewsArticle> _newsArticles = [];

  @override
  void initState() {
    fetchNews();
    _fetchStocks();
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      _searchBarHeight = (35 - _scrollController.offset) > 0 ? (35 - _scrollController.offset) : 0;

      _offset = _scrollController.offset.round();
      _opacityRate = min(max(1 - (_offset / 10), 0), 1);

      if (_offset > 0) FocusScope.of(context).unfocus();

      setState(() {});
    });
  }

  Future<void> _fetchStocks() async {
    final data = await rootBundle.load("assets/data.json");
    final map = json.decode(
      utf8.decode(
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
      ),
    );

    setState(() {
      _stockList = StockList.fromJson(map);
      // print(stockListToJson(_stockList));
    });
    // for (int i = 0; i < 10; i++) {
    //   var stock = _stockList.data[i];
    //   var stockData = await fetchStockData(stock.symbol);
    //   setState(() {
    //     _stockList.data[i].open = stockData['open'];
    //     _stockList.data[i].high = stockData['high'];
    //     _stockList.data[i].low = stockData['low'];
    //     _stockList.data[i].last = stockData['last'];
    //     _stockList.data[i].close = stockData['close'];
    //   });
    // }
    for (var stock in _stockList.data) {
      final response = await http.get(Uri.parse('https://api.finnworlds.com/api/v1/consensusratings?key=4140951ded734e69aa5e9e986dc7651e&ticker=${stock.symbol}'));

      if (response.statusCode == 200) {
        print(response.body);
        var data = jsonDecode(response.body);
        var buyRating = data['buy'];
        var holdRating = data['hold'];
        var sellRating = data['sell'];
        setState(() {
          stock.buyRating = buyRating ?? 65;
          stock.holdRating = holdRating ?? 26;
          stock.sellRating = sellRating ?? 9;
        });
      }
    }
  }

  Future<Map<String, dynamic>> fetchStockData(String symbol) async {
    final response = await http
        .get(Uri.parse('https://query1.finance.yahoo.com/v8/finance/chart/$symbol?region=IN&lang=en-US&comparisons=&includePrePost=false&useYfid=truecorsDomain=finance.yahoo.com&.tsrc=finance'));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var quoteResponse = jsonResponse['chart'];
      var result = quoteResponse['result'][0]['meta'];

      return {
        'open': result['regularMarketPrice'] ?? 0.0,
        'high': result['regularMarketDayHigh'] ?? 0.0,
        'low': result['regularMarketDayLow'] ?? 0.0,
        'last': result['chartPreviousClose'] ?? 0.0,
        'close': result['previousClose'] ?? 0.0,
      };
    } else {
      throw Exception('Failed to load stock data');
    }
  }

  Future<void> fetchNews() async {
    final response = await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?category=business&country=in&apiKey=4140951ded734e69aa5e9e986dc7651e'));
    var jsonResponse = jsonDecode(response.body);
    var articles = jsonResponse['articles'];
    for (var article in articles) {
      if (article['urlToImage'] != null && article['description'] != null && article['title'] != null) _newsArticles.add(NewsArticle.fromJson(article));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bottomSheetInitialRate = 120 / MediaQuery.of(context).size.height;
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Stack _buildBody() {
    return Stack(
      children: [
        Listener(
          behavior: HitTestBehavior.translucent,
          onPointerUp: (e) {
            if (_scrollController.offset < 28 && _scrollController.offset > 0) {
              _scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.fastOutSlowIn,
              );
            } else if (_scrollController.offset >= 28 && _scrollController.offset < 56) {
              _scrollController.animateTo(
                56,
                duration: const Duration(milliseconds: 200),
                curve: Curves.fastOutSlowIn,
              );
            }
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                toolbarHeight: 35,
                centerTitle: false,
                titleSpacing: 15,
                title: SizedBox(
                  height: 35,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: min(35, _searchBarHeight),
                        child: CupertinoSearchTextField(
                          backgroundColor: const Color.fromARGB(255, 29, 29, 31),
                          itemColor: const Color.fromARGB(255, 146, 146, 146).withOpacity(_opacityRate),
                          placeholderStyle: TextStyle(
                            color: Colors.grey.withOpacity(_opacityRate),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                elevation: 0.0,
              ),
              SliverPadding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    children: [
                      PullDownButton(
                        itemBuilder: (context) => [
                          PullDownMenuItem(
                            onTap: () {},
                            title: 'My Symbols',
                          ),
                          const PullDownMenuDivider.large(),
                          PullDownMenuItem(
                            title: 'New List',
                            onTap: () {},
                            icon: CupertinoIcons.add,
                          ),
                        ],
                        animationBuilder: null,
                        position: PullDownMenuPosition.automatic,
                        buttonBuilder: (context, showMenu) => GestureDetector(
                          onTap: showMenu,
                          child: Row(
                            children: [
                              Text(
                                "Recommended",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const Icon(
                                CupertinoIcons.chevron_up_chevron_down,
                                size: 20,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 15,
                ),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    height: 80,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const Divider(
                        height: 1,
                      ),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    _stockList.data[index].symbol.toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Volume: ${_stockList.data[index].volume.toString()}",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 15,
                  bottom: 150,
                ),
                sliver: SliverList.separated(
                  separatorBuilder: (context, index) => const Divider(
                    height: 1,
                  ),
                  itemBuilder: (c, i) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    height: 54,
                    child: GestureDetector(
                      onTap: () {
                        StateStore().change(i);
                        animatedHide();
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${_stockList.data[i].symbol}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${_stockList.data[i].exchange}",
                                  style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 80,
                            height: 40,
                            child: Sparkline(
                              data: [
                                _stockList.data[i].open ?? 0.0,
                                _stockList.data[i].high ?? 0.0,
                                _stockList.data[i].low ?? 0.0,
                                _stockList.data[i].last ?? 0.0,
                                _stockList.data[i].close ?? 0.0,
                              ],
                              lineColor: _stockList.data[i].close > _stockList.data[i].open ? const Color.fromARGB(255, 52, 199, 89) : Colors.red,
                              fillMode: FillMode.below,
                              lineWidth: 1.5,
                              gridLineLabelColor: _stockList.data[i].close > _stockList.data[i].open ? const Color.fromARGB(255, 52, 199, 89) : Colors.red,
                              averageLine: true,
                              averageLabel: false,
                              fillGradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [_stockList.data[i].close > _stockList.data[i].open ? const Color.fromARGB(255, 52, 199, 89) : Colors.red, Colors.transparent],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 110,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "₹${_stockList.data[i].open}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Container(
                                  width: 75,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: _stockList.data[i].close > _stockList.data[i].open ? const Color.fromARGB(255, 52, 199, 89) : Colors.red,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    _stockList.data[i].close > _stockList.data[i].open
                                        ? "+${(_stockList.data[i].close - _stockList.data[i].open).toStringAsFixed(2)}"
                                        : "-${(-_stockList.data[i].close + _stockList.data[i].open).toStringAsFixed(2)}",
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                      ),
                    ),
                  ),
                  itemCount: _stockList.data.length,
                ),
              )
            ],
          ),
        ),
        _buildPersistentSheet(),
        _buildDetailSheet(),
      ],
    );
  }

  NotificationListener<DraggableScrollableNotification> _buildDetailSheet() {
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (DraggableScrollableNotification dsNotification) {
        // print("${dsNotification.extent}");
        if (dsNotification.extent > 0.99) {
          _marqueeVisible = false;
        } else {
          _marqueeVisible = true;
          _marqueeVisible = true;
        }
        setState(() {});
        return true;
      },
      child: DraggableScrollableSheet(
        controller: controller,
        minChildSize: 0,
        snap: true,
        initialChildSize: 0,
        maxChildSize: 1,
        builder: ((context, scrollController) => Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 28, 28, 30),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(15),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        const Divider(),
                        Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _stockList.data[context.read<StateStore>().getIdx()].exchange.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "CCC * USD",
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(),
                        SizedBox(
                          width: double.infinity,
                          child: CupertinoSlidingSegmentedControl<int>(
                            backgroundColor: Colors.transparent,
                            thumbColor: const Color.fromARGB(255, 114, 114, 114),
                            groupValue: 1,
                            onValueChanged: (int? value) {},
                            children: const <int, Widget>{
                              0: Text(
                                '1G',
                                style: TextStyle(color: CupertinoColors.white),
                              ),
                              1: Text(
                                '1H',
                                style: TextStyle(color: CupertinoColors.white),
                              ),
                              2: Text(
                                '1A',
                                style: TextStyle(color: CupertinoColors.white),
                              ),
                              3: Text(
                                '3A',
                                style: TextStyle(color: CupertinoColors.white),
                              ),
                              4: Text(
                                '6A',
                                style: TextStyle(color: CupertinoColors.white),
                              ),
                              5: Text(
                                'S1Y',
                                style: TextStyle(color: CupertinoColors.white),
                              ),
                              6: Text(
                                '1Y',
                                style: TextStyle(color: CupertinoColors.white),
                              ),
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(width: double.infinity, height: 250, child: CandleSticks(code: _stockList.data[context.watch<StateStore>().getIdx()].symbol.toString(), name: "")),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 100,
                          child: ListView.separated(
                            separatorBuilder: (context, i) => Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                width: 1,
                                height: 50,
                                color: const Color.fromARGB(255, 71, 71, 71),
                              ),
                            ),
                            itemCount: 15,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => SizedBox(
                              width: 120,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8.0),
                                        child: Text(
                                          'Open',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8.0),
                                        child: Text(
                                          _stockList.data[context.read<StateStore>().getIdx()].open.toString(),
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
                                        child: Text(
                                          'High',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
                                        child: Text(
                                          _stockList.data[context.read<StateStore>().getIdx()].high.toString(),
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white, // Beyaz renk
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
                                        child: Text(
                                          'Low',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.grey, // Gri renk
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
                                        child: Text(
                                          _stockList.data[context.read<StateStore>().getIdx()].low.toString(),
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/dad.png',
                                    height: 70,
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          isDismissible: false,
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          elevation: 0,
                                          context: context,
                                          builder: (context) => Container(
                                                height: MediaQuery.of(context).size.height * 0.68,
                                                child: PapaSheet(pageController: PageController(),),
                                              ));
                                    },
                                    child: Text(
                                      'Papa Kehte Hai',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: _stockList.data[context.read<StateStore>().getIdx()].buyRating ?? 65,
                                      child: Container(
                                        height: 10,
                                        color: Colors.green,
                                      ),
                                    ),
                                    Expanded(
                                      flex: _stockList.data[context.read<StateStore>().getIdx()].holdRating ?? 26,
                                      child: Container(
                                        height: 10,
                                        color: Colors.yellow,
                                      ),
                                    ),
                                    Expanded(
                                      flex: _stockList.data[context.read<StateStore>().getIdx()].sellRating ?? 9,
                                      child: Container(
                                        height: 10,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text('Buy: ${_stockList.data[context.read<StateStore>().getIdx()].buyRating}'),
                                  Text('Hold: ${_stockList.data[context.read<StateStore>().getIdx()].holdRating}'),
                                  Text('Sell: ${_stockList.data[context.read<StateStore>().getIdx()].sellRating}'),
                                ],
                              ),
                              Text('Expected Returns: 15.4%'),
                              Text(
                                'Based on reviews of 4 analysts over the last year',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.yellow),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            'Long Term Status',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Neutral",
                                            style: TextStyle(
                                              color: Colors.yellow,
                                            ),
                                          ), // replace with your data
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.red,
                                        ),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            'Short Term Status',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Negative",
                                            style: TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              child: Row(
                                children: [
                                  Text(
                                    "Ask Dadu",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                //AutoRouter.of(context).push(ChatScreenRoute(topic: _stockList.data[context.read<StateStore>().getIdx()].symbol));
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatScreen(
                                      topic: "I want to invest in ${_stockList.data[context.read<StateStore>().getIdx()].symbol}",
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _stockList.data[context.read<StateStore>().getIdx()].symbol,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: const OverflowBox(
                          maxWidth: 35,
                          maxHeight: 35,
                          child: Icon(
                            CupertinoIcons.ellipsis_circle_fill,
                            color: Color.fromARGB(255, 51, 51, 51),
                            size: 35,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: const Color.fromARGB(255, 178, 178, 178),
                        ),
                        child: const OverflowBox(
                          maxWidth: 35,
                          maxHeight: 35,
                          child: Icon(
                            CupertinoIcons.xmark_circle_fill,
                            color: Color.fromARGB(255, 51, 51, 51),
                            size: 35,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }

  SizedBox _buildPersistentSheet() {
    return SizedBox.expand(
      child: NotificationListener<DraggableScrollableNotification>(
        onNotification: (DraggableScrollableNotification dsNotification) {
          // print("${dsNotification.extent}");
          if (dsNotification.extent > 0.99) {
            _marqueeVisible = false;
          } else {
            _marqueeVisible = true;
          }
          setState(() {});
          return true;
        },
        child: DraggableScrollableSheet(
          minChildSize: _bottomSheetInitialRate,
          initialChildSize: 0.5,
          snap: true,
          snapSizes: const [
            0.5,
          ],
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 28, 28, 30),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 35,
                            height: 5,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 100, 100, 100),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Business News",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const Text(
                        "From News Api",
                        style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 152, 152, 159), fontWeight: FontWeight.w500, height: 1.5),
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _newsArticles.length,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 3.0,
                            color: const Color.fromARGB(255, 45, 45, 45),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 120.0,
                                  height: 120.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(_newsArticles[index].urlToImage),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          _newsArticles[index].title,
                                          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          _newsArticles[index].description,
                                          style: TextStyle(fontSize: 14.0, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return _marqueeVisible
        ? AppBar(
            automaticallyImplyLeading: false,
            titleSpacing: 15,
            centerTitle: false,
            toolbarHeight: 70,
            actions: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: const OverflowBox(
                    maxWidth: 30,
                    maxHeight: 30,
                    child: Icon(
                      CupertinoIcons.ellipsis_circle_fill,
                      color: Color.fromARGB(255, 28, 28, 30),
                      size: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
            ],
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Text(
                  DateFormat('MMMM dd').format(DateTime.now()),
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 25,
                    color: Colors.white,
                    height: 1,
                  ),
                ),
              ],
            ),
            elevation: 0,
          )
        : AppBar(
            toolbarHeight: 70,
            title: SizedBox(
              height: 60,
              child: Marqueer.builder(
                itemCount: 200,
                itemBuilder: (context, i) {
                  return SizedBox(
                    width: 200,
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${_stockList.data[i % 12].symbol}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              "₹${_stockList.data[i % 12].high}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const Text(
                              "+2.49",
                              style: TextStyle(
                                color: Color.fromARGB(255, 52, 199, 89),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 60,
                          height: 50,
                          child: Sparkline(
                            data: [
                              _stockList.data[0].open ?? 0.0,
                              _stockList.data[0].high ?? 0.0,
                              _stockList.data[0].low ?? 0.0,
                              _stockList.data[0].last ?? 0.0,
                              _stockList.data[0].close ?? 0.0,
                            ],
                            lineColor: const Color.fromARGB(255, 52, 199, 89),
                            fillMode: FillMode.below,
                            lineWidth: 1.5,
                            averageLine: true,
                            averageLabel: false,
                            fillGradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color.fromARGB(255, 52, 199, 89), Colors.transparent],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
  }

  void animatedHide() {
    controller.animateTo(
      1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}

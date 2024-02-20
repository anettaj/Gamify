import 'package:flutter/material.dart';
import 'package:gamify/data.dart';

import '../widget/scrollable_games_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var H;
  var W;
  var _selectedGame;

  @override
  void initState(){
    super.initState();
    _selectedGame=0;
  }
  @override
  Widget build(BuildContext context) {
    H=MediaQuery.of(context).size.height;
    W=MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            featuredGameWidget(),
            gradiantBoxWidget(),
            topLayerWidget()

          ],
        ),
      )
    );
  }

  Widget featuredGameWidget(){
    return SizedBox(
      height: H*0.5,
      width: W,
      child:PageView(
        onPageChanged: (_index){
          setState(() {
            _selectedGame=_index;
            print("index:$_index");
          });
        },
        scrollDirection: Axis.horizontal,
        children: featuredGames.map((_game){
          return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(_game.coverImage.url)
                  )
              ));
        }).toList(),)
        
    );
  }


  Widget gradiantBoxWidget(){
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: H*1.03,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors:[
                Color.fromRGBO(35, 45, 59, 1.0),
                Colors.transparent

              ],
              stops: [0.65,1.0],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter
          )
        ),
      ),
    );
  }

  Widget topLayerWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: H *0.02,vertical: H*0.001 ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          _topBarWidget(),
          SizedBox(
            height: H*0.15,
          ),
          _featuredGameInfoWidget(),
          ScrollableGamesWidget(height: H*0.24,width: W,showTitle: true,gameData: games,),
          _featuredGameBannerWidget(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: H *0.01),
            child: ScrollableGamesWidget(height: H*0.22,width: W,showTitle: false,gameData: games2,),
          ),
        ],
      ),
    );
  }
    Widget _topBarWidget(){
      return SizedBox(
        height: H*0.13,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.menu,
                color: Colors.white,
                size: 30,
              ),
              Row(
                children: [
                  Icon(Icons.search,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(
                    width: W *0.03,
                  ),
                  Icon(Icons.notifications,
                    color: Colors.white,
                    size: 30,
                  ),
                ],
              )
            ],
          ),
      );
    }
    Widget _featuredGameInfoWidget(){
    return SizedBox(
      height: H*0.14,
      width: W,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(featuredGames[_selectedGame].title,

          style: TextStyle(
            color: Colors.white,
            fontSize: H*0.040,
            fontWeight: FontWeight.bold
          ),
            maxLines: 2,
          ),
          SizedBox(
            height: H*0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: featuredGames.map((_games){
              bool _isActive=_games.title  == featuredGames[_selectedGame].title;
              double _circleRadius=H*0.004;
              return Container(
                margin: EdgeInsets.only(
                  right: W *0.010,
                ),
                height: _circleRadius*2,
                width: _circleRadius*2,
                decoration: BoxDecoration(
                  color: _isActive? Colors.blue:Colors.grey,
                  borderRadius: BorderRadius.circular(100)
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
    }
    Widget _featuredGameBannerWidget(){
    return Container(
      height: H*0.13,
      width: W,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
          fit: BoxFit.cover,
            image: NetworkImage(featuredGames[3].coverImage.url)
        )
      ),
    );
    }

  }

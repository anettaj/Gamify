import 'package:flutter/material.dart';
import 'package:gamify/data.dart';
class ScrollableGamesWidget extends StatelessWidget {
  final double height;
  final double width;
  final bool showTitle;
  final List<Game> gameData;

   ScrollableGamesWidget({
    Key?key,
    required this.height,
    required this.width,
    required this.showTitle,
    required this.gameData
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: gameData.map((_game){
          return Container(
            height: height,
            width: width*0.30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(right: width*0.03),
                  height: height*0.80,
                  width: width*0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: NetworkImage(_game.coverImage.url),
                      fit: BoxFit.cover
                    )
                  ),
                ),
                showTitle? Text(_game.title,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: height*0.08
                  ),
                ):Container()
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

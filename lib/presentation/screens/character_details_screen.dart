import 'package:breaking/constants/colors.dart';
import 'package:breaking/data/models/charactersModel.dart';
import 'package:flutter/material.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final CharacterModel character;
  const CharacterDetailsScreen({super.key, required this.character});

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      stretch: true,
      pinned: true,
      backgroundColor: MyColors.mygray,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.name ,
          style: TextStyle(
            height: 1.3,
            fontSize: 22,
            color: MyColors.mygray,
            fontWeight: FontWeight.bold,
              fontFamily: "WubbaLubbaDubDub"
          ),

          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          textAlign: TextAlign.start,

        ),
        background: Hero(tag: character.id,
            child: Image.network(
              character.image ,
              fit: BoxFit.cover,
            ),
        ),
      ),
    );
  }
Widget characterInfo (String title , String Value){
    return RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: TextStyle(
                color: MyColors.naplesYellow,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                  fontFamily: "WubbaLubbaDubDub"
              )
            ),
            TextSpan(
                text: Value,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: MyColors.myGreen,
                  fontSize: 16,
                    fontFamily: "WubbaLubbaDubDub"
                )
            )
          ]
        ),
    );
}
Widget buildDivider (double endIndent) {
  return Divider(
    color: MyColors.naplesYellow,
    height: 30,
    endIndent: endIndent,
    thickness: 2.8,
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.mygray,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate(
                  [
                    Container(
                      margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                      padding: EdgeInsets.all(8),
                      child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          characterInfo('Species : ' , character.species),
                          buildDivider(299),
                          characterInfo('Location : ' , character.location.name),
                          buildDivider(290),
                          characterInfo('Origin : ' , character.origin.name),
                          buildDivider(310),
                          characterInfo('Status : ' , character.status),
                          buildDivider(310),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),

                  ]
              )
          )
        ],
      ),
    );
  }


}

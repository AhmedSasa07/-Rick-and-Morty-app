import 'package:breaking/constants/colors.dart';
import 'package:breaking/data/models/charactersModel.dart';
import 'package:flutter/material.dart';

import '../../constants/strings.dart';

class CharacterItem extends StatelessWidget {
  final CharacterModel character;
  const CharacterItem({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 2, 2),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: MyColors.myGreen,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, characterDetailsScreen , arguments: character),
        child: Hero(
          tag: character.id,
          child: GridTile(
            child: Container(
              color: MyColors.myWhite,
              child: character.image.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: "assets/images/Loading.gif",
                      image: character.image)
                  : Image.asset('assets/images/placeholder.jpg'),
            ),
            footer: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15 ,vertical: 10),
              color: Colors.black54,
              alignment : Alignment.bottomCenter,
              child: Text(
                '${character.name}' ,
                style: TextStyle(
                  height: 1.3,
                  fontSize: 16,
                  color: MyColors.myWhite,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

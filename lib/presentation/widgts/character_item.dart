import 'package:flutter/material.dart';
import 'package:flutter_application_6/constants/colors.dart';
import 'package:flutter_application_6/data/models/character.dart';

class CharacterItem extends StatelessWidget {
  final Character character;
  const CharacterItem({super.key, required this.character});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      decoration: BoxDecoration(
        color: Mycolors.myWhite,
        borderRadius: BorderRadius.circular(20),
      ),
      child: GridTile(
        footer: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          color: Colors.black,
          alignment: Alignment.bottomCenter,
          child: Text(
            character.name,
            style: TextStyle(
              height: 1.3,
              color: Mycolors.myWhite,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
        child: Container(
          color: Mycolors.myGreen,
          child:
              character.image.isNotEmpty
                  ? Image.network(
                    character.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/images/lo.gif');
                    },
                  )
                  : Image.asset('assets/images/placeholder.png'),
        ),
      ),
    );
  }
}

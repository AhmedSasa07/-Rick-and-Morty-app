import 'package:breaking/business_logic/cubit/characters_cubit.dart';
import 'package:breaking/constants/colors.dart';
import 'package:breaking/data/models/charactersModel.dart';
import 'package:breaking/presentation/widgets/Characters_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<CharacterModel> allCharacters;
  late List<CharacterModel> searchedForCharacters;
  bool  isSearching = false;
  final _searchTextController = TextEditingController();

  Widget _buildSearchField (){
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.myWhite,
      decoration: InputDecoration(
        hintText: "Find a Character....",
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: MyColors.myWhite,
          fontSize: 18,
            fontFamily: "WubbaLubbaDubDub"
        )
      ),
      style:  TextStyle(
        color: MyColors.myWhite,
        fontSize: 18,
          fontFamily: "WubbaLubbaDubDub"
      ),
      onChanged: (searchedCharacter){
        addSearchedForItemsToSearchedList(searchedCharacter);
      },
    );
  }
  void addSearchedForItemsToSearchedList(String searchedCharacter) {
    searchedForCharacters = allCharacters
        .where((character) => character.name.toLowerCase().contains(searchedCharacter.toLowerCase()))
        .toList();
    setState(() {});
  }


  List<Widget> _buildAppbarActions () {
    if (isSearching){
      return [
        IconButton(onPressed: (){
          //todo : lsas ha3mlha
          _clearSearch();
          Navigator.pop(context);
        }, icon: Icon(Icons.clear , color: MyColors.myWhite,))
      ];
    } else {
      return [
      IconButton(onPressed: (){
        _startSearch();
        }, icon: Icon(Icons.search_sharp , color: MyColors.myWhite,))
      ];
    }
  }

  void _startSearch () {
    ModalRoute.of ( context ) !
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      isSearching = true;
    });
  }
  void _stopSearching () {
    _clearSearch();
    setState(() {
      isSearching = false;
    });
  }
  void _clearSearch (){
    setState(() {
      _searchTextController.clear();
    });
  }
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }
Widget _buildAppbarTitle () {
  return Text(
    "Characters",
    style: TextStyle(fontSize: 26,color: MyColors.myWhite ,fontFamily: "WubbaLubbaDubDub"),
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: OfflineBuilder(
          connectivityBuilder: (
              BuildContext context,
              List<ConnectivityResult> connectivity,
              Widget child,
              ) {
            final bool connected = !connectivity.contains(ConnectivityResult.none);
            if (connected){
              return buildBlocWidget();
            }
            else {
              return buildNoInternetWidget();
            }
          },
          child: showProgressIndicator(),
          )

    );
  }
  String _getAppBarTitle() {
    if (!isSearching) {
      return "Characters";
    } else if (_isOffline()) {
      return "No Internet";
    } else {
      return ""; // Return an empty string when searching
    }
  }
  bool _isOffline() {
    return !ConnectivityResult.values.contains(ConnectivityResult.mobile) &&
        !ConnectivityResult.values.contains(ConnectivityResult.wifi);
  }
  AppBar buildAppBar() {
    return AppBar(
      leading: isSearching ? BackButton(color: MyColors.myWhite) : Container(),
      backgroundColor: MyColors.myGreen,
      title: isSearching ? _buildSearchField() : Text(
        _getAppBarTitle(),
        style: TextStyle(fontSize: 26, color: MyColors.myWhite, fontFamily: "WubbaLubbaDubDub"),
      ),
      actions: _buildAppbarActions(),
    );
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = state.characters;
          return buildLoadedListWidget();
        } else {
          return Center(child: Text('Unexpected state'));
        }
      },
    );
  }

  Widget showProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.mygray,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2/3,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
          ),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount:  _searchTextController.text.isEmpty ?  allCharacters.length : searchedForCharacters.length,
          itemBuilder: (ctx, index) {
            return _searchTextController.text.isEmpty ? CharacterItem(character: allCharacters[index]) : CharacterItem(character: searchedForCharacters[index]);
          },
        ),
      ),
    );
  }
}

Widget buildNoInternetWidget() {
  // return Center(
  //   child: Container(
  //     color: Colors.white,
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [
  //           SizedBox(height: 30,),
  //           Text("🚫 No Internet Connection .... Check Internet",style: TextStyle(fontSize: 50 , color: MyColors.myGreen ,fontWeight: FontWeight.bold ),),
  //           Image.asset('assets/images/no_internet.png'),
  //
  //         ],
  //       ),
  //     ),
  //   ),
  // );

  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
            size: 150,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            " No Internet Connection",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
                fontFamily: "WubbaLubbaDubDub"
            ),
          ),
          Text(
            "Check Internet",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,fontFamily: "WubbaLubbaDubDub"
            ),
          ),
        ],
      ),
    ),
  );
}


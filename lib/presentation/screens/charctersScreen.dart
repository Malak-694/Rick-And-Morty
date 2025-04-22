import 'package:flutter/material.dart';
import 'package:flutter_application_6/business_logic/cubit/characters_cubit.dart';
import 'package:flutter_application_6/constants/colors.dart';
import 'package:flutter_application_6/data/models/character.dart';
import 'package:flutter_application_6/presentation/widgts/character_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<Character>? allCharacters;
  List<Character>? searchResult;
  bool isSearching = false;
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget BuildBlockWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoading) {
          return Center(child: Text('still loading characters 😢'));
        } else if (state is CharactersLoaded) {
          allCharacters = state.characters;
          return buildLoadedListWidgets();
        } else if (state is CharactersError) {
          return Center(child: Text('Error loading characters 😢'));
        } else {
          return Center(child: Text('tka w hltom 😢'));
        }
      },
    );
  }

  void addSearchForItemToList(String searchedChar) {
    searchResult =
        allCharacters!
            .where(
              (character) =>
                  character.name.toLowerCase().startsWith(searchedChar),
            )
            .toList();
    setState(() {
      isSearching = true;
    });
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: searchController,
      cursorColor: Mycolors.myGreen,
      decoration: InputDecoration(
        hintText: 'Find a charachter',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Mycolors.myGreen, fontSize: 18),
      ),
      style: TextStyle(color: Mycolors.myGreen, fontSize: 18),

      onChanged: (searchedChar) => {addSearchForItemToList(searchedChar)},
    );
  }

  List<Widget> buildAppbarActions() {
    if (isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearchController();
            Navigator.pop(context);
          },
          icon: Icon(Icons.clear, color: Mycolors.myGreen),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: Icon(Icons.search, color: Mycolors.myGreen),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(
      context,
    )!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearchController();
    setState(() {
      isSearching = false;
    });
  }

  void _clearSearchController() {
    searchController.clear();
  }

  Widget showloadingIndicator() {
    return Center(child: CircularProgressIndicator(color: Mycolors.myYellow));
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: Mycolors.myGreen,
        child: Column(children: [buildCharacterListWidgets()]),
      ),
    );
  }

  Widget buildCharacterListWidgets() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisExtent: 250,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: searchController.text.isEmpty? allCharacters!.length:searchResult!.length,
      itemBuilder: (context, index) {
        return CharacterItem(character: searchController.text.isEmpty?allCharacters![index]:searchResult![index],); 
      },
    );
  }

  Widget _buildAppBar() {
    return Text("Characters", style: TextStyle(color: Mycolors.myGreen));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Mycolors.myYellow,
        title: isSearching ? _buildSearchBar() : _buildAppBar(),
        actions: buildAppbarActions(),
        leading: isSearching?BackButton(color: Mycolors.myGreen,):Container() ,
      ),
      body: BuildBlockWidget(),
    );
  }
}

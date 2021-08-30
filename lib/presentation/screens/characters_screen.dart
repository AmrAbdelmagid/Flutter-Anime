import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_dio_practice/business_logic/cubit/characters_cubit.dart';
import 'package:flutter_bloc_dio_practice/constants/colors.dart';
import 'package:flutter_bloc_dio_practice/data/models/character_model.dart';
import 'package:flutter_bloc_dio_practice/presentation/widgets/character_screen_widgets/character_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<Character> allCharacters = [];
  List<Character> searchedCharacters = [];
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: AppColors.myGrey,
      decoration: InputDecoration(
        hintText: 'Find an anime character',
        border: InputBorder.none,
        hintStyle: TextStyle(color: AppColors.myGrey, fontSize: 18.0),
      ),
      style: TextStyle(color: AppColors.myGrey, fontSize: 18.0),
      onChanged: (searchedCharacter) {
        addSearchedItemToSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchedItemToSearchedList(String searchedCharacter) {
    searchedCharacters = allCharacters
        .where((character) =>
            character.name.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: Icon(Icons.clear, color: AppColors.myGrey),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: Icon(
            Icons.search,
            color: AppColors.myGrey,
          ),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  Widget _buildAppBarTitle() {
    return Text(
      'Characters',
      style: TextStyle(color: AppColors.myGrey),
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).fetchCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.myYellow,
        leading: _isSearching
            ? BackButton(
                color: AppColors.myGrey,
              )
            : Container(),
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: BlocBuilder<CharactersCubit, CharactersState>(
          builder: (context, state) {
        if (state is CharactersLoadedState) {
          allCharacters = state.characters;
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
                color: AppColors.myGrey,
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3,
                      crossAxisSpacing: 1.0,
                      mainAxisSpacing: 1.0,
                    ),
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: _searchTextController.text.isEmpty
                        ? allCharacters.length
                        : searchedCharacters.length,
                    itemBuilder: (ctx, index) {
                      return CharacterItem(
                        character: _searchTextController.text.isEmpty
                            ? allCharacters[index]
                            : searchedCharacters[index],
                      );
                    })),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}

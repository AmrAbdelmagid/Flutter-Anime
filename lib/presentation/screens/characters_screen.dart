import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_dio_practice/data/models/character_model.dart';
import 'package:flutter_bloc_dio_practice/presentation/widgets/character_screen_widgets/character_item.dart';
import 'package:flutter_svg/svg.dart';
import '../../business_logic/cubits/characters_cubit/characters_cubit.dart';
import '../../constants/colors.dart';
import '../widgets/character_screen_widgets/app_bar_actions.dart';
import '../widgets/character_screen_widgets/characters_list.dart';
import '../widgets/character_screen_widgets/search_text_field.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<CharactersCubit>(context).loadCharacters();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<CharactersCubit>(context).loadCharacters();
        }
      }
    });
  }

  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<CharactersCubit>(context);
    setupScrollController(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.myYellow,
          leadingWidth: cubit.isSearching ? 32.0 : 0,
          leading: cubit.isSearching
              ? BackButton(
                  color: AppColors.myGrey,
                )
              : Container(),
          title: cubit.isSearching
              ? SearchTextField(cubit: cubit)
              : Text(
                  'Characters',
                  style: TextStyle(color: AppColors.myGrey),
                ),
          actions: AppBarIconButton(cubit: cubit).buildList(context),
        ),
        body: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;
            if (connected) {
              return BlocBuilder<CharactersCubit, CharactersState>(
                  builder: (context, state) {
                if (state is CharactersLoadingState && state.isFirstFetch) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                List<Character> characters = [];
                bool isLoading = false;
                if (state is CharactersLoadingState) {
                  characters = state.oldCharacters;
                  isLoading = true;
                } else if (state is CharactersLoadedState) {
                  characters = state.characters;
                }

                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  controller: scrollController,
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
                      itemCount: characters.length + (isLoading ? 2 : 0),
                      itemBuilder: (ctx, index) {
                        if (index < characters.length) {
                          return CharacterItem(character: characters[index]);
                        } else {
                          Timer(Duration(milliseconds: 30), () {
                            scrollController.jumpTo(
                                scrollController.position.maxScrollExtent);
                          });
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                );
                // if (cubit.characters.isNotEmpty ||
                //     cubit.searchedCharacters.isNotEmpty) {
                //   return CharactersList(cubit: cubit);
                // } else {
                //   return Center(
                //     child: CircularProgressIndicator(),
                //   );
                // }
              });
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/offline.svg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 300,
                  ),
                  SizedBox(height: 20.0),
                  Text('Check Your Connection'),
                ],
              );
            }
          },
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}

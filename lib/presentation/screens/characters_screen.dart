import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../business_logic/cubits/characters_cubit/characters_cubit.dart';
import '../../constants/colors.dart';
import '../widgets/character_screen_widgets/app_bar_actions.dart';
import '../widgets/character_screen_widgets/characters_list.dart';
import '../widgets/character_screen_widgets/search_text_field.dart';
import 'package:flutter_offline/flutter_offline.dart';

final bucket = PageStorageBucket();

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
    log('message');
    scrollController.jumpTo(currentScrollOffset);
  }

  double currentScrollOffset = 0;
  void setupScrollController(context) {
    scrollController.addListener(() {
      currentScrollOffset = scrollController.offset;
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<CharactersCubit>(context).loadCharacters();
          BlocProvider.of<CharactersCubit>(context).toggleIsLoading(true);
          Timer(Duration(milliseconds: 30), () {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          });
        }
      }
    });
  }

  final scrollController = ScrollController();
  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

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
        backgroundColor: AppColors.myGrey,
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
                if (cubit.isFirstFetch) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return CharactersList(
                    scrollController: scrollController, cubit: cubit);
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

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

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  double currentScrollOffset = 0;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).loadCharacters();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // jump to saved scroll position when reopening this widget
    if (scrollController.hasClients) {
      scrollController.jumpTo(currentScrollOffset);
    }
  }

  void setupScrollController(context) {
    final cubit = BlocProvider.of<CharactersCubit>(context);
    scrollController.addListener(() {
      // save current scroll position
      currentScrollOffset = scrollController.offset;
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          if (cubit.isSearchingLocal || cubit.isSearchingNetwork) return;

          cubit.loadCharacters();
          cubit.toggleIsLoading(true);
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
    BlocProvider.of<CharactersCubit>(context).dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<CharactersCubit>(context);
    setupScrollController(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.myYellow,
          leadingWidth: cubit.isSearchingLocal ? 32.0 : 0,
          leading: cubit.isSearchingLocal
              ? BackButton(
                  color: AppColors.myGrey,
                )
              : Container(),
          title: cubit.isSearchingLocal || cubit.isSearchingNetwork
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

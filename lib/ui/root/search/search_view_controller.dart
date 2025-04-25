import 'package:cinespot/ui/root/search/bloc/search_block.dart';
import 'package:cinespot/ui/root/search/widgets/search_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchViewController extends StatelessWidget {
  const SearchViewController({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(),
      child: CupertinoPageScaffold(child: SafeArea(child: SearchForm())),
    );
  }
}

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_base_stateful/api/api_manager.dart';
import 'package:testing_base_stateful/base/base_stateful_widget.dart';
import 'package:testing_base_stateful/ui/second/bloc/second_bloc.dart';
import 'package:testing_base_stateful/ui/second/repository/second_repository.dart';
import 'package:testing_base_stateful/utils/lang/app_localization_keys.dart';
import 'package:testing_base_stateful/utils/loader/loader_util.dart';
import 'package:testing_base_stateful/utils/snackbar/snackbar_util.dart';

class MySecondPage extends StatelessWidget {
  static const routeName = '/my-second-page';

  const MySecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = SecondBloc(SecondRepository(ApiManager()));
    return BlocProvider<SecondBloc>(
      create: (ctx) => bloc,
      child: MySecondPageBloc(bloc),
    );
  }
}

class MySecondPageBloc extends BaseStatefulWidget {
  final SecondBloc bloc;

  const MySecondPageBloc(this.bloc, {Key? key}) : super(key: key);

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _MySecondPageState();
}

class _MySecondPageState extends BaseState<MySecondPageBloc> {
  late Future startFuture;

  @override
  void initState() {
    startFuture = Future.delayed(Duration.zero).then((value) {
      _startApi();
    });
    super.initState();
  }

  @override
  void dispose() {
    CancelableOperation.fromFuture(startFuture).cancel();
    super.dispose();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Second"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.wifi),
      ),
      body: BlocListener<SecondBloc, SecondState>(
        listener: (context, state) {
          if (state is ErrorSte) {
            showSnackBarWithContext(
                createSnackBar(translate(LangKeys.CODE_ERROR)!), context);
          }
        },
        child: BlocBuilder<SecondBloc, SecondState>(
          builder: (context, state) {
            if (state is LoadingSte) {
              return buildLoader();
            } else if (state is LoadedSte) {
              return buildLoaded();
            } else if (state is ErrorSte) {
              return buildError();
            } else if (state is InitialSte) {
              return buildInitial();
            } else {
              return buildInitial();
            }
          },
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Widget methods ///////////////////////
  ///////////////////////////////////////////////////////////

  Widget buildLoader() {
    return getLoader();
  }

  Widget buildLoaded() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            translate(LangKeys.loaded)!,
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }

  Widget buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            translate(LangKeys.error)!,
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }

  Widget buildInitial() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            translate(LangKeys.init)!,
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper methods ////////////////////////
  ///////////////////////////////////////////////////////////

  SecondBloc get currentBloc => widget.bloc;

  void _startApi() {
    currentBloc.add(StartApiEvt());
  }
}

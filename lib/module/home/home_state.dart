part of home;

class _HomeViewState extends TTState<_HomeModel, _HomeView> {
  @override
  Widget buildWithModel(BuildContext context, _HomeModel model) {
    return const Scaffold(
      backgroundColor: Colors.blue,
    );
  }
}

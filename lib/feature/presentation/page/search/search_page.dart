import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/feature/presentation/bloc/searchmeal/bloc.dart';
import 'package:food_recipe/feature/presentation/page/detail/detail_page.dart';
import 'package:food_recipe/injection_container.dart';

class SearchPage extends StatelessWidget {
  final searchMealBloc = sl<SearchMealBloc>();
  final listResult = [];
  final controller = TextEditingController();
  final scaffoldState = GlobalKey<ScaffoldState>();
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: BlocProvider<SearchMealBloc>(
        create: (context) => searchMealBloc,
        child: BlocListener<SearchMealBloc, SearchMealState>(
          listener: (context, state) {
            if (state is FailureSearchMealState) {
              scaffoldState.currentState.showSnackBar(SnackBar(content: Text('Failed search data')));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: 'Search something...',
                          isDense: true,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    RaisedButton(
                      child: Text('Search'),
                      focusNode: focusNode,
                      onPressed: () {
                        var keyword = controller.text;
                        if (keyword.isEmpty) {
                          scaffoldState.currentState.showSnackBar(SnackBar(content: Text('Invalid keyword')));
                          return;
                        }
                        focusNode.requestFocus();
                        searchMealBloc.add(LoadSearchMealEvent(keyword));
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: BlocBuilder<SearchMealBloc, SearchMealState>(
                    builder: (context, state) {
                      if (state is LoadingSearchMealState) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is FailureSearchMealState) {
                        return Center(
                          child: Text('Failed search data'),
                        );
                      } else if (state is LoadedSearchMealState) {
                        var listData = state.searchMealByNameResponse.meals;
                        return listData == null || listData.isEmpty
                            ? Center(
                                child: Text('Data not found'),
                              )
                            : ListView.separated(
                                itemBuilder: (context, index) {
                                  var itemData = listData[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => DetailPage(itemData.idMeal)));
                                    },
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(4),
                                          child: CachedNetworkImage(
                                            width: 48,
                                            height: 48,
                                            imageUrl: itemData.strMealThumb,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) {
                                              return Image.asset(
                                                'assets/images/img_placeholder.jpg',
                                                fit: BoxFit.cover,
                                                width: 48,
                                                height: 48,
                                              );
                                            },
                                            errorWidget: (context, url, dynamic) {
                                              return Image.asset(
                                                'assets/images/img_not_found.jpg',
                                                fit: BoxFit.cover,
                                                width: 48,
                                                height: 48,
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            itemData.strMeal,
                                            style: Theme.of(context).textTheme.bodyText2,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) => Divider(),
                                itemCount: listData.length,
                              );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

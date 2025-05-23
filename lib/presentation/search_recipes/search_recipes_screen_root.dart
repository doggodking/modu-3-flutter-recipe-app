import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/core/routing/routes.dart';
import 'package:recipe_app/core/ui/color_style.dart';
import 'package:recipe_app/presentation/component/filter_search_bottom_sheet/filter_search_bottom_sheet.dart';
import 'package:recipe_app/presentation/component/filter_search_bottom_sheet/filter_search_state.dart';
import 'package:recipe_app/presentation/search_recipes/search_recipes_action.dart';
import 'package:recipe_app/presentation/search_recipes/search_recipes_screen.dart';
import 'package:recipe_app/presentation/search_recipes/search_recipes_view_model.dart';

class SearchRecipesScreenRoot extends StatefulWidget {
  final SearchRecipesViewModel viewModel;

  const SearchRecipesScreenRoot({super.key, required this.viewModel});

  @override
  State<SearchRecipesScreenRoot> createState() =>
      _SearchRecipesScreenRootState();
}

class _SearchRecipesScreenRootState extends State<SearchRecipesScreenRoot> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.load();
  }

  @override
  void dispose() {
    widget.viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        final state = widget.viewModel.state;

        return SearchRecipesScreen(
          state: state,
          onAction: (action) async {
            switch (action) {
              case OnOpenFilterSheet():
                FocusScope.of(context).unfocus();
                final result = await showModalBottomSheet<FilterSearchState>(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: ColorStyle.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(50),
                    ),
                  ),
                  builder:
                      (_) => FilterSearchBottomSheet(
                        state: state.filterSearchState,
                      ),
                );
                if (result != null) {
                  widget.viewModel.onAction(
                    SearchRecipesAction.onApplyFilter(result),
                  );
                }
                break;
              case OnTapRecipe(:final recipe):
                await context.push(Routes.recipeDetailPath(recipe.id));
                break;
              default:
                widget.viewModel.onAction(action);
            }
          },
        );
      },
    );
  }
}

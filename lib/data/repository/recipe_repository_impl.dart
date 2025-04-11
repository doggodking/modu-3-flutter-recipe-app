import 'package:flutter/foundation.dart';
import 'package:recipe_app/data/data_source/recipe_data_source.dart';
import 'package:recipe_app/data/dto/recipe_dto.dart';
import 'package:recipe_app/data/mapper/recipe_mapper.dart';
import 'package:recipe_app/data/model/recipe.dart';
import 'package:recipe_app/data/repository/recipe_repository.dart';
import 'package:recipe_app/util/failure.dart';
import 'package:recipe_app/util/result.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeDataSource? remoteDataSource;
  final RecipeDataSource localDataSource;

  RecipeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Result<List<Recipe>>> getRecipes() async {
    try {
      final source = remoteDataSource ?? localDataSource;
      final List<RecipeDto> recipeDtos = await source.fetchRecipes();
      final List<Recipe> models = recipeDtos.map((e) => e.toRecipe()).toList();
      return Result.success(models);
    } catch (e, _) {
      debugPrint('⚠️ remoteDataSource 실패 → local fallback');

      try {
        final List<RecipeDto> recipeDtos = await localDataSource.fetchRecipes();
        final List<Recipe> models =
            recipeDtos.map((e) => e.toRecipe()).toList();
        return Result.success(models);
      } catch (e2) {
        debugPrint('⚠️ localDataSource 실패 → error fallback $e2)');
        return Result.error(Failure('레시피 데이터를 불러오는 데 실패했습니다.', cause: e2));
      }
    }
  }
}

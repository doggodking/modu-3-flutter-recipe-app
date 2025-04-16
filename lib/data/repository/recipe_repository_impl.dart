import 'package:flutter/foundation.dart';
import 'package:recipe_app/core/error/failure.dart';
import 'package:recipe_app/core/error/result.dart';
import 'package:recipe_app/data/data_source/recipe_data_source.dart';
import 'package:recipe_app/data/dto/recipe_dto.dart';
import 'package:recipe_app/data/mapper/recipe_mapper.dart';
import 'package:recipe_app/domain/model/recipe.dart';
import 'package:recipe_app/domain/repository/recipe_repository.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeDataSource? remoteDataSource;
  final RecipeDataSource localDataSource;

  RecipeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Result<List<Recipe>>> getRecipes() async {
    // 원격 데이터 소스가 있는 경우 먼저 시도
    if (remoteDataSource != null) {
      try {
        final List<RecipeDto> recipeDtos =
            await remoteDataSource!.fetchRecipes();
        final List<Recipe> models =
            recipeDtos.map((e) => e.toRecipe()).toList();
        return Result.success(models);
      } catch (e, _) {
        debugPrint('⚠️ remoteDataSource 실패 → local fallback');
      }
    }
    // 원격 데이터 소스가 없거나 실패한 경우 로컬 데이터 소스 사용
    try {
      final List<RecipeDto> recipeDtos = await localDataSource.fetchRecipes();
      final List<Recipe> models = recipeDtos.map((e) => e.toRecipe()).toList();
      return Result.success(models);
    } catch (e2) {
      debugPrint('⚠️ localDataSource 실패 → error fallback $e2)');
      return Result.error(Failure('레시피 데이터를 불러오는 데 실패했습니다.', cause: e2));
    }
  }

  @override
  Future<Result<Recipe>> getRecipeById(int id) async {
    // 원격 데이터 소스가 있는 경우 먼저 시도
    if (remoteDataSource != null) {
      try {
        final dto = await remoteDataSource!.fetchRecipeById(id);
        if (dto != null) return Result.success(dto.toRecipe());
      } catch (e, _) {
        debugPrint('⚠️ remoteDataSource 실패 → local fallback');
      }
    }

    // 원격이 실패했거나 없을 경우 로컬 데이터 소스 fallback
    try {
      final dto = await localDataSource.fetchRecipeById(id);
      if (dto != null) return Result.success(dto.toRecipe());
      return Result.error(Failure('레시피를 찾을 수 없습니다.'));
    } catch (e2) {
      debugPrint('⚠️ localDataSource 실패 → error fallback $e2');
      return Result.error(Failure('레시피 데이터를 불러오는 데 실패했습니다.', cause: e2));
    }
  }
}

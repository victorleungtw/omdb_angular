"use strict"

@movieApp = angular.module 'movieApp', []

class MoviePanel
  constructor: (@$scope, @$http) ->
    $scope.searchInput = ""
    $scope.movieList = []
    $scope.movieDetails = undefined
    $scope.movieInfoInvisible = true
    searchNum = 0


    $scope.search = (movie) ->
      $scope.movieInfoInvisible = true
      $http(
        url: "http://www.omdbapi.com/"
        method: "get"
        params: {s: movie}
      ).success( (data, status, headers, config) ->
        $scope.movieList = data.Search
        console.log $scope.movieList
      ).error( (data, status, headers, config) ->
        $scope.status = status
      )


    $scope.showDetails = (movie) ->
      $scope.movieInfoInvisible = false
      $http(
        url: "http://www.omdbapi.com/"
        method: "get"
        params: {i: movie.imdbID}
      ).success( (data, status, headers, config) ->
        $scope.movieDetails = data
        console.log $scope.movieDetails
      ).error( (data, status, headers, config) ->
        $scope.status = status
      )

MoviePanel.$inject = ["$scope", "$http"]
movieApp.controller "MoviePanel", MoviePanel
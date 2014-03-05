"use strict"

@movieApp = angular.module 'movieApp', []

class MoviePanel
  constructor: (@$scope, @$http) ->
    $scope.searchInput = "matrix"
    $scope.loadingGif = true
    $scope.dropDownInvisible = true
    $scope.movieInfoInvisible = true

    $scope.search = ->
      console.log($scope.searchInput)
      if $scope.searchInput
        $scope.movieList = []
        $scope.loadingGif = false
        $scope.dropDownInvisible = true

        searchTerm = $scope.searchInput
        console.log searchTerm

        $http(
          url: "http://www.omdbapi.com/"
          method: "get"
          params: { s: searchTerm }
        ).success( (data, status, headers, config) ->
          console.log("data: " + data + "status: " + status + "headers:" + headers + "config: " + config)
          results(data)
        ).error( (data, status, headers, config) ->
          $scope.status = status
        )

        results = (data) ->
          $scope.loadingGif = true
          unless data.Response == 'False'
            $scope.movieList = []
            $scope.dropDownInvisible = false
            for movie in data["Search"]
              console.log movie
              console.log movie.Title
              $scope.movieList.push(movie)

    $scope.searchPick = ($event, movie) ->
      $scope.movieInfo = {}
      $scope.dropDownInvisible = true
      console.log("Working!")
      console.log($event, movie)
      console.log(movie.imdbID)
      $scope.movieInfoInvisible = false

      $http(
        url: "http://www.omdbapi.com/"
        method: "get"
        params: { i: movie.imdbID }
      ).success( (data, status, headers, config) ->
        console.log("data: " + data + "status: " + status + "headers:" + headers + "config: " + config + "imdbID: " + movie.imdbID)
        imdbInfo(data)
      ).error( (data, status, headers, config) ->
        $scope.status = status
      )

      imdbInfo = (data) ->
        console.log("This is the data " + data.Title)
        for key, info of data
          $scope.movieInfo[key] = info
          console.log(key, info)
        console.log($scope.movieInfo)

MoviePanel.$inject = ["$scope", "$http"]
movieApp.controller "MoviePanel", MoviePanel
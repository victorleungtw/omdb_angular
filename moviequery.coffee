"use strict"

@movieApp = angular.module 'movieApp', []

class MoviePanel
  constructor: (@$scope, @$http) ->
    $scope.searchInput = ""
    # $scope.loadingGif = true
    $scope.dropDownInvisible = true
    $scope.movieInfoInvisible = true

    $scope.search = ->
      if $scope.searchInput
        $scope.movieList = []
        # $scope.loadingGif = false
        $scope.dropDownInvisible = true

        searchTerm = $scope.searchInput

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
              $scope.movieList.push(movie)

    $scope.searchPick = (movie) ->
      $scope.movieInfo = {}
      $scope.dropDownInvisible = true
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
        for key, info of data
          $scope.movieInfo[key] = info

    $scope.infoFilter = (mInfo) ->
      if mInfo
        $scope.arr = {}
        for key, info of mInfo
          if key != 'Poster' && key != 'Title' && key != 'imdbID' && key != 'Response' && key != 'Release' && key != null
            if key == 'imdbRating' || key == 'imdbVotes' then key = (key[0..3].toUpperCase() + ' ' + key[4..-1])
            if key == 'Type' then info = info[0].toUpperCase()
            $scope.arr[key] = info
        $scope.arr

MoviePanel.$inject = ["$scope", "$http"]
movieApp.controller "MoviePanel", MoviePanel
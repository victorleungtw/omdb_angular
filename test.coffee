"use strict"

@movieApp = angular.module 'movieApp', []

class MoviePanel
  constructor: (@$scope, @$http) ->
    $scope.searchInput = "matrix"

    $scope.search = ->
      console.log($scope.searchInput)
      if $scope.searchInput
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
          unless data.Response == 'False'
            $scope.movieList = []
            for movie in data["Search"]
              console.log movie
              console.log movie.Title
              $scope.movieList.push(movie)

MoviePanel.$inject = ["$scope", "$http"]
movieApp.controller "MoviePanel", MoviePanel
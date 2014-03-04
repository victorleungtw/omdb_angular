"use strict"

@movieApp = angular.module 'movieApp', []

class MoviePanel
  constructor: (@$scope, @$http) ->
    searchTerm = ""
    data = {}
    results = {}

    $scope.search = ->
      searchTerm = $("input").val()

    $http(
      url: "http://www.omdbapi.com/"
      method: "get"
      data: { s: searchTerm }
      dataType: "json"
    ).success( (data, status, headers, config) ->
      results(data)
    ).error( (data, status, headers, config) ->
      $scope.status = status
    )

    results(data) ->
      for movie in data["Search"]
        console.log data
        console.log movie.Title
        li = $ "<li>" + movie.Title + "</li>"
        $(".result").append(li)

MoviePanel.$inject = ["$scope", "$http"]
movieApp.controller "MoviePanel", MoviePanel
"use strict"

@movieApp = angular.module 'movieApp', []

class MoviePanel
  constructor: (@$scope, @$http) ->
    $scope.searchInput = ""
    # $scope.loadingGif = true
    $scope.dropDownInvisible = true
    $scope.movieInfoInvisible = true
    searchNum = 0
    $scope.movieList = []

    $scope.keyPress = (event) ->
      switch event.which
        when 40
          $('.' + searchNum).removeClass('hover')
          searchNum += 1
          if searchNum > $scope.movieList.length
            searchNum = 0
          $('.' + searchNum).addClass('hover')
          return
        when 38
          $('.' + searchNum).removeClass('hover')
          searchNum -= 1
          if searchNum < 0
            searchNum = $scope.movieList.length
          $('.' + searchNum).addClass('hover')
          return
        when 13
          debugger
          if searchNum == 0
            $scope.searchPick($scope.searchInput, 'basic')
          else
            $scope.searchPick($scope.movieList[searchNum - 1], 'advanced')

    $scope.mouseOn = (event, num) ->
      console.log(event)
      console.log("Testing " + event.fromElement.localName)
      console.log(num)
      if num
        $('.' + searchNum).removeClass('hover')
        searchNum = num
      $('.' + searchNum).addClass('hover')
      return

    $scope.mouseOff = (event, num) ->
      console.log(event)
      console.log("Testing " + event.fromElement.localName)
      console.log(num)
      if num
        searchNum = num
      $('.' + searchNum).removeClass('hover')
      return

    $scope.search = ->
      if $scope.searchInput
        $scope.movieList = []
        # $scope.loadingGif = false
        $scope.dropDownInvisible = true
        searchNum = 0
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
            movieNum = 1
            for movie in data["Search"]
              movie.Num = movieNum
              $scope.movieList.push(movie)
              movieNum += 1

    $scope.searchPick = (movie, mode) ->
      console.log(movie + "TEST" + mode)
      $scope.movieInfo = {}
      $scope.dropDownInvisible = true
      $scope.movieInfoInvisible = false

      if mode == 'basic'
        para = { s: movie }
      else
        para = { i: movie.imdbID, plot: 'full' }

      $http(
        url: "http://www.omdbapi.com/"
        method: "get"
        params: para
      ).success( (data, status, headers, config) ->
        console.log("data: " + data + "status: " + status + "headers:" + headers + "config: " + config + "imdbID: " + movie.imdbID)
        if mode == 'basic'
          console.log('Basic route: ' + data['Search'][0])
          debugger
          imdbInfo(data['Search'][0])
        else
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
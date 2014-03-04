"use strict"

$ ->

  $("input").focus()

  $("form").on "submit", (event) ->
    event.preventDefault()

    searchTerm = $("input").val()

    movieData = $.ajax
      url: "http://www.omdbapi.com/"
      method: "get"
      data: { s: searchTerm }
      dataType: "json"

    movieData.done (data) ->
      $("input").val("")
      $(".result").html("")
      for movie in data["Search"]
        console.log data
        console.log movie.Title
        li = $ "<li>" + movie.Title + "</li>"
        $(".result").append(li)

# Charlie Code
$ ->
  backgrounds = [
      {image: "http://3.bp.blogspot.com/-Cj1UMVLqy4U/T89AD_7l6lI/AAAAAAAAAtg/NEKm8Xt5qRw/s1600/reservoirdogs1.jpg"}
      {image: "http://api.ning.com/files/3VYToYBLOhLGgNSqIEfF9Wyn1StQLbmO08o5G190kv5GG9ne9XOSWQCtvytOh4j0/ImportedPhotos00576.jpg"}
      {image: "http://pixarplanet.com/blog/images/664.jpg"}
      {image: "http://generationfilm.files.wordpress.com/2013/02/pulp-fiction.jpg"}
      {image: "http://oyster.ignimgs.com/ve3d/images/04/67/46735_orig.jpg"}
      {image: "http://l.yimg.com/os/publish-images/movies/2013-09-13/2b5e3792-e303-4679-abad-4253ba2b5bd0_GV-FP-0123r.jpg"}
      {image: "http://images.fanpop.com/images/image_uploads/300-Movie-Publicity-Still-300-222355_1500_705.jpg"}
      {image: "http://reelmovienation.com/wp-content/uploads/2012/06/BladeRunner3.jpg"}
      {image: "http://images1.fanpop.com/images/photos/1900000/Watchmen-Movie-the-watchmen-1989049-1800-751.jpg"}
      ]

  getRandomInt = (min, max) ->
    Math.floor(Math.random() * (max - min + 1)) + min

  $(document).ready ->
    bgNumber = getRandomInt(0, backgrounds.length - 1)

    $("body").css "background-image", "url(" + backgrounds[bgNumber].image + ")"
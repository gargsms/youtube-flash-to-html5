class Detube

  # @exposedProps = {'getPlayerState': 'r', 'hasFallbackHappened': 'r', 'getVideoData': 'r'}

  constructor: (doc) ->
    @doc = doc
    @document = doc.defaultView.wrappedJSObject.document

  valid: ->
    @valid_domain() and @valid_play()

  valid_domain: ->
    @doc.location.hostname.match(/youtube/) and
    @doc.getElementById('player')

  valid_play: ->
    interval = @document.defaultView.setInterval =>
      player = @document.defaultView.document.getElementById("movie_player")
      if player
        player.__exposedProps__ =
          'getPlayerState': 'r',
          'hasFallbackHappened': 'r',
          'getVideoData': 'r'
      if player and
      player.getPlayerState? and
      player.getPlayerState() isnt 3
        if player.getPlayerState() is -1 and  player.hasFallbackHappened()
          player.loadVideoById(player.getVideoData().video_id)
          @document.defaultView.clearInterval(interval)

    , 100



exports.Detube = Detube

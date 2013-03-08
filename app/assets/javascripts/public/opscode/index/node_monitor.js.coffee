Odb.View.register 'Public::Opscode::Index::NodeMonitor', ->

  _poll_interval = 100

  _poll = (path, from)->
    $.ajax path,
      data:
        from: from

  _set_status = (status)->
    $('#status').html status

  _abort = false

  _running = false

  _stdout = (str)->
    $('#stdout').append str
    $('#view_port').scrollTop($('#stdout').height())

  _interval = null

  _change_color = (speed, color)->
    color ||= '#'+Math.floor(Math.random()*16777215).toString(16)
    speed ||= 4000
    $('h1').stop(true).transition color: color, speed

  _loop_colors = ->
    _change_color()
    _interval = setInterval _change_color, 5000

  _reset_color = ->
    clearTimeout _interval
    $('h1').stop(true).css color: ''

  initialize: ->
    Odb.Events.on 'public:opscode:run', @run, this
    Odb.Events.on 'public:opscode:tail', @tail, this
    _set_status @options.default_status

  events:
    'click #abort': 'abort'
    'click #clear': 'clear'

  run: (data)->
    return if _running
    @$el.addClass('running')
    _set_status data.status
    _running = true
    _poll @options.tail_path
    _loop_colors()

  tail: (data)->
    if !!_abort
      @$el.removeClass('running')
      _set_status @options.default_status
      _reset_color()
      _running = false
      _abort = false
    else
      _set_status data.status
      _stdout data.tail
      setTimeout(_poll, _poll_interval, @options.tail_path, data.to)
      @completed() if !data.running # run 1 last time to make sure the entire log for run was received

  abort: (e)->
    _stdout '<p class="abort">^C</p>'
    _abort = true if _running == true

  completed: ->
    _stdout @options.completed_message
    _abort = true

  clear: (e)->
    $('#stdout').html ''

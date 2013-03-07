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

  tail: (data)->
    if !!_abort || !data.running
      @$el.removeClass('running')
      _set_status @options.default_status
      _running = false
      _abort = false
    else
      _set_status data.status
      _stdout data.tail
      setTimeout(_poll, _poll_interval, @options.tail_path, data.to)

  abort: (e)->
    _stdout '<p class="abort">^C</p>'
    _abort = true

  clear: (e)->
    $('#stdout').html ''

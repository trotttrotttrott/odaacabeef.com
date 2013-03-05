Odb.View.register 'Public::Opscode::Index::NodeMonitor', ->

  _poll = (path)->
    $.ajax path

  _set_status = (status)->
    $('#status').html status

  _kill = false

  _stdout = (str)->
    $('#stdout').append str
    # console.log $('#view_port').scrollTop()
    # console.log $('#stdout').height()
    # if $('#view_port').scrollTop() == $('#stdout').height()
    $('#view_port').scrollTop($('#stdout').height())

  initialize: ->
    Odb.Events.on 'public:opscode:run', @run, this
    Odb.Events.on 'public:opscode:tail', @tail, this
    _set_status @options.default_status

  events:
    'click #kill': 'kill'

  run: (data)->
    _set_status data.status
    _poll @options.tail_path

  tail: (data)->
    if !!_kill
      _kill = false
    else
      _set_status data.status
      _stdout data.tail
      setTimeout(_poll, 1000, @options.tail_path)

  kill: (e)->
    _set_status @options.default_status
    _stdout '<p class="kill">^C</p>'
    _kill = true

Odb.View.register 'Public::Opscode::Index::NodeMonitor', ->

  initialize: ->
    Odb.Events.on 'public:opscode:run_command', @run_command, this
    Odb.Events.on 'public:opscode:tail_command', @tail_command, this

    $('#view_port').resizable
      handles: 's'
      minHeight: 200
      maxHeight: 800

  run_command: (data)->
    console.log 'run'
    console.log data

  tail_command: (data)->
    console.log 'tail'
    console.log data

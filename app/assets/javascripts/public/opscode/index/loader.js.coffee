Odb.View.register 'Public::Opscode::Index::Loader', ->

  events:
    'ajaxSend': 'send'
    'ajaxComplete': 'complete'

  send: (e, xhr, options)->
    $('#loader img').show()

  complete: (e, xhr, options)->
    $('#loader img').hide()

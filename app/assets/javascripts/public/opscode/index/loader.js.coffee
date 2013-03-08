Odb.View.register 'Public::Opscode::Index::Loader', ->

  events:
    'ajaxSend': 'send'
    'ajaxComplete': 'complete'

  send: (e, xhr, options)->
    console.log 'fart'
    $('#loader img').show()

  complete: (e, xhr, options)->
    $('#loader img').hide()

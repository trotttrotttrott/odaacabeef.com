((debug)->

  top.Odb = View: {}, Events: {}

  views = {}

  Odb.View.register = (id, creator)->
    logger.debug "Odb.View.register: #{id}"
    views[id] =
      creator: Backbone.View.extend creator()
      instance: null

  Odb.View.start = (id, params)->
    logger.debug "Odb.View.start: #{id}..."
    if !views[id]
      return logger.warn "Odb.View.start: #{id} is not registered."
    if views[id].instance
      return logger.warn "Odb.View.start: #{id} has already been started."
    views[id].instance = new views[id].creator params
    logger.debug "Odb.View.start: ...#{id} was started."

  # Events

  Odb.Events.on = (ev, callback, context) ->
    logger.info "Odb.Events.on: #{ev};"
    Backbone.Events.on(ev, callback, context)

  Odb.Events.off = (ev, callback, context) ->
    logger.info "Odb.Events.off: #{ev};"
    Backbone.Events.off ev, callback, context

  Odb.Events.trigger = (notification, data) ->
    logger.info "Odb.Events.trigger: #{notification}; typeof data == #{typeof data};"
    Backbone.Events.trigger notification, data

  # Ajax

  $(document).bind 'ajaxComplete', (e, xhr, options)->
    if /^5|^0/.test(xhr.status)
      Odb.Events.trigger 'error', Odb.String.get('ajax_error_messages')["error_code_#{xhr.status}"]
    else
      data = (->
        try
          return $.parseJSON(xhr.responseText)
        catch error
          return {}
      )()
      if data.events
        $(data.events).each (i, event)->
          event.data.ajax_options = data.ajax_options if event.data && typeof event.data == 'object' && !event.data.ajax_options # pass along ajax options
          Odb.Events.trigger event.name, event.data

  # a nifty logger
  logger = ((methods)->
    _.each ['log', 'info', 'debug', 'warn', 'error'], (method)->
      methods[method] = (message)->
        if debug && window.console
          window.console[if window.console[method] then method else 'log'] message
    methods
  )({})

  # addtional logging for development mode
  if debug
    (()->
      jquery_ajax = 'ajaxStart beforeSend ajaxSend success ajaxSuccess error ajaxError complete ajaxComplete ajaxStop'
      jquery_ujs_events = 'ajax:before ajax:beforeSend ajax:success ajax:error ajax:complete ajax:aborted:required ajax:aborted:file'
      $(document).bind [jquery_ajax, jquery_ujs_events].join(' '), (data)->
        logger.debug "library_event - #{data.type};"
    )()

  return

) js_debug

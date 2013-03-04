#= require jquery
#= require jquery_ujs
#= require json2
#= require underscore
#= require backbone
#= require_tree ./public

$(document).delegate 'a[data-stop]', 'click.rails', (e)->
  $.rails.stopEverything(e)

#= require jquery
#= require jquery_ujs
#= require jquery-ui
#= require json2
#= require underscore
#= require backbone
#
#= require core
#
#= require_tree ./public

$(document).delegate 'a[data-stop]', 'click.rails', (e)->
  $.rails.stopEverything(e)

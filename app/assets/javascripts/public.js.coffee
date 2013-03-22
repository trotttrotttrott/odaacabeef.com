#= require jquery
#= require jquery_ujs
#= require jquery.transit.min
#= require json2
#= require underscore
#= require backbone
#= require kinetic-v4.3.3.min
#
#= require core
#
#= require_tree ./public

$(document).delegate 'a[data-stop]', 'click.rails', (e)->
  $.rails.stopEverything(e)

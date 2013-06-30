#= require jquery
#= require jquery_ujs
#= require jquery.transit.min
#= require json2
#= require underscore
#= require backbone
#
#= require core
#
#= require_tree ./opscode

$(document).delegate 'a[data-stop]', 'click.rails', (e)->
  $.rails.stopEverything(e)

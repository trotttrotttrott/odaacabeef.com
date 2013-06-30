#= require jquery
#= require handlebars
#= require ember
#= require ember-data
#= require vendor/custom.modernizr
#= require foundation
#= require_self
#= require ./home/store
#= require ./home/router

top.Odb = Ember.Application.create LOG_TRANSITIONS: js_debug

$ ->
  $(document).foundation()

#= require jquery
#= require handlebars
#= require ember
#= require ember-data
#= require_self
#= require ./home/store
#= require_tree ./home/models
#= require_tree ./home/controllers
#= require_tree ./home/views
#= require_tree ./home/helpers
#= require_tree ./home/templates
#= require_tree ./home/routes
#= require ./home/router

top.Odb = Ember.Application.create LOG_TRANSITIONS: true

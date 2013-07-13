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

$ ->

  (->

    container = document.createElement('div')
    stage = document.getElementById('central')
    stage.appendChild(container)

    artifacts = []

    start: ->
      t = this
      setInterval (->
        ((artifact)->
          setTimeout((-> container.removeChild(artifact)), t.random(1000))
        ) i for i in artifacts
        t.more_artifacts()
        ((artifact)->
          setTimeout((-> container.appendChild(artifact)), t.random(1000))
        ) i for i in artifacts
      ), 3000

    more_artifacts: ->
      artifacts = []
      num = 50
      while num -= 1
        artifact = document.createElement('div')
        artifact.style.top = "#{@random stage.offsetHeight}px"
        artifact.style.left = "#{@random stage.offsetWidth}px"
        artifact.style.width = if num % 2 == 0 then "#{@random(5) + 1}px" else '1px'
        artifact.style.height = if num % 2 != 0 then "#{@random(5) + 1}px" else '1px'
        artifact.style.position = 'absolute'
        artifact.style.background = ['#07ff00', '#333333', '#666666', '#999999'][@random(4)]
        artifacts.push artifact

    random: (n)->
      Math.floor(Math.random() * n)

  )().start()

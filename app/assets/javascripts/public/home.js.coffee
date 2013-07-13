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

    num = 50
    while num -= 1
      artifact = document.createElement('div')
      artifact.style.position = 'absolute'
      artifacts.push(artifact)

    start: ->
      @append_artifacts()
      setInterval (=>
        @append_artifacts()
      ), 5000

    append_artifacts: ->
      ((artifact)=>
        setTimeout((=>
          @restyle_artifact(artifact)
          container.appendChild(artifact)), @random(1000))) i for i in artifacts

    restyle_artifact: (artifact)->
      artifact.style.top = "#{@random stage.offsetHeight}px"
      artifact.style.left = "#{@random stage.offsetWidth}px"
      artifact.style.width = if num % 2 == 0 then "#{@random(5) + 1}px" else '1px'
      artifact.style.height = if num % 2 != 0 then "#{@random(5) + 1}px" else '1px'
      artifact.style.background = ['#07ff00', '#333333', '#666666', '#999999'][@random(4)]

    random: (n)->
      Math.floor(Math.random() * n)

  )().start()

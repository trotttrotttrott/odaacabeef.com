Odb.View.register 'Public::Home::Index::Holes', ->

  _random = ((n)-> Math.floor(Math.random() * n))

  _random_gradient = (okay=false)->
    color = (-> "##{Math.floor(Math.random()*16777215).toString(16)}" )
    is_okay = ((color)-> /^#[0-9A-F]{6}$/i.test(color) )
    while !okay
      colors = [color(), color()]
      okay = is_okay(colors[0]) && is_okay(colors[1])
    [0, '#000000', 0.5, colors[0], 0, colors[1]]

  _ease_names = ['linear', 'ease-in', 'ease-out', 'ease-in-out', 'back-ease-in', 'back-ease-out', 'back-ease-in-out', 'elastic-ease-in', 'elastic-ease-out', 'elastic-ease-in-out', 'bounce-ease-out', 'bounce-ease-in', 'bounce-ease-in-out', 'strong-ease-in', 'strong-ease-out', 'strong-ease-in-out']

  circles: []

  stage_width: 1280
  stage_height: 200

  initialize: ->

    @stage = new Kinetic.Stage
      container: @el
      width: @stage_width
      height: @stage_height

    @layer = new Kinetic.Layer()

    @schedule_circles()

  create_circle: ->
    [x, y, r] = [_random(@$el.width()), _random(@stage_height), _random(30)]
    circle = @circle(x, y, r)
    @circle_events(circle)
    @layer.add(circle)
    @stage.add(@layer)
    @circles.push circle
    circle

  circle: (x, y, r)->
    new Kinetic.Circle
      x: x
      y: y
      radius: r
      draggable: true
      opacity: .5
      fillRadialGradientStartPoint: 0
      fillRadialGradientStartRadius: 0
      fillRadialGradientEndPoint: 0
      fillRadialGradientEndRadius: 50
      fillRadialGradientColorStops: _random_gradient()

  circle_events: (circle)->
    layer = @layer
    circle.on 'mouseover touchstart', ->
      @setFillRadialGradientColorStops [0, '#000000', 0.5, '#ffff00', 0, '#ff00cf']
      layer.draw()
    circle.on 'mouseout touchend', ->
      @setAttrs
        fillRadialGradientColorStops: _random_gradient()
        layer.draw()

  animate: (circle)->
    period = _random(10000) + 3000
    @animation = new Kinetic.Animation ((frame)->
      scale = Math.sin(frame.time * 2 * Math.PI / period) + 0.001
      circle.setScale(scale)
    ), @layer
    @animation.start()

  schedule_circles: ->
    t = this
    @interval = setInterval (->
      if t.circles.length < 30
        circle = t.create_circle()
        t.animate(circle)
      circle ||= t.circles[_random(t.circles.length)]
      return if circle.isDragging()
      diameter = circle.getRadius() * 2
      scale_to = diameter / ((diameter - _random(t.stage_height)) * 100)
      circle.transitionTo
        x: _random(t.$el.width())
        y: _random(t.stage_height)
        duration: _random(10)
        easing: _ease_names[_random(_ease_names.length)]
        scale:
          x: scale_to
          y: scale_to
    ), 500

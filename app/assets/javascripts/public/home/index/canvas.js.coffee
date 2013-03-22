Odb.View.register 'Public::Home::Index::Canvas', ->

  initialize: ->

    stage = new Kinetic.Stage
      container: @el
      width: 1280
      height: 200

    layer = new Kinetic.Layer()

    out_gradient = [0, '#000000', 0.5, '#000000', 1, '#ff00cf']

    circle = new Kinetic.Circle
      x: 100
      y: 100
      radius: 50
      draggable: true
      fillRadialGradientStartPoint: 0
      fillRadialGradientStartRadius: 0
      fillRadialGradientEndPoint: 0
      fillRadialGradientEndRadius: 50
      fillRadialGradientColorStops: out_gradient

    circle.on 'mouseover touchstart', ->
      @setFillRadialGradientColorStops [0, '#000000', 0.5, '#ffff00', 1, '#ff00cf']
      layer.draw()

    circle.on 'mouseout touchend', ->
      @setAttrs
        fillRadialGradientColorStops: out_gradient
      layer.draw()

    layer.add(circle)
    stage.add(layer)

    period = 2000

    anim = new Kinetic.Animation ((frame)->
      scale = Math.sin(frame.time * 2 * Math.PI / period) + 0.001
      circle.setScale(scale)
    ), layer

    anim.start()

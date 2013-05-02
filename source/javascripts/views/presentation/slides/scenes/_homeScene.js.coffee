
class AmoebaSite.HomeScene
  constructor: (@el, @callback) ->
    AmoebaSite.presentation.setBackground('black')
    this._createMascot()
    this._createStarsAndPlanet()

  tearDown: =>
    @cube?.tearDown()
    @cube = undefined

    @toolsScene?.tearDown()
    @toolsScene = undefined

    @cloudScene?.tearDown()
    @cloudScene = undefined

  _createMascot: =>
    @mascot = $('<img/>')
      .attr(src: '/images/presentation/mascot_noshadow.svg')
      .appendTo(@el)
      .click( (e) =>
        this._zoomInOnMascotEyes()
      )
      .css(
        position: 'absolute'
        top: 250
        height: 360
        width: 360
        opacity: 1
      )

  _createStarsAndPlanet: () =>
    @$planet = $("<img/>")
      .attr(src: "/images/presentation/planet.svg")
      .css(
        position: 'absolute'
        height: 2000
        width: 2000
        top: '40%'
        left: -400
        opacity: 1
        zIndex: -1
      )
      .appendTo(@el)

  _hideHomeDivs: (show) =>
    @mascot.css(
      display: if show == true then 'block' else 'none'
    )
    @$planet.css(
      display: if show == true then 'block' else 'none'
    )

  _zoomInOnMascotEyes: =>
    # scale and translate x,y to zoom into eyes
    @el.transition(
      opacity:1
      scale: 25
      x: 7000
      y: 1100
      duration: AmoebaSite.utils.dur(2000)
      complete: =>
        this._hideHomeDivs()
        AmoebaSite.presentation.setBackgroundColor(AmoebaSite.Colors.amoebaGreenMedium)

        @el.css(
          scale: 1
          x: 0
          y: 0
        )
        this._fadeInCube()
    )

  _fadeInCube: () =>
    @cube = new AmoebaSite.CubeScene(@el, =>
      @toolsScene = new AmoebaSite.ToolsScene(@el, =>
        @cloudScene = new AmoebaSite.CloudScene(@el, =>
          console.log 'hello'
        )
      )

      @toolsScene.start()
    )

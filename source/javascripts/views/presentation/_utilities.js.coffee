
# ask Bro if this is the best way to do this
AmoebaSite.utils =

  createImageDiv: (path, divClass, imageSize, parentDiv) =>
    result = $('<div/>')
      .css(
        backgroundImage: 'url("' + path + '")'
        backgroundPosition: 'center center'
        backgroundSize: 'contain'
        backgroundRepeat: 'no-repeat'
        top: 0
        left: 0
        position: "absolute"
        width:imageSize
        height: imageSize
        opacity: 0
      )

    if divClass
      result.addClass(divClass)

    if parentDiv
      # center if we have a parent, some code uses this
      result.css(
        top: (parentDiv.height() - imageSize) / 2
        left: (parentDiv.width() - imageSize) / 2
      )

      result.appendTo(parentDiv)

    return result

  defaultTextCSS: () =>
    result =
      fontSize: "1em"
      position: "absolute"
      textAlign: 'center'
      top: 0
      left: 0
      opacity: 0
      width: "100%"
      textShadow: "#{AmoebaSite.Colors.amoebaGreenDark} 1px 0px 2px"
      color: "#{AmoebaSite.Colors.amoebaGreenMedium}"

    return result

  textCSSForSize:(size=1, align='center') =>
    result =
      fontSize: "#{size}em"
      textAlign: align

    return result

  deepTextShadowCSS: () =>
    shadowString = ""
    # loop and create progressivly darker shadows
    _.each([1..5], (element, index) =>
      # x, y, blur, color
      shadowString += "0 #{element}px 0 rgba(#{255 - (12*element)}, #{255 - (12*element)}, #{255 - (12*element)}, 1.0), "
    )

    shadowString += "0 6px 7px rgba(0, 0, 0, 0.4),"
    shadowString += "0 7px 10px rgba(0, 0, 0, 0.2)"

    result =
      textShadow: shadowString

    return result

  # searchClass is used for finding all text divs with a set class
  # for removal. example: $(".#{styleClass}").remove()
  # styleClass is used for styling
  createTextDiv: (text, css, searchClass, parentDiv) =>
    # css overrides the defaults (color, shadow, etc)
    theCSS = AmoebaSite.utils.defaultTextCSS()
    if css?
      theCSS = _.extend(theCSS, css)

    result = $('<div/>')
      .text(text)
      .css(theCSS)

    # set the font
    result.addClass('amoebaBoldFont')

    if searchClass
      result.addClass(searchClass)

    if parentDiv
      result.appendTo(parentDiv)

    return result

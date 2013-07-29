MM = require('MentorMe')

template = require('templates/profile/ProfileButton')

module.exports = class ProfileButtonView extends Marionette.ItemView
  template: template

  inactiveColor: '#313131'
  activeColor: '#ef9637'

  events: 
    'click' : 'buttonClicked'

  initialize: ->
    super

    if @options.state?
      @state = MM.request('get:profile:state', @options.state)

  serializeData: ->
    _.extend @options,
      ribbon: false
      progress: false
    if @state?
      @options.state = @state.state
      @options.stateClass = @options.state.split(':').join('-')
      @options.ribbon = "Start" if @state.state == 'untapped'
      if @state.state.indexOf('active') == 0
        @options.ribbon = "Resume"
        @options.progress = @state.progress()

    @options

  onShow: ->
    if @options.state? && @options.progress
      setTimeout(=>
        @$el.find('.fill').css('height', @options.progress + '%')
        color = @makeGradientColor(@inactiveColor, @activeColor, @options.progress).cssColor
        @$el.find('.profilebtn').css('background-color', color)
        borderPercent = @options.progress - 15
        borderColor = @makeGradientColor(@inactiveColor, @activeColor, borderPercent).cssColor
        @$el.find('.profilebtn').css('box-shadow', '2px 2px ' + borderColor)
      , 200)

  buttonClicked: (e) ->
    # For now we only care if button is disabled
    if @options.state == 'disabled'
      e.preventDefault();
      alert("Please start previous tools before using this one")


  # Utility method for button colors
  makeGradientColor: (color1, color2, percent) ->
    color1 = @hexColorToRGB(color1)
    color2 = @hexColorToRGB(color2)
    makeChannel = (a, b) ->
      a + Math.round((b - a) * (percent / 100))
    makeColorPiece = (num) ->
      num = Math.min(num, 255) # not more than 255
      num = Math.max(num, 0) # not less than 0
      str = num.toString(16)
      str = "0" + str  if str.length < 2
      str
    newColor = {}
    newColor.r = makeChannel(color1.r, color2.r)
    newColor.g = makeChannel(color1.g, color2.g)
    newColor.b = makeChannel(color1.b, color2.b)
    newColor.cssColor = "#" + makeColorPiece(newColor.r) + makeColorPiece(newColor.g) + makeColorPiece(newColor.b)
    newColor

  hexColorToRGB: (color) ->
    color = color.substring(1)
    rgb = {}
    rgb.r = parseInt(color.substring(0,2), 16)
    rgb.g = parseInt(color.substring(2,4), 16)
    rgb.b = parseInt(color.substring(4,6), 16)
    return rgb
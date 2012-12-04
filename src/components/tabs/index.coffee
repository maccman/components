class Tab
  constructor: (@nav, @content) ->
    @el = document.createElement('div')

class Tabs extends Component
  @register 'tabs'

  styles:
    borderRadius: '5px'

  props:
    select: 'select'

  constructor: ->
    super

    @sections = @$('section')

  select: =>

dom = require('./dom')

class Component
  @components: [] # :private

  @register: (tag) ->
    @::tag = tag if tag?
    Component.components.push(this)

  @load: -> # :private
    elements = dom.$(@tag or @::tag)
    new this(el: el) for el in elements

  @loadAll: => # :private
    comp.load() for comp in @components

  dom: dom
  tag: 'component'

  constructor: (@options = {}) ->
    @el or= @options.el
    @el or= document.createElement(@tag)
    @css(@styles) if @styles
    @prop(@props) if @props
    @attr(@attrs) if @attrs

  $: (sel) ->
    $(sel, el)

  css: (value) ->
    dom.css(@el, value)

  prop: (key, value) ->
    if typeof key is 'object'
      @prop(k, v) for k, v of key
    else if not value?
      @el[key]?() ? @el[key]
    else if typeof value is 'string'
      @el[key] = @[value]
    else
      @el[key] = value

  attr: (key, value) ->
    if typeof key is 'object'
      @prop(k, v) for k, v of key
    else if not value?
      @el.getAttribute(key)
    else
      @el.setAttribute(key, value)

dom.ready(Component.loadAll)

module.exports = Component
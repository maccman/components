$ = (sel, el = document) -> el.querySelectorAll(sel)

$$ = (cls) ->
  # getElementsByClassName is not supported in < IE9
  if typeof document.getElementsByClassName is 'function'
    document.getElementsByClassName(cls)
  else
    document.querySelectorAll(".#{cls}")

bind = (element, name, callback) ->
  if element.addEventListener
    element.addEventListener(name, callback, false)
  else
    element.attachEvent("on#{name}", callback)

unbind = (element, name, callback) ->
  if element.removeEventListener
    element.removeEventListener(name, callback, false)
  else
    element.detachEvent("on#{name}", callback)

trigger = (element, name, data = {}, bubble = true) ->
  if window.jQuery
    jQuery(element).trigger(name, data)

addClass = (element, name) ->
  element.className += ' ' + name

hasClass = (element, name) ->
  name in element.className.split(' ')

css = (element, css) ->
  unless typeof css is 'string'
    css = ("#{k}:#{v};" for k, v of css)
  element.style.cssText += (';' + css)

insertBefore = (element, child) ->
  element.parentNode.insertBefore(child, element)

insertAfter = (element, child) ->
  element.parentNode.insertBefore(child, element.nextSibling)

append = (element, child) ->
  element.appendChild(child)

remove = (element) ->
  element.parentNode?.removeChild(element)

parents = (node) ->
  ancestors = []
  while (node = node.parentNode) and
          node isnt document and
            node not in ancestors
    ancestors.push(node)
  ancestors

host = (url) ->
  parser      = document.createElement('a')
  parser.href = url
  "#{parser.protocol}//#{parser.host}"

resolve = (url) ->
  parser      = document.createElement('a')
  parser.href = url
  "#{parser.href}"

escape = (value) ->
  value and ('' + value)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')

text = (element, value) ->
  if 'innerText' of element
    element.innerText = value
  else
    element.textContent = value
  value

ready = (callback) ->
  bind(document, 'DOMContentLoaded', callback)

delegate = (el, selector, event, callback) ->
  bind el, event, (e) ->
    if selector matches e.target
      callback()

module.exports =
  $:            $
  $$:           $$
  bind:         bind
  unbind:       unbind
  trigger:      trigger
  addClass:     addClass
  hasClass:     hasClass
  css:          css
  insertBefore: insertBefore
  insertAfter:  insertAfter
  append:       append
  remove:       remove
  parents:      parents
  host:         host
  resolve:      resolve
  escape:       escape
  text:         text
  ready:        ready
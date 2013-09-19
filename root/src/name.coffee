module.exports = class {%= name %}
  awesome: ->
    "awesome"
    

if typeof window is 'object'
  window.{%= name %} = {%= name %}

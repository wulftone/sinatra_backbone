$ ->
  object = {}
  _.extend object, Backbone.Events
  object.bind 'alert', (msg) ->
    alert "Triggered #{msg}"
  
  # object.trigger 'alert', 'an event'
  
  Title = Backbone.Model.extend
    promptColor: ->
      cssColor = prompt 'Please enter a CSS color:'
      @set color: cssColor
    promptText: ->
      text = prompt 'Please enter a text:'
      @set text: text
  
  window.title = new Title
  
  title.bind 'change:color', (model, color) ->
    $('h1').css color: color
    
  title.bind 'change:text', (model, text) ->
    $('h1').text text

  title.bind 'change', (model, arg) ->
    console.log arg.valueOf()
    
  title.set color: 'black'
  # title.promptColor()
  # title.promptText()

ships = new Backbone.Collection
ships.bind 'add', (ship) ->
  alert "Ahoy #{ship.get 'name'} !"
  console.log ship.cid

ships.add [
  {name: "Flying Dutchman"}
  {name: "Black Pearl"}
]
  

object = {}
_.extend object, Backbone.Events
object.bind 'alert', (msg) ->
  alert "Triggered #{msg}"

object.trigger 'alert', 'an event'

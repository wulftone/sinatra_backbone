$ ->
  Message = Backbone.Model.extend
    defaults:
      text: 'これはデフォルトのメッセージです。'

  MessageStore = Backbone.Collection.extend
    model: Message
    url: '/messages'
  messages = new MessageStore
      
  MessageView = Backbone.View.extend
    tagName: 'p'
    template: _.template 'メッセージ<%= id %>: <%= text %>'
    className: 'message-row'
    initialize: () ->
      _.bindAll @, 'render'
      @.model.view = @
      @.model.bind 'change', @.render
    render: () ->
      $(@.el).html @.template(@.model.toJSON())
      @

  AppView = Backbone.View.extend
    el: $('#main')
    events:
      'click #send': 'createMessage'
    initialize: () ->
      _.bindAll @, 'createMessage', 'addOne', 'addAll'
      messages.bind 'add', @.addOne
      messages.bind 'refresh', @.addAll
    createMessage: (data) ->
      message = $('#message').val()
      $('#message').val ''
      messages.create text: message
    addOne: (message) ->
      view = new MessageView model: message
      $('#log').append view.render().el
    addAll: (messages) ->
      messages.each @.addOne

  appview = new AppView

  messages.fetch()

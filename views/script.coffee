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
      $(this.el).html this.template(@.model.toJSON())
      @

  AppView = Backbone.View.extend
    el: $('#main')
    events:
      'click #send': "addMessage"
    addMessage: (data) ->
      message = $('#message').val()
      $('#message').val ''
      messages.create text: message

  appview = new AppView

  messages.bind 'add', (model) ->
    view = new MessageView model: model
    $('#log').append view.render().el

  messages.bind 'refresh', (data) ->
    data.each (d) ->
      view = new MessageView model: d
      $('#log').append view.render().el

  messages.fetch()

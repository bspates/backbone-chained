class TestChildView extends Backbone.Chained.View

  fragment: 'woot'

  beforeHandle: () ->
    @render()

  render: ->
    $('#zed').text "zanidu"

  onBadRoute: ->
    console.log 'Bad route handled by TestChildView'
    # Return true to prevent error propogation to the router and parent views
    true

class TestView extends Backbone.Chained.View
  
  fragment: 'test'

  beforeHandle: (fragments) ->
    @childViews.push new TestChildView()
    @render()

  render: ->
    $('#main').html """<a id="zed" href="me.com">woot</a>"""


app = {}
app.router = new Backbone.Chained.Router()
app.router.views.child = new TestView()
Backbone.history.start
  pushState: false
  root: app.root
Backbone.Chained = {}

class Backbone.Chained.Router extends Backbone.Router

  # Top level views in the tree
  views: {}

  # Override with view object to default to when no route is given
  defaultView: null

  routes:
    '*splat': 'chain'

  # Begins tracing the chain in the tree of responsibility 
  chain: (splat) ->
    unless splat?
      unless @defaultView?
        return @notFound()
      else
        targetView = @defaultView
    else  
      fragments = splat.split '/' 
      return @notFound() if fragments is undefined
      current = fragments.shift()
      targetView = _.find @views, (view) ->
        view.fragment is current

    return @notFound() unless targetView isnt undefined and targetView?
    response = targetView.handle fragments
    @notFound() if not response
      
  notFound: ->
    # override
    $('body').html "Page Not Found"

class Backbone.Chained.View extends Backbone.View

  fragment: null

  childViews: []

  handle: (fragments) ->
    # Allow before hook to modify fragments or not
    frgaments = @beforeHandle fragments or fragments

    # If there are no more url fragments to handle SUCCESS!
    unless fragments.length
      @afterHandle
      return true

    if @childViews?

      # Force child views into array
      children = _.values @childViews

      # If there are no child views the route is bad
      if children.length
        current = fragments.shift()

        # Find view with specific url fragment declared
        targetView = _.find children, (view) ->
          view.fragment is current

        success = targetView.handle fragments if targetView
        if success
          @afterHandle()
          return success

    @afterHandle()
    @onBadRoute()
    

  # Hook for any logic performed after a view's handle
  afterHandle: ->
    #override

  # Hook for any logic performed before a view's handele
  # Useful for extracting ids from the url chain
  beforeHandle: (fragments) ->
    # override

  # Hook for bad route handling on the view level
  # Returns boolean
  # Return true to stop the eror from propagating up
  onBadRoute: ->
    # override
    false

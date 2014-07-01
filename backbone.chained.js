(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Backbone.Chained = {};

  Backbone.Chained.Router = (function(_super) {
    __extends(Router, _super);

    function Router() {
      return Router.__super__.constructor.apply(this, arguments);
    }

    Router.prototype.views = {};

    Router.prototype.defaultView = null;

    Router.prototype.routes = {
      '*splat': 'chain'
    };

    Router.prototype.chain = function(splat) {
      var current, fragments, response, targetView;
      if (splat == null) {
        if (this.defaultView == null) {
          return this.notFound();
        } else {
          targetView = this.defaultView;
        }
      } else {
        fragments = splat.split('/');
        if (fragments === void 0) {
          return this.notFound();
        }
        current = fragments.shift();
        targetView = _.find(this.views, function(view) {
          return view.fragment === current;
        });
      }
      if (!(targetView !== void 0 && (targetView != null))) {
        return this.notFound();
      }
      response = targetView.handle(fragments);
      if (!response) {
        return this.notFound();
      }
    };

    Router.prototype.notFound = function() {
      return $('body').html("Page Not Found");
    };

    return Router;

  })(Backbone.Router);

  Backbone.Chained.View = (function(_super) {
    __extends(View, _super);

    function View() {
      return View.__super__.constructor.apply(this, arguments);
    }

    View.prototype.fragment = null;

    View.prototype.childViews = [];

    View.prototype.handle = function(fragments) {
      var children, current, frgaments, success, targetView;
      frgaments = this.beforeHandle(fragments || fragments);
      if (!fragments.length) {
        this.afterHandle;
        return true;
      }
      if (this.childViews != null) {
        children = _.values(this.childViews);
        if (children.length) {
          current = fragments.shift();
          targetView = _.find(children, function(view) {
            return view.fragment === current;
          });
          if (targetView) {
            success = targetView.handle(fragments);
          }
          if (success) {
            this.afterHandle();
            return success;
          }
        }
      }
      this.afterHandle();
      return this.onBadRoute();
    };

    View.prototype.afterHandle = function() {};

    View.prototype.beforeHandle = function(fragments) {};

    View.prototype.onBadRoute = function() {
      return false;
    };

    return View;

  })(Backbone.View);

}).call(this);

//# sourceMappingURL=backbone.chained.js.map

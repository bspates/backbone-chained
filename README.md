backbone-chained
================

Simple chain/tree of responsibility for composite view routing. Allows for "normal" browser behavior when using the back button.
The impetus for this plugin was being given a half made web app implemented with backbone, and the product owner wanted the 
back/forward browser buttons to work just like in  a "normal" website. So I came up with this do-hicky. It moves all the
routeing/contoller logic to the views (I know, I know just hear me out), the idea is each view declares a url or route fragment
that represents itself. The router then breaks up any url after the '#' into an array and then a chain is found within the view 
tree that matches said url. In this way each view is responsible for its tiny piece of the routing job. This is usefull when
using alot of nested views whose behaviour you want to track with the browser history. 

module.exports = class BackStackRegion extends Marionette.Region
  # // Displays a backbone view instance inside of the region.
  # // Handles calling the `render` method for you. Reads content
  # // directly from the `el` attribute. Also calls an optional
  # // `onShow` and `close` method on your view, just after showing
  # // or just before closing the view, respectively.
  show: (view, animation) ->
    this.ensureEl();

    this.ensureStackNavigator();

    view.render();
    
    this.open(view, animation);
    this.close();

    Marionette.triggerMethod.call(view, "show");
    Marionette.triggerMethod.call(this, "show", view);

    this.currentView = view;


  pushView: (view, animation) ->
    @ensureEl()
    @ensureStackNavigator()
    view.render()
    @stackNavigator.pushView(view, null, animation || new BackStack.SlideEffect())

    Marionette.triggerMethod.call(view, "show");
    Marionette.triggerMethod.call(this, "show", view);

    this.currentView = view;

  popView: (animation) ->
    @ensureEl()
    @ensureStackNavigator()
    view = @stackNavigator.popView(new BackStack.SlideEffect(direction: "right"))
    @close();
    # @currentView = 
    # Marionette.triggerMethod.call(view, "show");
    # Marionette.triggerMethod.call(this, "show", view);


  ensureEl: ->
    if (!this.$el || this.$el.length == 0)
      this.$el = this.getEl(this.el);
    
  ensureStackNavigator: ->
    @stackNavigator ||= new BackStack.StackNavigator
      el: @$el

  # // Override this method to change how the region finds the
  # // DOM element that it manages. Return a jQuery selector object.
  getEl: (selector) ->
    return $(selector);
  

  # // Override this method to change how the new view is
  # // appended to the `$el` that the region is managing
  open: (view, animation) ->
    if(@everPushed)
      @stackNavigator.replaceView(view, null, new BackStack.FadeEffect());
    else
      @stackNavigator.pushView(view, null, animation || new BackStack.FadeEffect());
    # @$el.empty().append(view.el);

  # // Close the current view, if there is one. If there is no
  # // current view, it does nothing and returns immediately.
  close: ->
    view = @currentView
    if(!view || view.isClosed) 
      return;
    if(view.close) 
      view.close();
    Marionette.triggerMethod.call(this, "close");

    delete this.currentView;
  

  # // Attach an existing view to the region. This 
  # // will not call `render` or `onShow` for the new view, 
  # // and will not replace the current HTML for the `el`
  # // of the region.
  attachView: (view) ->
    this.currentView = view;
  

  # // Reset the region by closing any existing view and
  # // clearing out the cached `$el`. The next time a view
  # // is shown via this region, the region will re-query the
  # // DOM for the region's `el`.
  reset: ->
    this.close();
    delete this.$el;
  
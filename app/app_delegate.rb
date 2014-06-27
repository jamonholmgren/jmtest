class AppDelegate < PM::Delegate

  status_bar true, animation: :fade

  def on_load(app, options)
    open Screen::Root.new nav_bar: true
  end
end

module Screen
  class Login < PM::Screen
    title "Login"

    def on_load
      # @layout = Layout::Login.new(root: self.view).build
      self.view.backgroundColor = UIColor.whiteColor
      @nav_bar = Layout::NavBar.new(self.navigationController)
      @nav_bar.show_with_animation
    end

    def will_appear
      self
    end

    def will_disappear
      @nav_bar.hide
    end

  end
end

module Layout
  class NavBar

    class << self

      def background_image
        @_background_image ||= "background_image".uiimage
        return @_background_image
      end

    end

    def initialize(controller)
      @background_image = "background_image".uiimage
      @controller = controller
      @nav = controller.navigationBar
    end

    def hide
      @nav.setBackgroundImage nil, forBarMetrics: UIBarMetricsDefault
      @controller.setNavigationBarHidden true, animate: true
      self
    end


    def show_with_animation
      @controller.setNavigationBarHidden false, animate: true
      @nav.setBarStyle UIBarStyleBlackTranslucent
      @nav.setBackgroundImage self.class.background_image, forBarMetrics: UIBarMetricsDefault
      self
    end
  end
end

module Screen
  class Root < PM::Screen
    title "Beam"

    attr_accessor :navbar_layout

    def on_load
      # @layout = RootLayout.new(root: self.view).build
      self.view.backgroundColor = UIColor.whiteColor
      @button = add UIButton.new, frame: [[ 10, 100], [200, 50]], background_color: UIColor.redColor
      @button.on :touch { open Screen::Login.new }
      @navbar_layout = Layout::NavBar.new(self.navigationController).hide
    end

    def will_appear
      @navbar_layout.hide
      # @layout.reapply!
    end
  end
end

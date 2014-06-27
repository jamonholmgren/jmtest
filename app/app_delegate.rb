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
      @layout = Layout::Login.new(root: self.view).build
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
      @layout = RootLayout.new(root: self.view).build
      @navbar_layout = Layout::NavBar.new(self.navigationController).hide
      [@layout.skip_button, @layout.signup_button, @layout.login_button].each do |button|
        @layout.on button.motion_kit_id do
          send(button.motion_kit_id.gsub("_button", ""))
        end
      end
    end

    def will_appear
      @navbar_layout.hide
      @layout.reapply!
    end

    def login
      open Screen::Login.new nav_bar: true
    end

  end
end

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CassetteCaddy
  class Application < Rails::Application
    
    # WPD : Added the video asssets folder to rails root
    config.assets.paths << "#{Rails.root}/app/assets/videos"
    # WPD - getting rails to precompile the mp4 assets in the asset pipleine: 
    config.assets.precompile += %w(.mp4)

    # This is the boilerplate setup from leWagaon: 
    config.generators do |generate|
      generate.assets false
      generate.helper false
      generate.test_framework :test_unit, fixture: false
    end
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end

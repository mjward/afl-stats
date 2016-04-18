require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AflStats
  class Application < Rails::Application

    config.before_configuration do
      # Some database configurations in database.yml depend on configatron,
      # so it's loaded here instead of from initializers/configatron.rb.
      require 'configatron'
      Configatron::Integrations::Rails.init
      configatron.lock!
    end

    config.assets.paths << Rails.root.join('vendor', 'assets')

    config.active_record.raise_in_transactional_callbacks = true

    config.autoload_paths += %W(
      #{config.root}/app/views
      #{config.root}/lib
      #{config.root}/app/workers
      #{config.root}/app/services
      #{config.root}/app/actions
    )

    config.eager_load_paths += %W(
      #{config.root}/app/views
      #{config.root}/lib
      #{config.root}/app/workers
      #{config.root}/app/services
      #{config.root}/app/actions
    )


  end
end

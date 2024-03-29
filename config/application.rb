require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module Kodiak
  class Application < Rails::Application
    config.less.paths << "#{Rails.root}/app/assets/stylesheets"
    config.less.compress = true
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(#{config.root}/lib/search/)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
    config.middleware.delete "ActiveRecord::QueryCache"

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    config.active_record.schema_format = :sql

    config.active_record.whitelist_attributes = false

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    config.secret_key_base = %Q:
 _____                 _                                                
/  ___|               | |                                               
\ `--. _ __ ___   ___ | | _____ _   _                                   
 `--. \ '_ ` _ \ / _ \| |/ / _ \ | | |                                  
/\__/ / | | | | | (_) |   <  __/ |_| |_                                 
\____/|_| |_| |_|\___/|_|\_\___|\__, ( )                                
                                 __/ |/                                 
                                |___/                                   
                    __      _                _                          
                   / _|    (_)              | |                         
 _ __ ___  _   _  | |_ _ __ _  ___ _ __   __| |                         
| '_ ` _ \| | | | |  _| '__| |/ _ \ '_ \ / _` |                         
| | | | | | |_| | | | | |  | |  __/ | | | (_| |_                        
|_| |_| |_|\__, | |_| |_|  |_|\___|_| |_|\__,_( )                       
            __/ |                             |/                        
           |___/                                                        
                   _                       _            _               
                  ( )                     | |          (_)              
 _   _  ___  _   _|/ _ __ ___    ___ _ __ | |_ ___ _ __ _ _ __   __ _   
| | | |/ _ \| | | | | '__/ _ \  / _ \ '_ \| __/ _ \ '__| | '_ \ / _` |  
| |_| | (_) | |_| | | | |  __/ |  __/ | | | ||  __/ |  | | | | | (_| |  
 \__, |\___/ \__,_| |_|  \___|  \___|_| |_|\__\___|_|  |_|_| |_|\__, |  
  __/ |                                                          __/ |  
 |___/                                                          |___/   
                            _     _          __               _         
                           | |   | |        / _|             (_)        
  __ _  __      _____  _ __| | __| |   ___ | |_   _ __   __ _ _ _ __    
 / _` | \ \ /\ / / _ \| '__| |/ _` |  / _ \|  _| | '_ \ / _` | | '_ \   
| (_| |  \ V  V / (_) | |  | | (_| | | (_) | |   | |_) | (_| | | | | |_ 
 \__,_|   \_/\_/ \___/|_|  |_|\__,_|  \___/|_|   | .__/ \__,_|_|_| |_(_)
                                                 | |                    
                                                 |_|                    
    :
    I18n.enforce_available_locales = true
  end
end

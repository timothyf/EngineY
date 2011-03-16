Disguise.configure do |config|
  config.use_domain_for_themes = false    # Changing theme per domain can be expense so it's off by default
  config.themes_enabled = true            # Turns disguise off/on.
  config.theme_full_base_path = File.join(::Rails.root.to_s, 'themes') # Full path to the themes folder. The examples puts themes in a directory called 'themes' in the Rails app root.
end
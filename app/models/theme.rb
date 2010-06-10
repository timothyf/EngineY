class Theme < ActiveRecord::Base

  def locales
    Dir[ File.join(RAILS_ROOT, 'themes', self.name, 'locales', '*.{rb,yml}') ]
  end
  
  # This method will iterate through all available themes in the theme directory
  # and then return an array of all themes as well as the currently selected theme
  # as a hash in the format:
  #  {:name => theme_name, :preview_image => image, :description => description}
  # This can then be used by the view layer to show the user a list of available themes
  # along with a preview image.
  def self.available_themes(selected_theme)
    themes = []
    theme_path = File.join(RAILS_ROOT, Disguise::Config.theme_path)
    current_theme = nil
    
    Dir.glob("#{theme_path}/*").each do |theme_directory|
      if File.directory?(theme_directory)
        theme_name = File.basename(theme_directory)

        image = Dir.glob(File.join(RAILS_ROOT, 'public', 'images/themes', theme_name, 'preview.*')).first || File.join('/', 'images', 'no_preview.gif')
        image = image.gsub(File.join(RAILS_ROOT, 'public'), '')

        description = ''
        description_file = File.join(theme_directory, 'description.txt')
        if File.exist?(description_file)
          f = File.new(description_file, "r")
          description = f.read
          f.close
        end

        theme = {:name => theme_name, :preview_image => image, :description => description}
        themes << theme

        current_theme = theme if selected_theme.name == theme_name
      end
    end

    [current_theme, themes]
  end

end
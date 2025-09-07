#-------------------------------------------------------------------------------
#
# R.K.D Chinthaka Deshapriya
# your.cdeshapriya91@gmail.com
#
#-------------------------------------------------------------------------------

require 'sketchup'
require 'extensions'

#-------------------------------------------------------------------------------

module SmartCleanPush

  ### CONSTANTS ### ------------------------------------------------------------

  # Plugin information
  PLUGIN_ID       = 'SmartCleanPush'.freeze
  PLUGIN_NAME     = 'SmartCleanPush'.freeze
  PLUGIN_VERSION  = '1.4.0'.freeze
  PLUGIN_URL      = 'https://www.facebook.com/chinthakadesh'.freeze # Update with the actual URL

  # Resource paths
  file = __FILE__.dup
  file.force_encoding('UTF-8') if file.respond_to?(:force_encoding)
  PATH_ROOT     = File.dirname(file).freeze
  PATH_LOADER   = File.join(PATH_ROOT, 'SmartCleanPush', 'main').freeze
  PATH_ICON_24  = File.join(PATH_ROOT, 'SmartCleanPush', 'scp_main_icon_24.png').freeze

  ### EXTENSION ### ------------------------------------------------------------

  unless file_loaded?(__FILE__)
    @ex = SketchupExtension.new(PLUGIN_NAME, PATH_LOADER)
    @ex.description = 'Removes inner faces and applies Push/Pull to multiple faces at once.'
    @ex.version     = PLUGIN_VERSION
    @ex.copyright   = 'R.K.D Chinthaka Deshapriya © 2024'
    @ex.creator     = 'R.K.D Chinthaka Deshapriya (cdeshapriya91@gmail.com)'

    # Set the icon only if the method is available
    if @ex.respond_to?(:set_extension_icon)
      @ex.set_extension_icon(PATH_ICON_24)
    else
      puts "set_extension_icon is not supported in this version of SketchUp."
    end

    # Register the extension (false = don't auto-load on startup)
    Sketchup.register_extension(@ex, false)
    file_loaded(__FILE__)
  end

end # module SmartCleanPush

#-------------------------------------------------------------------------------

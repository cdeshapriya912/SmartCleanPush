module SmartCleanPush
  # Remove inner faces and optionally apply Push/Pull
  def self.remove_inner_faces_and_pushpull
    model = Sketchup.active_model
    selection = model.selection

    if selection.empty?
      UI.messagebox("Please select some geometry to process.")
      return
    end

    model.start_operation('Remove Inner Faces and Push/Pull', true)

    faces = selection.grep(Sketchup::Face)

    removed_count = 0
    faces.each do |face|
      if face.edges.all? { |edge| edge.faces.size > 1 }
        face.erase!
        removed_count += 1
      end
    end

    prompts = ['Push/Pull Distance (cm):']
    defaults = ['0']
    input = UI.inputbox(prompts, defaults, 'Enter Push/Pull Distance')
    return unless input

    distance = input[0].to_f.cm
    faces.each do |face|
      next unless face.valid? && face.respond_to?(:pushpull)
      face.pushpull(distance)
    end

    model.commit_operation
    UI.messagebox("Removed #{removed_count} inner faces and applied Push/Pull with #{input[0]} cm.")
  end

  # Remove inner faces only
  def self.remove_inner_only
    model = Sketchup.active_model
    selection = model.selection

    if selection.empty?
      UI.messagebox("Please select some geometry to process.")
      return
    end

    model.start_operation('Remove Inner Faces Only', true)

    faces = selection.grep(Sketchup::Face)
    removed_count = 0
    faces.each do |face|
      if face.edges.all? { |edge| edge.faces.size > 1 }
        face.erase!
        removed_count += 1
      end
    end

    model.commit_operation
    UI.messagebox("Removed #{removed_count} inner faces.")
  end

  # Multiple Push/Pull
  def self.multiple_push_pull
    model = Sketchup.active_model
    selection = model.selection

    if selection.empty?
      UI.messagebox("Please select some faces to push/pull.")
      return
    end

    prompts = ['Push/Pull Distance (cm):']
    defaults = ['0']
    input = UI.inputbox(prompts, defaults, 'Enter Push/Pull Distance')
    return unless input

    distance = input[0].to_f.cm
    model.start_operation('Multiple Push/Pull', true)

    faces = selection.grep(Sketchup::Face)
    faces.each do |face|
      next unless face.valid? && face.respond_to?(:pushpull)
      face.pushpull(distance)
    end

    model.commit_operation
    UI.messagebox("Push/Pull applied to #{faces.size} faces with #{input[0]} cm.")
  end

  # About dialog
  def self.show_about_dialog
    # Path to the photo in the `res` folder
    photo_path = File.join(__dir__,'my_photo.jpg').gsub('\\', '/')

    # Create the HTML dialog
    dialog = UI::HtmlDialog.new(
      {
        :dialog_title => "About SmartCleanPush",
        :preferences_key => "SmartCleanPushAboutDialog",
        :scrollable => true,
        :resizable => false,
        :width => 400,
        :height => 300
      }
    )

    # HTML content with the corrected image path
    html_content = <<-HTML
      <!DOCTYPE html>
      <html lang="en">
      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>About SmartCleanPush</title>
        <style>
          body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 0;
            padding: 20px;
          }
          img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            margin-bottom: 20px;
          }
          h1 {
            font-size: 18px;
            margin: 0;
            color: #333;
          }
          p {
            font-size: 14px;
            color: #555;
            margin: 5px 0;
          }
        </style>
      </head>
      <body>
        <img src="file://#{photo_path}" alt="Chinthaka Deshapriya">
        <h1>SmartCleanPush</h1>
        <p>Version: 1.4.0</p>
        <p>Developer: Chinthaka Deshapriya</p>
        <p>Location: Sri Lanka</p>
        <p>Contact: cdeshapriya91@gmail.com</p>
        <p>Description: This plugin removes inner faces and optionally adds thickness using Push/Pull. The plugin can handle multiple faces simultaneously, making it efficient for complex 3D models.</p>
</p>
        </body>
      </html>
    HTML

    # Set the HTML content
    dialog.set_html(html_content)

    # Show the dialog
    dialog.show
  end

  # Show Help HTML File
  def self.show_help
    help_path = File.join(__dir__, 'help.html').gsub('\\', '/')

    if File.exist?(help_path)
      # Create an HTML dialog to display the help.html file
      dialog = UI::HtmlDialog.new(
        {
          :dialog_title => "SmartCleanPush - Help",
          :preferences_key => "SmartCleanPushHelpDialog",
          :scrollable => true,
          :resizable => false,
          :width => 800,
          :height => 600
        }
      )
      dialog.set_file(help_path)
      dialog.show
    else
      UI.messagebox("Help file not found. Please ensure 'help.html' is located in the plugin folder.")
    end
  end

  # Cleanup method for when SketchUp closes
  def self.cleanup
    # Close any open dialogs
    if defined?(@about_dialog) && @about_dialog
      @about_dialog.close
      @about_dialog = nil
    end
    
    if defined?(@help_dialog) && @help_dialog
      @help_dialog.close
      @help_dialog = nil
    end
  end

  # Observer class for cleanup when SketchUp closes
  class CleanupObserver < Sketchup::AppObserver
    def onQuit
      SmartCleanPush.cleanup
    end
  end

  # Toolbar and menu setup
  unless file_loaded?(__FILE__)
    toolbar = UI::Toolbar.new('SmartCleanPush')

    cmd1 = UI::Command.new('Remove Inner Faces and Push/Pull') { remove_inner_faces_and_pushpull }
    cmd1.tooltip = 'Remove inner faces and optionally add thickness'
    cmd1.small_icon = File.join(__dir__, 'scp_inner_push_16.png')
    cmd1.large_icon = File.join(__dir__, 'scp_inner_push_24.png')
    toolbar.add_item(cmd1)

    cmd2 = UI::Command.new('Multiple Push/Pull') { multiple_push_pull }
    cmd2.tooltip = 'Perform multiple Push/Pull operations'
    cmd2.small_icon = File.join(__dir__, 'scp_multi_push_16.png')
    cmd2.large_icon = File.join(__dir__, 'scp_multi_push_24.png')
    toolbar.add_item(cmd2)

    cmd3 = UI::Command.new('Remove Inner Faces Only') { remove_inner_only }
    cmd3.tooltip = 'Remove inner faces only'
    cmd3.small_icon = File.join(__dir__, 'scp_inner_face_16.png')
    cmd3.large_icon = File.join(__dir__, 'scp_inner_face_24.png')
    toolbar.add_item(cmd3)

    # Don't auto-show toolbar - let user control it via View > Toolbars
    # toolbar.show

    menu = UI.menu('Extensions').add_submenu('SmartCleanPush')
    menu.add_item('Remove Inner Faces and Push/Pull') { remove_inner_faces_and_pushpull }
    menu.add_item('Multiple Push/Pull') { multiple_push_pull }
    menu.add_item('Remove Inner Faces Only') { remove_inner_only }
    menu.add_item('Support') { show_help }
    menu.add_item('About') { show_about_dialog }

    # Add cleanup observer for when SketchUp closes
    Sketchup.add_observer(SmartCleanPush::CleanupObserver.new)

    file_loaded(__FILE__)
  end
end

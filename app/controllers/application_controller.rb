class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :admin?, :embed_video

  protected

  def authorize
    unless user_signed_in?
      flash[:alert] = "Unauthorized access! Please log in first."
      redirect_to root_path
      false
    end
  end

  # given a link to a vimeo video, return the id number for the video to
  # be used in the embed code in the view
  def embed_video( options = {} )
    width = options[:width] || 500
    height = options[:height] || 375

    broken_image = "<img src=\"/assets/placeholder.png\" alt=\"No
    image added yet\" width=\"#{width}\" height=\"#{height}\">".html_safe

    if options[:link] && options[:uploaded_image_url]
      #throw error
    end

    if options[:link]
      vimeo_id = /^((http[s]?|ftp):\/)?\/?([^:\/\s]+)((\/\w+)*\/)([\w\-\.]+[^#?\s]+)(.*)?(#[\w\-]+)?$/.match(options[:link])
      if vimeo_id
        vimeo_id = vimeo_id[6]
      else
        return broken_image
      end

      return "<iframe src=\"//player.vimeo.com/video/#{vimeo_id}\"
      width=\"#{width}\" height=\"#{height}\" frameborder=\"0\"
      webkitallowfullscreen mozallowfullscreen
      allowfullscreen></iframe>".html_safe

    elsif options[:uploaded_image_url]
      return "<img src=\"#{options[:uploaded_image_url]}\" width=\"#{width}\" height=\"#{height}\">".html_safe

    elsif !options[:uploaded_image_url] && !options[:link]
      return broken_image
    end

  end
end

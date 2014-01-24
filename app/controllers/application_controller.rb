class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :admin?, :embed_media, :get_background_css,
    :get_tile_image_css

  protected

  def authorize
    unless user_signed_in?
      flash[:alert] = "Unauthorized access! Please log in first."
      redirect_to root_path
      false
    end
  end

  def broken_image_tag( height = 375, width = 500 )
    return "<img src=\"/assets/placeholder.png\" alt=\"No image added
    yet\" width=\"#{width}\" height=\"#{height}\">".html_safe
  end

  # given a link to a vimeo video, return the id number for the video to
  # be used in the embed code in the view
  def embed_media( options = {} )
    width = options[:width] || 500
    height = options[:height] || 375

    if options[:link] && options[:uploaded_image_url]
      raise ArgumentError, "embed_media canno have both \"link\" and
      \"uploaded_image_url\" arguments"
    end

    if options[:link]
      return embed_video(link: options[:link], 
                         width: width, 
                         height: height)

    elsif options[:uploaded_image_url]
      return "<img src=\"#{options[:uploaded_image_url]}\" width=\"#{width}\" height=\"#{height}\">".html_safe

    elsif !options[:uploaded_image_url] && !options[:link]
      return broken_image_tag(height, width)
    end

  end

  def embed_video( options = {} )
    link = options[:link]

    if link != ""
      # if youtube
      if link =~ /youtube\.com\/.+/
        youtube_id = link.match(/v=([^&]*)/)[1]

        return "<iframe width=\"#{options[:width]}\"
        height=\"#{options[:height]}\"
        src=\"//www.youtube.com/embed/TBvPaqMZyo8\" frameborder=\"0\"
        allowfullscreen></iframe>".html_safe

      # if vimeo
      elsif link =~ /vimeo\.com/
        vimeo_id = /^((http[s]?|ftp):\/)?\/?([^:\/\s]+)((\/\w+)*\/)([\w\-\.]+[^#?\s]+)(.*)?(#[\w\-]+)?$/.match(link)[6]

        return "<iframe src=\"//player.vimeo.com/video/#{vimeo_id}\"
        width=\"#{options[:width]}\" height=\"#{options[:height]}\"
        frameborder=\"0\" webkitallowfullscreen mozallowfullscreen
        allowfullscreen></iframe>".html_safe
      end

    else
      return broken_image_tag options[:height], options[:width]
    end
  end

  def get_background_css(active_record_object, record_id)
    image = active_record_object.find(record_id).background_image

    if image != nil
      "background: url(#{image})"
    else
      return
    end
  end

  def get_tile_image_css(active_record_object, record_id)
    image = active_record_object.find(record_id).grid_tile_image

    if image != nil
      "background: url(#{image})"
    else
      return
    end
  end
end

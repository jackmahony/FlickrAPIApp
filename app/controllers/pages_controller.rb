class PagesController < ApplicationController
  def index
    # Only perform the API request if a user_id is present
    if params[:user_id].present?
      user_id = params[:user_id]
      @response = HTTParty.get("https://www.flickr.com/services/rest/?method=flickr.people.getPublicPhotos&api_key=676491a626284d418ddf92d11eb07d3f&user_id=#{user_id}&format=json&nojsoncallback=1")
      @photos = JSON.parse(@response.body)

      # Check if the API returned an error
      if @photos["stat"] == "fail"
        flash.now[:notice] = "Invalid Flickr User ID, please try again."
        @photos = nil # Reset photos if invalid user ID
      end
    end
  end
end

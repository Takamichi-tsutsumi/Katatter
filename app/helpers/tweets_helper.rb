module TweetsHelper
  def wrap(tubuyaki)
   sanitize(raw(tubuyaki.split.map{ |s| wrap_long_string(s) }.join(' ')))
  end

  # def
  #
  # end

  def self.reply!(other_tweet)
    self.reply_relations.create!( replied_tweet_id: other_tweet.id )
  end

 private

   def wrap_long_string(text, max_width = 30)
     zero_width_space = "&#8203;"
     regex = /.{1,#{max_width}}/
     (text.length < max_width) ? text :
                                 text.scan(regex).join(zero_width_space)
   end

   def tweet_params
     params.require(:tweet).permit(:tubuyaki, :id, :user_id, :image, :image_cache, :remove_image)
   end
end

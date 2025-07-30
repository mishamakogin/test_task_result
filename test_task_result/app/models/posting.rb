class Posting < ApplicationRecord
  belongs_to :author,    class_name: 'User', foreign_key: 'user_id'
  belongs_to :editor,    class_name: 'User', foreign_key: 'editor_id'
  
  def article_with_image
    return type if type != 'Article'

    # body = 
    #   '<p>Some text.</p>
    #     <figure>
    #       <img src="https://www.sample-images.com/my-article-image" alt="good image" data-image="">
    #       <img src="https://www.sample-images.com/my-article-image222" alt="good image" data-image="">
    #     </figure>

    #   <p>Some more text.</p>'

    figure_start = body.index('<figure')
    figure_end = body.index('</figure>')
    # I see problem here
    # if at least on of figure_start or figure_end are not inside of body
    # the app will raise error because we are expection object (hash) in the view
    # example below 
    # img src="#{image['src']}"
    return "#{figure_start}_#{figure_end}" if figure_start.nil? || figure_end.nil? # "#{nil}_#{nil}" => "_"

    # similar case here
    # if the string inside of "figure" tags does not include "img" tag
    # we return string and will face same error
    image_tags = body[figure_start...figure_end + 9]
    return 'not include <img' unless image_tags.include?('<img')

    posting_image_params(image_tags)
  end

  private

  def posting_image_params(html)
    tag_parse = -> (image, att) { image.match(/#{att}="(.+?)"/) }
    tag_attributes = {}

    # usless condition => unless data.size < 2 
    # because we always will have more than 1 element in data
    # we can be sure about it because we do the next check => unless data.nil?
    %w[alt src data-image].each do |attribute|
      data = tag_parse.(html, attribute)

      tag_attributes[attribute] = data[1] unless data.nil?
      # unless data.nil?
      #   tag_attributes[attribute] = data[1] unless data.size < 2
      # end
    end
    # tag_parse
    tag_attributes
  end
end
class StaticPagesController < ApplicationController
  def top
    @post = current_user.posts.build if logged_in?

    # Amazon::Ecs.debug = true
    # @res = Amazon::Ecs.item_search(
    #          'ruby',
    #         #  :search_index   => 'Books',
    #         #  :response_group => 'Medium',
    #          :country        => 'jp'
    #        )
  end

  def about
  end

  def terms
  end

  def policy
  end
end

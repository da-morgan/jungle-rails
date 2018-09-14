class ReviewsController < ApplicationController
    def create
        @review  = Review.new(review_params)
        @review.user_id = current_user.id
        @review.product_id = params[:product_id]
        puts "PRODUCT ID: #{params[:product_id]}"
        #@review.description = params[:description]


        @review.save
        
        if @review.save
          redirect_to :back, notice: 'Review saved'
        else
          redirect_to :back, flash: { error: @review.errors.full_messages.first }
        end

    end

    private

    def review_params
        params.require(:review).permit(:rating, :description, :product_id)
    end

end

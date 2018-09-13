class UserMailer < ApplicationMailer
    def order_receipt order 
        @order = order
        @line_items = LineItem.where(order_id: @order.id)
        mail(to: @order.email, subject: "Jungle Order ##{@order.id}")
    end

    def get_product id
        Product.find(id)
    end
    helper_method :get_product
end

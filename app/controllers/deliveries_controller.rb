
class DeliveriesController < ApplicationController
  def search
    render json: Delivery.where(book_id: params["bookIds"])
  end

  def create
    Delivery.create(book_id: params["bookId"])
    head :ok
  end

  def show
    delivery = Delivery.find_and_bump_state(params["bookId"])
    render json: delivery
  end

  def destroy
    delivery  = Delivery.find_by(book_id: params["bookId"])
    delivery&.destroy
    head :ok
  end
end

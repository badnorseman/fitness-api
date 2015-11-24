module Api
  class ProductsController < ApplicationController
    skip_before_action :omniauth_restrict_access, only: [:index, :show]
    skip_before_action :restrict_access, only: [:index, :show]
    before_action :set_product, except: :index

    # GET /products.json
    def index
      render json: policy_scope(Product).order(:name), status: :ok
    end

    # GET /products/1.json
    def show
      render json: @product, status: :ok
    end

    # POST /products.json
    def create
      if @product.save
        render json: @product, status: :created
      else
        render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity, location: nil
      end
    end

    # PUT /products/1.json
    def update
      if @product.update(product_params)
        render json: @product, status: :ok
      else
        render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity, location: nil
      end
    end

    # DELETE /products/1.json
    def destroy
      @product.destroy
      head :no_content
    end

    private

    def product_params
      params.require(:product).
        permit(:name,
               :description,
               :currency,
               :price,
               :image)
    end

    def set_product
      if params.has_key?(:id)
        @product = Product.find(params.fetch(:id))
      else
        @product = Product.new(product_params)
        @product.user = current_user
      end
      authorize @product
    end
  end
end

require "spec_helper"

describe Api::ProductsController, type: :controller do
  before do
    coach = create(:coach)
    login(coach)
    @product = create_list(:product,
                           2,
                           user: coach).first
  end

  describe "GET #index" do
    before do
      another_coach = create(:coach)
      create_list(:product,
                  2,
                  user: another_coach)
    end

    it "should query 4 Products" do
      get(:index)

      expect(json.count).to eq 4
    end
  end

  describe "GET #show" do
    it "should read 1 Product" do
      get(
        :show,
        id: @product.id)

      expect(json["name"]).to eq(@product.name)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "should create Product" do
        product_attributes =
          attributes_for(:product)

        expect do
          post(
            :create,
            product: product_attributes)
        end.to change(Product, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "should not create Product" do
        product_attributes =
          attributes_for(:product, name: nil)

        expect do
          post(
            :create,
            product: product_attributes)
        end.to change(Product, :count).by(0)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "should update Product" do
        name = "Name #{rand(100)}"

        patch(
          :update,
          id: @product.id,
          product: { name: name })

        expect(Product.find(@product.id).name).to eq(name)
      end
    end

    context "with invalid attributes" do
      it "should not update Product" do
        name = "too long name" * 10

        patch(
          :update,
          id: @product.id,
          product: { name: name })

        expect(Product.find(@product.id).name).to eq(@product.name)
      end
    end
  end

  describe "DELETE #destroy" do
    it "should delete Product" do
      expect do
        delete(
          :destroy,
          id: @product.id)
      end.to change(Product, :count).by(-1)
    end
  end
end

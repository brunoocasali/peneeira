require 'rails_helper'

RSpec.describe ProductsController, :type => :controller do
  let(:account_element) { create :account_element }
  let(:valid_attributes) { build(:product).attributes }
  let(:invalid_attributes) { attributes_for :invalid_product }
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all products as @products" do
      product = create :product, valid_attributes

      get :index, {}, valid_session

      expect(assigns(:products)).to eq([product])
    end
  end

  describe "GET new" do
    it "assigns a new product as @product" do
      get :new, {}, valid_session

      expect(assigns(:product)).to be_a_new(Product)
    end
  end

  describe "GET edit" do
    it "assigns the requested product as @product" do
      product = create :product, valid_attributes

      get :edit, {:id => product.to_param}, valid_session

      expect(assigns(:product)).to eq(product)
    end
  end

  describe "POST create" do
    context "with valid params" do
      it "creates a new Product" do
        expect {
          post :create, {:product => valid_attributes}, valid_session
        }.to change(Product, :count).by(1)
      end

      it "assigns a newly created product as @product" do
        post :create, {:product => valid_attributes}, valid_session

        expect(assigns(:product)).to be_a(Product)
        expect(assigns(:product)).to be_persisted
      end

      it "redirects to the created product" do
        post :create, {:product => valid_attributes}, valid_session

        expect(response).to redirect_to(products_path)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved product as @product" do
        post :create, {:product => invalid_attributes}, valid_session

        expect(assigns(:product)).to be_a_new(Product)
      end

      it "re-renders the 'new' template" do
        post :create, {:product => invalid_attributes}, valid_session

        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    context "with valid params" do
      let(:new_attributes) { attributes_for :product }

      it "updates the requested product" do
        product = create :product, valid_attributes

        put :update, {:id => product.to_param, :product => new_attributes}, valid_session
        product.reload

        expect(product.code).to eq(new_attributes[:code])
        expect(product.name).to eq(new_attributes[:name])
        expect(product.kind).to eq(new_attributes[:kind])
        expect(product.status).to eq(new_attributes[:status])
      end

      it "assigns the requested product as @product" do
        product = create :product, valid_attributes

        put :update, {:id => product.to_param, :product => valid_attributes}, valid_session

        expect(assigns(:product)).to eq(product)
      end

      it "redirects to the product" do
        product = create :product, valid_attributes

        put :update, {:id => product.to_param, :product => valid_attributes}, valid_session

        expect(response).to redirect_to(products_path)
      end
    end

    describe "with invalid params" do
      it "assigns the product as @product" do
        product = create :product, valid_attributes

        put :update, {:id => product.to_param, :product => invalid_attributes}, valid_session

        expect(assigns(:product)).to eq(product)
      end

      it "re-renders the 'edit' template" do
        product = create :product, valid_attributes

        put :update, {:id => product.to_param, :product => invalid_attributes}, valid_session

        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested product" do
      product = create :product, valid_attributes

      expect {
        delete :destroy, {:id => product.to_param}, valid_session
      }.to change(Product, :count).by(-1)
    end

    it "redirects to the products list" do
      product = create :product, valid_attributes

      delete :destroy, {:id => product.to_param}, valid_session

      expect(response).to redirect_to(products_path)
    end
  end

end

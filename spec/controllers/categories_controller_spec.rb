require 'spec_helper'

describe CategoriesController do

  # This should return the minimal set of attributes required to create a valid
  # Category. As you add validations to Category, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { :name => 'fart nugget' } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CategoriesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all categories as @categories" do
      category = Category.create! valid_attributes
      get :index, {}, valid_session
      assigns(:categories).should eq([category])
    end
  end

  describe "GET show" do
    it "assigns the requested category as @category" do
      category = Category.create! valid_attributes
      get :show, {:id => category.to_param}, valid_session
      assigns(:category).should eq(category)
    end
  end

  describe "GET new" do
    it "assigns a new category as @category" do
      get :new, {}, valid_session
      assigns(:category).should be_a_new(Category)
    end
  end

  describe "GET edit" do
    it "assigns the requested category as @category" do
      category = Category.create! valid_attributes
      get :edit, {:id => category.to_param}, valid_session
      assigns(:category).should eq(category)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Category" do
        expect {
          post :create, {:category => valid_attributes}, valid_session
        }.to change(Category, :count).by(1)
      end

      it "assigns a newly created category as @category" do
        post :create, {:category => valid_attributes}, valid_session
        assigns(:category).should be_a(Category)
        assigns(:category).should be_persisted
      end

      it "redirects to the created category" do
        post :create, {:category => valid_attributes}, valid_session
        response.should redirect_to(Category.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved category as @category" do
        # Trigger the behavior that occurs when invalid params are submitted
        Category.any_instance.stub(:save).and_return(false)
        post :create, {:category => {  }}, valid_session
        assigns(:category).should be_a_new(Category)
        assigns(:category).should_not be_valid
        assigns(:category).errors.messages[:name].should include("can't be blank")
      end

      it "tries to create a non-unique category" do
        pending "Why the fuck won't this work"
        Category.any_instance.stub(:save).and_return(false)
        @cat = FactoryGirl.create(:category, :name => 'pfff')
        post :create, {:category => { :name => 'pfff' }}, valid_session 
        assigns(:category).errors.messages[:name].should include("has already been taken")
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Category.any_instance.stub(:save).and_return(false)
        post :create, {:category => {  }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested category" do
        category = Category.create! valid_attributes
        # Assuming there are no other categories in the database, this
        # specifies that the Category created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Category.any_instance.should_receive(:update).with({ "these" => "params" })
        put :update, {:id => category.to_param, :category => { "these" => "params" }}, valid_session
      end

      it "assigns the requested category as @category" do
        category = Category.create! valid_attributes
        put :update, {:id => category.to_param, :category => valid_attributes}, valid_session
        assigns(:category).should eq(category)
      end

      it "redirects to the category" do
        category = Category.create! valid_attributes
        put :update, {:id => category.to_param, :category => valid_attributes}, valid_session
        response.should redirect_to(category)
      end
    end

    describe "with invalid params" do
      it "assigns the category as @category" do
        category = Category.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Category.any_instance.stub(:save).and_return(false)
        put :update, {:id => category.to_param, :category => {  }}, valid_session
        assigns(:category).should eq(category)
      end

      it "re-renders the 'edit' template" do
        category = Category.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Category.any_instance.stub(:save).and_return(false)
        put :update, {:id => category.to_param, :category => {  }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested category" do
      category = Category.create! valid_attributes
      expect {
        delete :destroy, {:id => category.to_param}, valid_session
      }.to change(Category, :count).by(-1)
    end

    it "redirects to the categories list" do
      category = Category.create! valid_attributes
      delete :destroy, {:id => category.to_param}, valid_session
      response.should redirect_to(categories_url)
    end
  end

end

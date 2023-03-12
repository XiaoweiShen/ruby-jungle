require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe 'Validations' do
    
      it 'should not exist data for new records' do
        @product = Product.new
        expect(@product.name).to be_nil
        expect(@product.price).to be_nil
        expect(@product.quantity).to be_nil
        expect(@product.category).to be_nil
      end
      it 'should exist data after create' do
      cat1 = Category.find_or_create_by! name: 'Test'
      @product = cat1.products.create!({
        name:  'test',
        description: "test-----------",
        image: 'plante_2.jpg',
        quantity: 18,
        price: 24.99
      })
      
      expect(@product.name).to be_present
      expect(@product.price).to be_present
      expect(@product.quantity).to be_present
      expect(@product.category).to be_present
      end
        
    #   it 'should be auto-assigned by AR for saved records' do
    #     @widget = Widget.new
    #     # we use bang here b/c we want our spec to fail if save fails (due to validations)
    #     # we are not testing for successful save so we have to assume it will be successful
    #     @widget.save!
    
    #     expect(@widget.id).to be_present
    #   end
    # end
    
    # # validation tests/examples here
  end
end

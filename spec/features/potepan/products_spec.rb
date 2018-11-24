require 'rails_helper'

RSpec.feature "Visiting Product Page", type: :feature do
  let!(:taxonomy) { create(:taxonomy, name: "Category") }
  let(:product) { create(:product) }

  scenario "visit index_page and show_page" do
    visit potepan_root_path
    click_link 'Home'
    expect(current_path).to eq potepan_index_path
    visit potepan_product_path(product.id)
    expect(current_path).to eq potepan_product_path(product.id)
    expect(page).to have_content(product.name)
    expect(page).to have_content(product.description)
    expect(page).to have_content(product.display_price)
  end
end

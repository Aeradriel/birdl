require 'spec_helper'
require 'rails_helper'

describe 'Admin country deletion button' do
  def sign_in(user)
    user.confirm
    visit '/login'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'login_submit'
  end

  context 'with existing country', js: true do
    before :each do
      @admin = FactoryGirl.create(:admin)
      FactoryGirl.create_list(:country, 5)

      sign_in @admin
      visit '/admin/countries/'
      all('#admin_country_list tr').each do |tr|
        next if tr.has_css?('th')
        tr.first('.admin_delete_button').click
        break
      end
    end

    it 'should display an alert to confirm the deletion' do
      expect(page.driver.browser.switch_to.alert).to_not eq nil
    end

    it 'should not delete account when cancelling deletion' do
      expect do
        page.driver.browser.switch_to.alert.dismiss
      end.to change(Country, :count).by 0
    end

    it 'should delete account when confirming deletion' do
      expect do
        page.driver.browser.switch_to.alert.accept
        visit '/'
      end.to change(Country, :count).by(-1)
    end
  end

  context 'with existing user' do
    it 'should display an error' do
      @controller = Admin::CountriesController
      @admin = FactoryGirl.create(:admin)

      pending 'Undefined ??'
      sign_in @admin
      delete :delete, user_id: -1
    end
  end
end

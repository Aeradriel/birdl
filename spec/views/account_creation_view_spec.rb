require 'spec_helper'
require 'rails_helper'

describe 'The account creation page' do
  before :each do
    visit '/users/sign_up'
  end

  it 'should contain an creation form' do
    expect(page).to have_css('#new_user')
  end

  it 'should contain an email field' do
    expect(page).to have_css('#user_email')
  end

  it 'should contain a first name field' do
    expect(page).to have_css('#user_first_name')
  end

  it 'should contain a last name field' do
    expect(page).to have_css('#user_last_name')
  end

  it 'should contain birth date field' do
    expect(page).to have_css('#user_birthdate_1i')
    expect(page).to have_css('#user_birthdate_2i')
    expect(page).to have_css('#user_birthdate_3i')
  end

  it 'should contain birth date field that cannot accept under 18 years old' do
    actual_year = Time.now.year - 18
    while actual_year > Time.now.year - 100
      expect(page.has_select?('user_birthdate_1i',
                              with_options: ["#{actual_year}"])).to eq true
      actual_year -= 1
    end
  end

  it 'should contain gender field' do
    expect(page).to have_css('#user_gender')
  end

  it 'should contain country field' do
    expect(page).to have_css('#user_country_id')
  end

  it 'should contain right countries' do
    FactoryGirl.create(:france)
    FactoryGirl.create(:england)
    FactoryGirl.create(:usa)
    FactoryGirl.create(:canada)

    visit '/users/sign_up'
    Country.all.each do |country|
      expect(page.has_select?('user_country_id',
                              with_options: ["#{country.name}"])).to eq true
    end
  end

  it 'should contain password field' do
    expect(page).to have_css('#user_password')
  end

  it 'should contain password confirmation field' do
    expect(page).to have_css('#user_password_confirmation')
  end

  it 'should contain submit button' do
    expect(page).to have_css('#new_submit')
  end

  it 'should contain a email confirmation link' do
    expect(page).to have_css('#email_confirmation_link')
  end
end

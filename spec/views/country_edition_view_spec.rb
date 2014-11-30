require 'spec_helper'
require 'rails_helper'

describe 'The admin country edition page' do
  def sign_in(user)
    user.confirm!
    visit '/login'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'login_submit'
  end

  before :each do
    @country = FactoryGirl.create(:france)
    @user = FactoryGirl.create(:admin)
    FactoryGirl.create(:england)
    FactoryGirl.create(:usa)
    FactoryGirl.create(:canada)
    @countries = Country.all.order(:name)

    sign_in @user
    visit '/admin/countries'
  end

  describe 'before choosing a country' do
    it 'should contain the countries list' do
      expect(page).to have_css('#admin_country_list')
    end

    it 'should contain pager when lots of entries' do
      pending 'Waiting for pager creation'
      expect(1).to eq 0
    end

    it 'should contain new country button' do
      expect(page).to have_css('.admin_new_button')
    end

    it 'should contain edition button on each row' do
      all('#admin_country_list tr').each do |tr|
        expect(tr).to have_css('.admin_edit_button') unless tr.has_css?('th')
      end
    end

    it 'should contain name that match with the country name' do
      i = 0

      all('#admin_country_list tr').each do |tr|
        if tr.has_css?('th') == false
          expect(tr.find('.country_name')).to have_content(@countries[i].name)
          i += 1
        end
      end
    end

    it 'should contain language that match with the country language' do
      i = 0

      all('#admin_country_list tr').each do |tr|
        next if tr.has_css?('th')
        l = @countries[i].language
        expect(tr.find('.country_language')).to have_content(l)
        i += 1
      end
    end

    it 'should contain flag path that match with the country\'s flag path' do
      i = 0

      all('#admin_country_list tr').each do |tr|
        next if tr.has_css?('th')
        @countries[i].flag_path.slice!('public/')
        fp = @countries[i].flag_path
        expect(tr.find('.country_flag_path')).to have_content(fp)
        i += 1
      end
    end

    it 'should contain user count that match with the country user count' do
      i = 0

      all('#admin_country_list tr').each do |tr|
        next if tr.has_css?('th')
        c = @countries[i].users.count
        expect(tr.find('.country_user_count')).to have_content(c)
        i += 1
      end
    end
  end

  describe 'when creating a country' do
    before :each do
      visit '/admin/countries/new'
    end

    it 'should contain edition form' do
      expect(page).to have_css('#new_country')
    end

    it 'should contain name field' do
      expect(page).to have_css('#country_name')
    end

    it 'should contain language field' do
      expect(page).to have_css('#country_language')
    end

    it 'should contain flag path field' do
      expect(page).to have_css('#country_flag_path')
    end

    it 'should contain submit button' do
      expect(page).to have_css('#new_submit')
    end
  end

  describe 'when editing a country' do
    before :each do
      visit "/admin/countries/#{Country.first.id}/edit"
    end

    it 'should contain edition form' do
      expect(page).to have_css('.edit_country')
    end

    it 'should contain name field' do
      expect(page).to have_css('#country_name')
    end

    it 'should contain language field' do
      expect(page).to have_css('#country_language')
    end

    it 'should contain flag path field' do
      expect(page).to have_css('#country_flag_path')
    end

    it 'should contain submit button' do
      expect(page).to have_css('#edit_submit')
    end
  end
end

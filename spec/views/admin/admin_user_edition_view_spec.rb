require 'spec_helper'
require 'rails_helper'

describe 'The admin user edition page' do
  def sign_in(user)
    user.confirm
    visit '/login'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'login_submit'
  end

  before :each do
    @country = FactoryGirl.create(:france)
    @user = FactoryGirl.create(:admin)
    FactoryGirl.create(:admin, country: @country)
    FactoryGirl.create(:user, country: @country)
    FactoryGirl.create(:user)

    sign_in @user
    visit '/admin/users'
  end

  describe 'before choosing a user' do
    it 'should contain the admin userlist' do
      expect(page).to have_css('#admin_adminlist')
    end

    it 'should contain the normal userlist' do
      expect(page).to have_css('#admin_userlist')
    end

    it 'should contain pager when lots of entries' do
      pending 'Waiting for pager creation'
      expect(1).to eq 0
    end

    it 'should contain new user button' do
      expect(page).to have_css('.admin_new_button')
    end

    it 'should contain edition button on each row for normal users' do
      all('#admin_adminlist tr').each do |tr|
        expect(tr).to have_css('.admin_edit_button') unless tr.has_css?('th')
      end
    end

    it 'should contain delete button on each row for normal users' do
      all('#admin_userlist tr').each do |tr|
        expect(tr).to have_css('.admin_delete_button') unless tr.has_css?('th')
      end
    end

    it 'should contain name that match with the user name' do
      users = User.where(admin: false).all
      admins = User.where(admin: true).all
      i = 0

      all('#admin_userlist tr').each do |tr|
        next if tr.has_css?('th')
        n = "#{users[i].first_name} #{users[i].last_name}"
        expect(tr.find('.user_name')).to have_content(n)
        i += 1
      end

      i = 0
      all('#admin_adminlist tr').each do |tr|
        next if tr.has_css?('th')
        n = "#{admins[i].first_name} #{admins[i].last_name}"
        expect(tr.find('.user_name')).to have_content(n)
        i += 1
      end
    end

    it 'should contain email that match with the user email' do
      users = User.where(admin: false).all
      admins = User.where(admin: true).all
      i = 0

      all('#admin_userlist tr').each do |tr|
        next if tr.has_css?('th')
        expect(tr.find('.user_email')).to have_content(users[i].email)
        i += 1
      end

      i = 0
      all('#admin_adminlist tr').each do |tr|
        next if tr.has_css?('th')
        expect(tr.find('.user_email')).to have_content(admins[i].email)
        i += 1
      end
    end

    it 'should contain birthdate that match with the user bitrhdate' do
      users = User.where(admin: false).all
      admins = User.where(admin: true).all
      i = 0

      all('#admin_userlist tr').each do |tr|
        next if tr.has_css?('th')
        b = "#{users[i].birthdate}"
        expect(tr.find('.user_birthdate')).to have_content(b)
        i += 1
      end

      i = 0
      all('#admin_adminlist tr').each do |tr|
        next if tr.has_css?('th')
        b = "#{admins[i].birthdate}"
        expect(tr.find('.user_birthdate')).to have_content(b)
        i += 1
      end
    end

    it 'should contain gender that match with the user gender' do
      users = User.where(admin: false).all
      admins = User.where(admin: true).all
      i = 0

      all('#admin_userlist tr').each do |tr|
        next if tr.has_css?('th')
        g = users[i].gender == 1 ? I18n.t(:male) : I18n.t(:female)
        expect(tr.find('.user_gender')).to have_content(g)
        i += 1
      end

      i = 0
      all('#admin_adminlist tr').each do |tr|
        next if tr.has_css?('th')
        g = admins[i].gender == 1 ? I18n.t(:male) : I18n.t(:female)
        expect(tr.find('.user_gender')).to have_content(g)
        i += 1
      end
    end

    it 'should contain language that match with user language' do
      u = User.where(admin: false).all
      a = User.where(admin: true).all
      i = 0

      all('#admin_userlist tr').each do |tr|
        next if tr.has_css?('th')
        if u[i].country
          expect(tr.find('.user_country')).to have_content(u[i].country.name)
        else
          expect(tr.find('.user_country')).to have_content(I18n.t(:unknown))
        end
        i += 1
      end

      i = 0
      all('#admin_adminlist tr').each do |tr|
        next if tr.has_css?('th')
        if a[i].country
          expect(tr.find('.user_country')).to have_content(a[i].country.name)
        else
          expect(tr.find('.user_country')).to have_content(I18n.t(:unknown))
        end
        i += 1
      end
    end
  end

  describe 'when creating a user' do
    before :each do
      visit '/admin/users/new'
    end

    it 'should contain edition form' do
      expect(page).to have_css('#new_user')
    end

    it 'should contain email field' do
      expect(page).to have_css('#user_email')
    end

    it 'should contain first name field' do
      expect(page).to have_css('#user_first_name')
    end

    it 'should contain last name field' do
      expect(page).to have_css('#user_last_name')
    end

    it 'should contain birth date field' do
      expect(page).to have_css('#user_birthdate_1i')
      expect(page).to have_css('#user_birthdate_2i')
      expect(page).to have_css('#user_birthdate_3i')
    end

    it 'should contain birth date field that cannot accept under 18 yo' do
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

    it 'should contain password field' do
      expect(page).to have_css('#user_password')
    end

    it 'should contain admin field' do
      expect(page).to have_css('#user_admin')
    end

    it 'should contain submit button' do
      expect(page).to have_css('#new_submit')
    end
  end

  describe 'when editing a user' do
    before :each do
      visit "/admin/users/#{User.first.id}/edit"
    end

    it 'should contain edition form' do
      expect(page).to have_css('.edit_user')
    end

    it 'should contain email field' do
      expect(page).to have_css('#user_email')
    end

    it 'should contain first name field' do
      expect(page).to have_css('#user_first_name')
    end

    it 'should contain last name field' do
      expect(page).to have_css('#user_last_name')
    end

    it 'should contain birth date field' do
      expect(page).to have_css('#user_birthdate_1i')
      expect(page).to have_css('#user_birthdate_2i')
      expect(page).to have_css('#user_birthdate_3i')
    end

    it 'should contain gender field' do
      expect(page).to have_css('#user_gender')
    end

    it 'should contain country field' do
      expect(page).to have_css('#user_country_id')
    end

    it 'should contain password field' do
      expect(page).to have_css('#user_password')
    end

    it 'should contain admin field' do
      expect(page).to have_css('#user_admin')
    end

    it 'should contain submit button' do
      expect(page).to have_css('#edit_submit')
    end
  end
end

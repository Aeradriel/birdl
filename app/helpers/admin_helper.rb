# Helpers for admin module
module AdminHelper
  def languages_datas
    group_languages =  {}
    Country.all.each do |country|
      group_languages[country.language] = country.users.count
    end
    group_languages
  end

  def genders_datas
    group_genders = { t(:male) => 0, t(:female) => 0 }
    User.all.each do |user|
      user.gender == 1 ? group_genders[t(:male)] += 1 :
          group_genders[t(:female)] += 1
    end
    group_genders
  end

  def save_flag(prms, flag_path)
    name = flag_path.original_filename
    directory = 'public/images/flags'
    path = File.join(directory, name)
    prms[:flag_path] = path
    return prms if File.open(path, 'wb') { |f| f.write(flag_path.read) }.nil?
    false
  end

  def save_badge_icon(prms, icon_path)
    name = icon_path.original_filename
    directory = 'public/images/badges'
    path = File.join(directory, name)
    prms[:icon_path] = path
    return prms if File.open(path, 'wb') { |f| f.write(icon_path.read) }.nil?
    false
  end
end

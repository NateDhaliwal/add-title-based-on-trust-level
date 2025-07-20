# frozen_string_literal: true

# name: add-title-based-on-trust-level
# about: TODO
# meta_topic_id: TODO
# version: 0.0.1
# authors: nateDhaliwal
# url: TODO
# required_version: 2.7.0

enabled_site_setting :add_title_based_on_trust_level_enabled

module ::AddTitleBasedOnTrustLevel
  PLUGIN_NAME = "add-title-based-on-trust-level"
end

# require_relative "lib/add_title_based_on_trust_level/engine"

after_initialize do
  on(:user_created) do |newuserdata|
    newuserid = newuserdata.id
    newuser = User.find_by(id: newuserid)
    tl0_title = SiteSettings.tl0_title_on_create
    newuser.title = tl0_title
    newuser.save!
  end
  
  on(:user_promoted) do |userdata|
    userid = userdata.id
    user = User.find_by(id: userid)
    tl1_title = SiteSettings.tl1_title_on_promotion
    tl2_title = SiteSettings.tl2_title_on_promotion
    tl3_title = SiteSettings.tl3_title_on_promotion
    tl4_title = SiteSettings.tl4_title_on_promotion

    if user.trust_level == 1 then
      user.title = tl1_title
      user.save!
    elsif user.trust_level == 2 then
      user.title = t12_title
      user.save!
    elsif user.trust_level == 3 then
      user.title = t13_title
      user.save!
    elsif user.trust_level == 4 then
      user.title = t14_title
      user.save!
    end
  end
end

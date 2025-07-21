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

require_relative "lib/add_title_based_on_trust_level/engine"

after_initialize do
  on(:user_created) do |newuserdata|
    newuserid = newuserdata[:user_id]
    newuser = User.find_by(id: newuserid)
    tl0_title = SiteSetting.tl0_title_on_create
    newuser.title = tl0_title
    newuser.save!
  end
  
  on(:user_promoted) do |userdata|
    userid = userdata[:user_id]
    user = User.find_by(id: userid)
    tl0_title = SiteSetting.tl0_title_on_create
    tl1_title = SiteSetting.tl1_title_on_promotion
    tl2_title = SiteSetting.tl2_title_on_promotion
    tl3_title = SiteSetting.tl3_title_on_promotion
    tl4_title = SiteSetting.tl4_title_on_promotion
    puts user.trust_level
    if user.trust_level == 0 then
      user.title = tl0_title
      user.save!
    elsif user.trust_level == 1 then
      user.title = tl1_title
      user.save!
    elsif user.trust_level == 2 then
      user.title = tl2_title
      user.save!
    elsif user.trust_level == 3 then
      user.title = tl3_title
      user.save!
    elsif user.trust_level == 4 then
      user.title = tl4_title
      user.save!
    end
  end
end

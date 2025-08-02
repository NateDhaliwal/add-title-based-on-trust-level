module AddTitleBasedOnTrustLevel
  class UpdateTitles < ::Jobs::Scheduled
    every 12.hours # Run twice a day

    def execute(args)
      tl0_title = SiteSetting.tl0_title_on_create
      tl1_title = SiteSetting.tl1_title_on_promotion
      tl2_title = SiteSetting.tl2_title_on_promotion
      tl3_title = SiteSetting.tl3_title_on_promotion
      User.where(trust_level: 0).update_all(title: tl0_title)
      User.where(trust_level: 1).update_all(title: tl1_title)
      User.where(trust_level: 2).update_all(title: tl2_title)
      User.where(trust_level: 3).update_all(title: tl3_title)
    end
end

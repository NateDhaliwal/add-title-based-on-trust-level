# frozen_string_literal: true

module AddTitleBasedOnTrustLevel
  class UpdateTitles < ::Jobs::Scheduled
    every SiteSetting.update_title_frequency.hours # Run based on site setting

    def execute(args)
      tl0_title = SiteSetting.tl0_title_on_create
      tl1_title = SiteSetting.tl1_title_on_promotion
      tl2_title = SiteSetting.tl2_title_on_promotion
      tl3_title = SiteSetting.tl3_title_on_promotion
      tl4_title = SiteSetting.tl4_title_on_promotion
      User.where(trust_level: 0).update_all(title: tl0_title) if tl0_title != ""
      User.where(trust_level: 1).update_all(title: tl1_title) if tl1_title != ""
      User.where(trust_level: 2).update_all(title: tl2_title) if tl2_title != ""
      User.where(trust_level: 3).update_all(title: tl3_title) if tl3_title != ""
      User.where(trust_level: 4).update_all(title: tl4_title) if tl4_title != ""

      trust_levels = [0, 1, 2, 3, 4]
      if SiteSetting.add_primary_group_title
        trust_levels.each do |tl| 
          DB.exec(<<~SQL, tl)
            UPDATE users
            SET title = groups.name
            FROM groups
            WHERE users.primary_group_id = groups.id
              AND users.trust_level = ?
              AND users.primary_group_id IS NOT NULL;
          SQL
        end
        # Append the TL text
        User.where(trust_level: 0).update_all("title = title || ' #{tl0_title}'") if tl0_title != ""
        User.where(trust_level: 1).update_all("title = title || ' #{tl1_title}'") if tl1_title != ""
        User.where(trust_level: 2).update_all("title = title || ' #{tl2_title}'") if tl2_title != ""
        User.where(trust_level: 3).update_all("title = title || ' #{tl3_title}'") if tl3_title != ""
        User.where(trust_level: 4).update_all("title = title || ' #{tl4_title}'") if tl4_title != ""
      end
    end
  end
end

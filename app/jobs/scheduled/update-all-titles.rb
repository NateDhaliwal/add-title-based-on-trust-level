module FindTopicsToReset
  class FindTopics < ::Jobs::Scheduled
    every 12.hours # Run twice a day

    def execute(args)
      User.where(trust_level: 0).update_all(title: tl0_title)
      User.where(trust_level: 1).update_all(title: tl1_title)
      User.where(trust_level: 2).update_all(title: tl2_title)
      User.where(trust_level: 3).update_all(title: tl3_title)
    end
end

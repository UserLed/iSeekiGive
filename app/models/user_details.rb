class UserDetails

  def self.update_user_profile(hash, user)
    unless user.linkedin_update
      user_info = hash[:user_info]
      set_user_skills(user_info["skills"], user)
      set_user_educations(user_info["educations"], user)
      set_user_experiences(user_info["positions"], user)
      user.linkedin_update = true
      user.save
    end
  end

  def self.update_user_social_info(user_social_data, user)
    set_user_skills(user_social_data["skills"], user)
    set_user_educations(user_social_data["educations"], user)
    set_user_experiences(user_social_data["positions"], user)

  end

  private

  def self.set_user_skills(hash, user)
    hash.vine("values").each do |v|
      if v["skill"].present? and v["skill"]["name"].present?
       unless Tag.record_exists?(v["skill"]["name"])
         user.skills.create(:name => v["skill"]["name"])
        user.tags.create(:name => v["skill"]["name"])
       else
       end
      end
    end

  end

  def self.set_user_educations(hash, user)
    hash.vine("values").each do |v|
      e = user.educations.new
      e.school_name = v["schoolName"]
      e.start_date = Date.strptime(v["startDate"]["year"].to_s, "%Y") if v["startDate"].present?
      e.end_date = Date.strptime(v["endDate"]["year"].to_s, "%Y") if v["endDate"].present?
      e.degree = v["degree"]
      e.field_of_study = v["fieldOfStudy"]
      unless  Education.record_exists?(e)
        e.save
        user.tags.create(:name => e.school_name)
        user.tags.create(:name => e.field_of_study)
        user.tags.create(:name => e.degree)
      end
    end
  end

  def self.set_user_experiences(hash, user)
    hash.vine("values").each do |v|
      e = user.experiences.new
      e.title = v["title"]
      e.company_name = v["company"]["name"] if v["company"].present?
      e.start_date = Date.strptime(v["startDate"]["month"].to_s + " " +v["startDate"]["year"].to_s, "%m %Y") if v["startDate"].present?
      if v["isCurrent"].present? and v["isCurrent"]
        e.end_date = nil
      else
        e.end_date = Date.strptime(v["endDate"]["month"].to_s + " " +v["endDate"]["year"].to_s, "%m %Y") if v["endDate"].present?
      end
      unless  Experience.record_exists(e)
        e.save
        user.tags.create(:name => e.company_name)
        user.tags.create(:name => e.title)
      end
    end
  end
end
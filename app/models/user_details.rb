class UserDetails
  
  def self.update_user_profile(hash, user)
    unless user.linkedin_update
      user_info = hash[:user_info]
      set_user_educations(user_info["educations"], user) 
      set_user_experiences(user_info["positions"], user) 
      set_user_skills(user_info["skills"], user)         
      user.linkedin_update = true
      user.save
    end
  end

  private

  def self.set_user_skills(hash, user)
    hash.vine("values").each do |v|
      if v["skill"].present? and v["skill"]["name"].present?
        user.skills.create(:name => v["skill"]["name"])
        user.tags.create(:name => v["skill"]["name"])
      end
    end

    education_school_tags = user.educations.collect(&:school_name)
    education_school_tags.each do |tag|
      user.tags.create(:name => tag)
    end
    education_study_field_tags = user.educations.collect(&:field_of_study).uniq
    education_study_field_tags.each do |tag|
      user.tags.create(:name => tag)
    end

    experience_degree_tags = user.educations.collect(&:degree).uniq
    experience_degree_tags.each do |tag|
      user.tags.create(:name => tag)
    end
    
    experience_company_tags = user.experiences.collect(&:company_name)
    experience_company_tags.each do |tag|
      user.tags.create(:name => tag)
    end

    experience_title_tags = user.experiences.collect(&:title).uniq
    experience_title_tags.each do |tag|
      user.tags.create(:name => tag)
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
      e.save
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
      e.save
    end
  end
end
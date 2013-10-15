class UserDetails

  def self.update_user_profile(hash, user, provider)
    if provider.eql?("linkedin")
      user_info = hash[:user_info]
      update_educations(user_info["educations"], user)
      update_experiences(user_info["positions"], user)
      update_languages(user_info["languages"], user)
      update_skills(user_info["skills"], user)
      update_date_of_birth(user_info, user)
    end
  end

  private

  def self.update_educations(hash, user)
    hash.vine("values").each do |v|
      education = user.educations.find_by_linkedin_id(v["id"])
      education = user.educations.new if education.blank?
      education.school_name = v["schoolName"]
      education.start_date = Date.strptime(v["startDate"]["year"].to_s, "%Y") if v["startDate"].present?
      education.end_date = Date.strptime(v["endDate"]["year"].to_s, "%Y") if v["endDate"].present?
      education.degree = v["degree"]
      education.field_of_study = v["fieldOfStudy"]
      education.linkedin_id = v["id"]
      education.save

      [:school_name, :degree, :field_of_study].each do |attr|
        tag = user.tags.find_by_linkedin_id_and_linkedin_data_type(v["id"], attr.to_s)
        tag = user.tags.new if tag.blank?
        tag.name = education.send(attr)
        tag.linkedin_id = v["id"]
        tag.linkedin_data_type = attr.to_s
        tag.save
      end
    end
    ids = hash.vine("values").collect{|v| v["id"]}
    deleted_educations = user.educations.where("linkedin_id not in (?)", ids)
    deleted_educations.each{ |e| e.destroy }
  end

  def self.update_experiences(hash, user)
    hash.vine("values").each do |v|
      experience = user.experiences.find_by_linkedin_id(v["id"])
      experience = user.experiences.new if experience.blank?
      experience.title = v["title"]
      experience.company_name = v["company"]["name"] if v["company"].present?
      experience.start_date = Date.strptime(v["startDate"]["month"].to_s + " " +v["startDate"]["year"].to_s, "%m %Y") if v["startDate"].present?
      if v["isCurrent"].present? and v["isCurrent"]
        experience.end_date = nil
      else
        experience.end_date = Date.strptime(v["endDate"]["month"].to_s + " " +v["endDate"]["year"].to_s, "%m %Y") if v["endDate"].present?
      end
      experience.linkedin_id = v["id"]
      experience.save

      [:title, :company_name].each do |attr|
        tag = user.tags.find_by_linkedin_id_and_linkedin_data_type(v["id"], attr.to_s)
        tag = user.tags.new if tag.blank?
        tag.name = experience.send(attr)
        tag.linkedin_id = v["id"]
        tag.linkedin_data_type = attr.to_s
        tag.save
      end
    end
    ids = hash.vine("values").collect{|v| v["id"]}
    deleted_experiences = user.experiences.where("linkedin_id not in (?)", ids)
    deleted_experiences.each{ |e| e.destroy }
  end

  def self.update_languages(hash, user)
    hash.vine("values").each do |v|
      language = user.languages.find_by_linkedin_id(v["id"])
      language = user.languages.new if language.blank?
      language.name = v["language"]["name"]
      language.linkedin_id = v["id"]
      language.save
    end
    ids = hash.vine("values").collect{|v| v["id"]}
    deleted_languages = user.languages.where("linkedin_id not in (?)", ids)
    deleted_languages.each{ |l| l.destroy }
  end

  def self.update_skills(hash, user)
    hash.vine("values").each do |v|
      tag = user.tags.find_by_linkedin_id_and_linkedin_data_type(v["id"], "skill")
      tag = user.tags.new if tag.blank?
      tag.name = v["skill"]["name"]
      tag.linkedin_id = v["id"]
      tag.linkedin_data_type = "skill"
      tag.save
    end
  end

  def self.update_date_of_birth(user_info, user)
    if user.date_of_birth.blank? and user_info["dateOfBirth"].present?
      b = user_info["dateOfBirth"]
      user.date_of_birth = "#{b['year']}-#{b['month']}-#{b['day']}"
      user.save
    end
  end
end
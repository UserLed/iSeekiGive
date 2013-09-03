class UserDetails
  
  def self.update_user_profile(hash, user)
    user_info = hash[:user_info]
    set_user_skills(user_info["skills"], user)
    set_user_educations(user_info["educations"], user)
    set_user_experiences(user_info["positions"], user)
  end

  private
  
  def self.user_hash(provider)
    @provider = Config.send(provider)
    @provider.get_user_hash
  end

  def self.set_user_skills(hash, user)
    hash.vine("values").each do |v|
      s = user.skills.new
      s.name = v["skill"]["name"]
      s.save
    end
  end

  def self.set_user_educations(hash, user)
    hash.vine("values").each do |v|
      e = user.educations.new
      e.school_name = v["schoolName"]
      e.start_date = Date.strptime(v["startDate"]["year"].to_s, "%Y")
      e.end_date = Date.strptime(v["endDate"]["year"].to_s, "%Y")
      e.degree = v["degree"]
      e.field_of_study = v["fieldOfStudy"]
      e.save
    end
  end

  def self.set_user_experiences(hash, user)
    hash.vine("values").each do |v|
      e = user.experiences.new
      e.title = v["title"]
      e.company_name = v["company"]["name"]
      e.start_date = Date.strptime(v["startDate"]["month"].to_s + " " +v["startDate"]["year"].to_s, "%m %Y")
      if v["isCurrent"] == true
        e.end_date = nil
      else
        e.end_date = Date.strptime(v["endDate"]["month"].to_s + " " +v["endDate"]["year"].to_s, "%m %Y")
      end
      e.save
    end
  end
end
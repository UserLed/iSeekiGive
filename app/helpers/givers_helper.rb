module GiversHelper

	def detect_class(giver_id,time_slot)
		giver = Giver.find(giver_id)
		giver_schedules = giver.schedules.pluck("schedule_time")
		giver_time_slots = TimeSlot.where("giver_id=?",giver_id).select("day,time,time_format")
		if giver_schedules.include?(time_slot)
			"selected_already"
		elsif 
			giver_time_slots = giver_time_slots.collect{|slot| [slot.day, slot.time,slot.time_format].join("_")}
			if giver_time_slots.include?(time_slot)
				"selected"
				
			end
		end
	end
end
		  	  


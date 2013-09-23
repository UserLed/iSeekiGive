module GiversHelper

	def detect_class(giver_id,time_slot)
		giver = Giver.find(giver_id)
		giver_schedules = giver.schedules.pluck("schedule_time")
		giver_schedules_status = giver.schedules.pluck("status")
		giver_time_slots = TimeSlot.where("giver_id=?",giver_id).select("day,time,time_format")
		if giver_schedules.include?(time_slot)
			schedule_index = giver_schedules.index(time_slot)
			schedule_index_status = giver_schedules_status[schedule_index]
			if schedule_index_status.eql?("pending")
				"schedule_pending"
			else
				"schedule_reserved"
			end
		else 
			giver_time_slots = giver_time_slots.collect{|slot| [slot.day, slot.time,slot.time_format].join("_")}
			if giver_time_slots.include?(time_slot)
				"selected"
				
			end
		end
	end
end
		  	  


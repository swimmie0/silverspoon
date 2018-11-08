class NewAlarmsController < ApplicationController
    def index
        @new_alarms = current_user.new_alarms.unread_by(current_user)
    end
    
    def show
        @new_alarm = NewAlarm.find(params[:id])
        @new_alarm.mark_as_read! for: current_user
        redirect_to @new_alarm.link
    end
      
    def read_all
        current_user.new_alarms.mark_as_read! :all, for: current_user
        redirect_back fallback_location: root_path
    end
end
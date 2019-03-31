module Api
  module V1
    class ApiController < ApplicationController

      def candidate_schedules
        # curl -X GET http://localhost:3000/api/v1/candidate_schedules/?count=2
        count = params[:count].to_i
        schedules = get_schedules

        if (count == 0)
          render json: {
            status: 'ERROR',
            message: 'Search param \'count\' must be greater than 0'
          }, status: 400
        else
          render json: {
            status: 'SUCCESS',
            message: 'Found ' + count.to_s + ' slots for job candidate',
            data: schedules[0,count]
          }, status: 200
        end
      end

      def schedule_interview
        # curl -X POST -d "{"slot_id":"1","selected_time":"2019-03-31T19:27:07.632Z"}" http://localhost:3000/api/v1/schedule_interview
        slotId = params[:slot_id]
        selected_interview_time = params[:selected_time].to_s
        interview_time_start = selected_interview_time.to_time # rails helper to cast String to Time
        interview_time_end = interview_time_start+30.minutes # rails helper to add time to Time obj

        schedules = get_schedules
        slot = schedules.find {|x| x['slot_id'] == slotId.to_i} #find slot the user has selected
        availability_time_start = slot['availability'].to_time
        availability_time_end = availability_time_start + 2.hours

        # compare slot times with users interview time
        if (selected_time_end > availability_time_end && selected_time_start > availability_time_start)
          render json: {
            status: 'ERROR',
            message: 'Bad Request: The slot you selected is not available'
          }, status: 400
          # short circuit execution
          return
        end

        diff_in_minutes = TimeDifference.between(selected_time_end.to_s, availability_time_end.to_s).in_minutes
        # 120 minute slot - interview 30 minutes => 90 min differential
        if (diff_in_minutes > 90)
            render json: {
              status: 'ERROR',
              message: 'Bad Request: The slot you selected is not available',
              selected_time_start:  selected_time_start.to_s,
              availability_time_end: availability_time_end.to_s,
              diff_minutes: diff_in_minutes.to_s
            }, status: 400
          else
            render json: {
              status: 'SUCCESS',
              message: 'diff_minutes: ' + diff_in_minutes.to_s,
              data: slot
            }, status: 200
        end
      end

      private
      def get_schedules
        # fake database seed
        return [
          {'slot_id' => 1, 'availability' => Time.new(2019, 4, 2, 8, 00, 00, "-05:00").utc.iso8601},
          {'slot_id' => 2, 'availability' => Time.new(2019, 4, 2, 12, 00, 00, "-05:00").utc.iso8601},
          {'slot_id' => 3, 'availability' => Time.new(2019, 4, 2, 14, 00, 00, "-05:00").utc.iso8601},
          {'slot_id' => 4, 'availability' => Time.new(2019, 4, 3, 9, 00, 00, "-05:00").utc.iso8601},
          {'slot_id' => 5, 'availability' => Time.new(2019, 4, 3, 12, 00, 00, "-05:00").utc.iso8601},
          {'slot_id' => 6, 'availability' => Time.new(2019, 4, 3, 15, 00, 00, "-05:00").utc.iso8601},
          {'slot_id' => 7, 'availability' => Time.new(2019, 4, 4, 9, 00, 00, "-05:00").utc.iso8601},
          {'slot_id' => 8, 'availability' => Time.new(2019, 4, 4, 12, 00, 00, "-05:00").utc.iso8601},
          {'slot_id' => 9, 'availability' => Time.new(2019, 4, 4, 16, 00, 00, "-05:00").utc.iso8601},
          {'slot_id' => 10, 'availability' => Time.new(2019, 4, 5, 8, 00, 00, "-05:00").utc.iso8601},
          {'slot_id' => 11, 'availability' => Time.new(2019, 4, 5, 12, 00, 00, "-05:00").utc.iso8601},
          {'slot_id' => 12, 'availability' => Time.new(2019, 4, 5, 15, 00, 00, "-05:00").utc.iso8601},
          {'slot_id' => 13, 'availability' => Time.new(2019, 4, 8, 10, 00, 00, "-05:00").utc.iso8601},
          {'slot_id' => 14, 'availability' => Time.new(2019, 4, 8, 15, 00, 00, "-05:00").utc.iso8601},
          {'slot_id' => 15, 'availability' => Time.new(2019, 4, 9, 11, 00, 00, "-05:00").utc.iso8601},
          {'slot_id' => 16, 'availability' => Time.new(2019, 4, 9, 15, 00, 00, "-05:00").utc.iso8601},
          {'slot_id' => 17, 'availability' => Time.new(2019, 4, 10, 8, 00, 00, "-05:00").utc.iso8601}
        ]
      end
    end
  end
end

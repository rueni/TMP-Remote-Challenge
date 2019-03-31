module Api
  module V1
    class ApiController < ApplicationController
      # curl -X GET http://localhost:3000/api/v1/candidate_schedules/?count=2
      def candidate_schedules
        count = params[:count].to_i
        schedules = [
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
      end

    end
  end
end
